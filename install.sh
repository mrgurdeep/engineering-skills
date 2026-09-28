#!/usr/bin/env bash
# Engineering Skills installer — macOS / Linux (Git Bash on Windows is handed to install.ps1)
#
#   curl -fsSL https://raw.githubusercontent.com/mrgurdeep/engineering-skills/main/install.sh | bash
#   curl -fsSL .../install.sh | bash -s -- --dir ~/work/engineering-skills
#   curl -fsSL .../install.sh | bash -s -- --uninstall
#
# One copy only: the hub is cloned ONCE; everything else is a link or a reference to it.
#   ~/engineering-skills/src/skills/      the hub clone (the only copy of the skills)
#   ~/.config/engineering-skills/         config.yaml (workspace path) + browser-profile (login session)
#   ~/.claude/skills/<skill>  -> hub      symlinks; read by Claude Code AND VS Code Copilot
#   ~/.claude/CLAUDE.md                   one line: @<hub>/src/AGENTS.md  (import, not a copy)
#   ENG_SKILLS_HOME                       exported in ~/.zshrc / ~/.bashrc
#   MCP "eng-browser"                     Playwright browser registered at user level in Claude Code and VS Code
#
# Options: --dir <path>  --branch <name>  --no-mcp  --uninstall
set -euo pipefail

REPO_URL="${ENG_SKILLS_REPO:-https://github.com/mrgurdeep/engineering-skills.git}"
RAW_URL="${ENG_SKILLS_RAW:-https://raw.githubusercontent.com/mrgurdeep/engineering-skills}"
HUB="${ENG_SKILLS_HOME:-$HOME/engineering-skills}"
BRANCH="main"; UNINSTALL=0; MCP=1
CLAUDE_DIR="$HOME/.claude"
MARK_BEGIN="# >>> engineering-skills >>>"; MARK_END="# <<< engineering-skills <<<"
MCP_NAME="eng-browser"

ARGS=("$@")
while [ $# -gt 0 ]; do
  case "$1" in
    --dir) HUB="$2"; shift 2;;
    --branch) BRANCH="$2"; shift 2;;
    --no-mcp) MCP=0; shift;;
    --uninstall) UNINSTALL=1; shift;;
    -h|--help) grep '^#' "$0" 2>/dev/null | sed 's/^# \{0,1\}//' || true; exit 0;;
    *) echo "Unknown option: $1" >&2; exit 1;;
  esac
done

say()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*" >&2; }

# ---- Windows (Git Bash / MSYS / Cygwin): real links need junctions -> use PowerShell installer
case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*)
    say "Windows detected — running install.ps1"
    PS_ARGS=()
    [ "$UNINSTALL" = 1 ] && PS_ARGS+=(-Uninstall)
    [ "$MCP" = 0 ] && PS_ARGS+=(-NoMcp)
    PS_ARGS+=(-Branch "$BRANCH")
    [ -n "${HUB:-}" ] && PS_ARGS+=(-Dir "$(cygpath -w "$HUB" 2>/dev/null || echo "$HUB")")
    TMP_PS="$(mktemp -t eng-skills-XXXX).ps1"
    curl -fsSL "$RAW_URL/$BRANCH/install.ps1" -o "$TMP_PS"
    exec powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(cygpath -w "$TMP_PS" 2>/dev/null || echo "$TMP_PS")" "${PS_ARGS[@]}"
    ;;
esac

remove_block() { # delete our marked block from a file (keeps everything else)
  [ -f "$1" ] || return 0
  awk -v b="$MARK_BEGIN" -v e="$MARK_END" '$0==b{s=1;next} $0==e{s=0;next} !s' "$1" > "$1.eng-tmp" && mv "$1.eng-tmp" "$1"
}
add_block() { # add_block <file> <content>
  touch "$1"; remove_block "$1"
  printf '%s\n%s\n%s\n' "$MARK_BEGIN" "$2" "$MARK_END" >> "$1"
}
find_code() {
  command -v code 2>/dev/null && return 0
  for c in "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" \
           "$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"; do
    [ -x "$c" ] && { echo "$c"; return 0; }
  done
  return 1
}

