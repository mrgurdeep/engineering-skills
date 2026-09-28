<#
Engineering Skills installer - Windows (PowerShell 5.1+ / PowerShell 7)

  irm https://raw.githubusercontent.com/mrgurdeep/engineering-skills/main/install.ps1 | iex
  & ([scriptblock]::Create((irm https://raw.githubusercontent.com/mrgurdeep/engineering-skills/main/install.ps1))) -Dir D:\work\engineering-skills
  & ([scriptblock]::Create((irm https://raw.githubusercontent.com/mrgurdeep/engineering-skills/main/install.ps1))) -Uninstall

One copy only: the hub is cloned ONCE; everything else is a link or a reference to it.
  %USERPROFILE%\engineering-skills\src\skills  the hub clone (the only copy of the skills)
  %USERPROFILE%\.config\engineering-skills\     config.yaml (workspace path) + browser-profile (login session)
  %USERPROFILE%\.claude\skills\<skill>  -> hub  directory junctions (no admin needed); read by Claude Code AND VS Code Copilot
  %USERPROFILE%\.claude\CLAUDE.md              one line: @<hub>/src/AGENTS.md  (import, not a copy)
  ENG_SKILLS_HOME                              user environment variable
  MCP "eng-browser"                            Playwright browser registered at user level in Claude Code and VS Code
#>
[CmdletBinding()]
param(
  [string]$Dir = $(if ($env:ENG_SKILLS_HOME) { $env:ENG_SKILLS_HOME } else { Join-Path $HOME 'engineering-skills' }),
  [string]$Branch = 'main',
  [switch]$NoMcp,
  [switch]$Uninstall
)
$ErrorActionPreference = 'Stop'
$RepoUrl   = if ($env:ENG_SKILLS_REPO) { $env:ENG_SKILLS_REPO } else { 'https://github.com/mrgurdeep/engineering-skills.git' }
$ClaudeDir = Join-Path $HOME '.claude'
$SkillsDir = Join-Path $ClaudeDir 'skills'
$MarkBegin = '# >>> engineering-skills >>>'; $MarkEnd = '# <<< engineering-skills <<<'
$McpName   = 'eng-browser'

function Say($m)  { Write-Host "==> $m" -ForegroundColor Cyan }
function Warn($m) { Write-Host "!!  $m" -ForegroundColor Yellow }

function Remove-Block([string]$File) {
  if (-not (Test-Path $File)) { return }
  $out = New-Object System.Collections.Generic.List[string]; $skip = $false
  foreach ($l in [System.IO.File]::ReadAllLines($File)) {
    if ($l -eq $MarkBegin) { $skip = $true; continue }
    if ($l -eq $MarkEnd)   { $skip = $false; continue }
    if (-not $skip) { $out.Add($l) }
  }
  [System.IO.File]::WriteAllLines($File, $out)
}
function Add-Block([string]$File, [string]$Content) {
  if (-not (Test-Path $File)) { New-Item -ItemType File -Path $File -Force | Out-Null }
  Remove-Block $File
  $lines = @([System.IO.File]::ReadAllLines($File)) + @($MarkBegin, $Content, $MarkEnd)
  [System.IO.File]::WriteAllLines($File, [string[]]$lines)   # UTF-8 without BOM on PS 5.1 and 7
}
function Get-LinkTarget($Path) {
  $i = Get-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
  if ($i -and $i.LinkType) { return [string]($i.Target | Select-Object -First 1) }
  return $null
}
function Remove-Link($Path) { cmd /c rmdir "`"$Path`"" | Out-Null }   # removes the junction only, never the target
function Find-Code {
  $c = Get-Command code.cmd -ErrorAction SilentlyContinue; if ($c) { return $c.Source }
  foreach ($p in @("$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd", "$env:ProgramFiles\Microsoft VS Code\bin\code.cmd")) {
    if (Test-Path $p) { return $p }
  }
  return $null
}

# ------------------------------------------------------------------ uninstall
if ($Uninstall) {
  $hubFull = [System.IO.Path]::GetFullPath($Dir)
  Say "Removing skill links from $SkillsDir"
  if (Test-Path $SkillsDir) {
    Get-ChildItem -LiteralPath $SkillsDir -Force | ForEach-Object {
      $t = Get-LinkTarget $_.FullName
      if ($t -and $t.StartsWith($hubFull, [System.StringComparison]::OrdinalIgnoreCase)) { Remove-Link $_.FullName; Write-Host "  - $($_.Name)" }
    }
  }
  Remove-Block (Join-Path $ClaudeDir 'CLAUDE.md')
  [Environment]::SetEnvironmentVariable('ENG_SKILLS_HOME', $null, 'User')
  if (-not $NoMcp -and (Get-Command claude -ErrorAction SilentlyContinue)) { try { & claude mcp remove -s user $McpName 2>&1 | Out-Null } catch {} }
  Say "Done. The hub clone is still at $Dir (delete it yourself if you no longer need it)."
  Say "VS Code: remove '$McpName' via Command Palette -> 'MCP: List Servers' if present."
  return
}

# ------------------------------------------------------------------ 1. hub (the only copy)
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'git is required: https://git-scm.com/download/win (or: winget install Git.Git)' }
if (Test-Path (Join-Path $Dir '.git')) {
  Say "Updating hub at $Dir"
  git -C $Dir fetch --quiet origin $Branch
  git -C $Dir checkout --quiet $Branch
  git -C $Dir pull --ff-only --quiet origin $Branch
  if ($LASTEXITCODE -ne 0) { Warn 'Hub has local changes; not fast-forwarded.' }
} elseif ((Test-Path $Dir) -and (Get-ChildItem -LiteralPath $Dir -Force | Select-Object -First 1)) {
  throw "$Dir exists and is not a git clone. Use -Dir to choose another location."
} else {
  Say "Cloning $RepoUrl -> $Dir"
  git -c core.autocrlf=false clone --quiet --branch $Branch $RepoUrl $Dir
  if ($LASTEXITCODE -ne 0) { throw 'git clone failed' }
}
$Hub = (Resolve-Path $Dir).Path
if (-not (Test-Path (Join-Path $Hub 'src\skills\sdlc-orchestrator\SKILL.md'))) { throw "Hub looks incomplete: $Hub" }

# ------------------------------------------------------------------ 2. link skills (junctions, no copies)
New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
Say "Linking skills into $SkillsDir (Claude Code + VS Code Copilot)"
Get-ChildItem -LiteralPath (Join-Path $Hub 'src\skills') -Directory | ForEach-Object {
  $dest = Join-Path $SkillsDir $_.Name
  if (Test-Path -LiteralPath $dest) {
    if (-not (Get-LinkTarget $dest)) { Warn "skip $($_.Name) - a real folder with that name exists"; return }
    Remove-Link $dest
  }
  New-Item -ItemType Junction -Path $dest -Target $_.FullName | Out-Null
  Write-Host "  + $($_.Name)"
}
Get-ChildItem -LiteralPath $SkillsDir -Force | ForEach-Object {   # prune links to skills removed upstream
  $t = Get-LinkTarget $_.FullName
  if ($t -and $t.StartsWith($Hub, [System.StringComparison]::OrdinalIgnoreCase) -and -not (Test-Path $t)) { Remove-Link $_.FullName; Write-Host "  - $($_.Name) (removed upstream)" }
}

# ------------------------------------------------------------------ 3. rules by reference + env var
$hubFwd = $Hub -replace '\\', '/'
Add-Block (Join-Path $ClaudeDir 'CLAUDE.md') "@$hubFwd/src/AGENTS.md"
[Environment]::SetEnvironmentVariable('ENG_SKILLS_HOME', $Hub, 'User'); $env:ENG_SKILLS_HOME = $Hub

# ------------------------------------------------------------------ 4. browser MCP at user level
if (-not $NoMcp) {
  $confDir = Join-Path $HOME '.config\engineering-skills'; New-Item -ItemType Directory -Force -Path $confDir | Out-Null
  $profileDir = Join-Path $confDir 'browser-profile'
  if (Get-Command claude -ErrorAction SilentlyContinue) {
    try { & claude mcp remove -s user $McpName 2>&1 | Out-Null } catch {}
    try { & claude mcp add -s user $McpName -- npx -y '@playwright/mcp@latest' --user-data-dir $profileDir 2>&1 | Out-Null } catch {}
    if ($LASTEXITCODE -eq 0) { Say "Registered MCP '$McpName' in Claude Code (user scope)" }
    else { Warn "Claude Code MCP registration failed. Run: claude mcp add -s user $McpName -- npx -y @playwright/mcp@latest --user-data-dir `"$profileDir`"" }
  } else { Warn 'Claude Code CLI not found - skipped its MCP registration (re-run after installing).' }
  $code = Find-Code
  if ($code) {
    $json = @{ name = $McpName; command = 'npx'; args = @('-y', '@playwright/mcp@latest', '--user-data-dir', $profileDir) } | ConvertTo-Json -Compress
    $arg = $json -replace '"', '\"'   # code.cmd is a batch file: PowerShell passes inner quotes unescaped otherwise
    try { & $code --add-mcp $arg 2>&1 | Out-Null } catch {}
    if ($LASTEXITCODE -eq 0) { Say "Registered MCP '$McpName' in VS Code (user profile)" } else { Warn "VS Code MCP registration failed - see 'Browser & login' in the README." }
  } else { Warn "VS Code 'code' CLI not found - skipped VS Code MCP registration (see 'Browser & login' in the README)." }
  if (-not (Get-Command npx -ErrorAction SilentlyContinue)) { Warn 'Node.js/npx not found - install Node 18+ (winget install OpenJS.NodeJS.LTS).' }
}

$n = (Get-ChildItem -LiteralPath (Join-Path $Hub 'src\skills') -Directory).Count
Write-Host ""
Write-Host "Engineering skills installed - single copy at: $Hub" -ForegroundColor Green
Write-Host "   $n skills linked in $SkillsDir  -  rules: @$hubFwd/src/AGENTS.md"
Write-Host ""
Write-Host "Next:"
Write-Host "  1. Open VS Code and run any skill - first run asks for your team workspace, projects and git repos"
Write-Host "  2. Restart VS Code / terminals (for ENG_SKILLS_HOME)"
Write-Host '  3. Claude Code: "start the SDLC"  -  Copilot chat: /sdlc-orchestrator'
Write-Host "  Update: re-run this command (git pull in the hub; links pick it up instantly)."
