# Shared procedure — open Jira / Confluence / Figma and wait for login

Used whenever a skill reads or writes Jira, Confluence or Figma. Read-only unless the user approves a write.

## 1. Pick the access method (first that works)
1. A connected, authenticated **Atlassian MCP** (Jira/Confluence) or **Figma Dev Mode MCP**.
2. VS Code integrated-browser agent tools, if your environment exposes them.
3. The **`eng-browser`** Playwright MCP registered by the installer — a visible Chromium window whose
   login session is kept in `~/.config/engineering-skills/browser-profile/`.
Tell the user they can view the same page in VS Code via **Command Palette → Simple Browser: Show**.
No browser tool at all → say so and ask the user to export/paste the page content.

## 2. Open the page
One tab per source (Jira, Confluence, Figma), reused later. Navigate, wait for load, take a snapshot.

## 3. Detect a login wall
Not logged in if the URL contains `id.atlassian.com`, `/login`, `/signin`, `sso`, `okta`, `auth0`,
`accounts.google.com`, `login.microsoftonline.com`, `figma.com/login`, `/oauth` — or the page shows a
password field, "Log in", "Sign in", "Continue with Google/Microsoft/SSO", "Verify it's you", captcha, MFA —
or "You don't have access" / "Request access" / "Page not found" for a URL that should exist.

## 4. Wait for the user ⏸
Send exactly:
> 🔐 **Login needed for <Jira|Confluence|Figma>.** Please sign in in the browser window that just opened
> (complete SSO/MFA). When you can see **<expected page>**, reply **done**. Reply **skip** to continue without it.

Then wait — don't poll or continue other work. `done` → reload and re-check (max 3 rounds, then offer
`skip`). `skip` → record "source skipped: login" and continue. Access denied → ask for access or another URL.

## 5. Read
- **Jira:** issue view or JQL list; expand description, acceptance criteria, sub-tasks, links, comments, attachments.
- **Confluence:** full body with collapsed sections expanded; note title, version, last updated.
- **Figma:** pages/frames; open frames via `?node-id=`; Dev Mode inspect for spacing, type, colours, components.
Return content with its URL.

## 6. Writes (create / edit / comment / transition)
Show exactly what will be written → proceed only on explicit approval → verify after writing.

**Never** ask for, read, store or type passwords, tokens, cookies or MFA codes; never sign out or change account settings.