# ---------------------------------------------------------------- uninstall
if [ "$UNINSTALL" = 1 ]; then
  say "Removing skill links from $CLAUDE_DIR/skills"
  for l in "$CLAUDE_DIR"/skills/*; do
    [ -L "$l" ] || continue
    case "$(readlink "$l")" in "$HUB"/*) rm "$l"; echo "  - $(basename "$l")";; esac
  done
  for f in "$CLAUDE_DIR/CLAUDE.md" "$HOME/.zshrc" "$HOME/.bashrc"; do remove_block "$f"; done
  if [ "$MCP" = 1 ] && command -v claude >/dev/null 2>&1; then claude mcp remove -s user "$MCP_NAME" >/dev/null 2>&1 || true; fi
  say "Done. The hub clone is still at $HUB (delete it yourself if you no longer need it)."
  say "VS Code: remove the '$MCP_NAME' server via Command Palette → 'MCP: List Servers' if you added it."
  exit 0
fi

# ---------------------------------------------------------------- 1. hub (the only copy)
command -v git >/dev/null 2>&1 || { echo "git is required (macOS: xcode-select --install)" >&2; exit 1; }
if [ -d "$HUB/.git" ]; then
  say "Updating hub at $HUB"
  git -C "$HUB" fetch --quiet origin "$BRANCH"
  git -C "$HUB" checkout --quiet "$BRANCH"
  git -C "$HUB" pull --ff-only --quiet origin "$BRANCH" || warn "Hub has local changes; not fast-forwarded."
elif [ -e "$HUB" ] && [ -n "$(ls -A "$HUB" 2>/dev/null)" ]; then
  echo "$HUB exists and is not a git clone. Use --dir to pick another location." >&2; exit 1
else
  say "Cloning $REPO_URL → $HUB"
  git clone --quiet --branch "$BRANCH" "$REPO_URL" "$HUB"
fi
HUB="$(cd "$HUB" && pwd)"
[ -f "$HUB/src/skills/sdlc-orchestrator/SKILL.md" ] || { echo "Hub looks incomplete: $HUB" >&2; exit 1; }

# ---------------------------------------------------------------- 2. link skills (no copies)
mkdir -p "$CLAUDE_DIR/skills"
say "Linking skills into $CLAUDE_DIR/skills (Claude Code + VS Code Copilot)"
for s in "$HUB"/src/skills/*/; do
  name="$(basename "$s")"; dest="$CLAUDE_DIR/skills/$name"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then warn "skip $name — a real folder with that name exists"; continue; fi
  ln -sfn "${s%/}" "$dest"; echo "  + $name"
done
# prune links to skills that were removed from the hub
for l in "$CLAUDE_DIR"/skills/*; do
  [ -L "$l" ] && [ ! -e "$l" ] && case "$(readlink "$l")" in "$HUB"/*) rm "$l"; echo "  - $(basename "$l") (removed upstream)";; esac
done

# ---------------------------------------------------------------- 3. rules by reference + env var
add_block "$CLAUDE_DIR/CLAUDE.md" "@$HUB/src/AGENTS.md"
for rc in "$HOME/.zshrc" "$HOME/.bashrc"; do
  { [ -f "$rc" ] || [ "$(basename "$rc")" = ".zshrc" -a "$(uname -s)" = "Darwin" ]; } && add_block "$rc" "export ENG_SKILLS_HOME=\"$HUB\""
done

# ---------------------------------------------------------------- 4. browser MCP at user level
if [ "$MCP" = 1 ]; then
  CONF_DIR="$HOME/.config/engineering-skills"; mkdir -p "$CONF_DIR"
  PROFILE="$CONF_DIR/browser-profile"
  if command -v claude >/dev/null 2>&1; then
    claude mcp remove -s user "$MCP_NAME" >/dev/null 2>&1 || true
    if claude mcp add -s user "$MCP_NAME" -- npx -y @playwright/mcp@latest --user-data-dir "$PROFILE" >/dev/null 2>&1; then
      say "Registered MCP '$MCP_NAME' in Claude Code (user scope)"
    else
      warn "Claude Code MCP registration failed. Run: claude mcp add -s user $MCP_NAME -- npx -y @playwright/mcp@latest --user-data-dir \"$PROFILE\""
    fi
  else
    warn "Claude Code CLI not found — skipped its MCP registration (re-run after installing)."
  fi
  if CODE="$(find_code)"; then
    "$CODE" --add-mcp "{\"name\":\"$MCP_NAME\",\"command\":\"npx\",\"args\":[\"-y\",\"@playwright/mcp@latest\",\"--user-data-dir\",\"$PROFILE\"]}" >/dev/null 2>&1 \
      && say "Registered MCP '$MCP_NAME' in VS Code (user profile)" || warn "VS Code MCP registration failed — see 'Browser & login' in the README"
  else
    warn "VS Code 'code' CLI not found — skipped VS Code MCP registration (see 'Browser & login' in the README)."
  fi
  command -v npx >/dev/null 2>&1 || warn "Node.js/npx not found — install Node 18+ for the browser (Jira/Confluence/Figma)."
fi

cat <<DONE

✅ Engineering skills installed — single copy at: $HUB
   $(ls -d "$HUB"/src/skills/*/ | wc -l | tr -d ' ') skills linked in $CLAUDE_DIR/skills  ·  rules: @$HUB/src/AGENTS.md

Next:
  1. Open VS Code and run any skill — first run asks for your team workspace, projects and git repos
  2. Open a new terminal first (for ENG_SKILLS_HOME)
  3. Claude Code: "start the SDLC"  ·  Copilot chat: /sdlc-orchestrator
  Update: re-run this command (git pull in the hub; links pick it up instantly).
DONE
