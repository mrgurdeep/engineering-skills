#!/usr/bin/env python3
"""Knowledge-base health for a team workspace: broken relative links, orphan pages, missing front-matter,
stale pages.  Usage: python3 kb_check.py <workspace-dir>"""
import pathlib, re, sys, datetime

if len(sys.argv) < 2:
    sys.exit("usage: kb_check.py <workspace-dir>")
ROOT = pathlib.Path(sys.argv[1]).expanduser().resolve()
KB = ROOT / "knowledge-base"
if not KB.is_dir():
    sys.exit(f"no knowledge-base/ in {ROOT}")
LINK = re.compile(r"\]\(([^)#\s]+)(?:#[^)]*)?\)")
pages = list(KB.rglob("*.md"))
inbound = {p.resolve(): 0 for p in pages}
problems = []
today = datetime.date.today()
for p in pages:
    t = re.sub(r"<!--.*?-->", "", p.read_text(), flags=re.S)
    if not t.startswith("---\n"):
        problems.append(f"no front-matter: {p.relative_to(ROOT)}")
    m = re.search(r"^last_verified:\s*(\d{4}-\d{2}-\d{2})", t, re.M)
    if m and (today - datetime.date.fromisoformat(m.group(1))).days > 90:
        problems.append(f"stale (>90d): {p.relative_to(ROOT)}")
    for target in LINK.findall(t):
        if target.startswith(("http://", "https://", "mailto:")):
            continue
        dest = (p.parent / target).resolve()
        if not dest.exists():
            problems.append(f"broken link in {p.relative_to(ROOT)} -> {target}")
        elif dest in inbound:
            inbound[dest] += 1
index = (KB / "README.md").resolve()
for page, n in inbound.items():
    if n == 0 and page != index:
        problems.append(f"orphan (no inbound links): {page.relative_to(ROOT)}")
print(f"{len(pages)} KB pages checked")
print("\n".join("✗ " + x for x in problems) or "✓ knowledge base healthy")
sys.exit(1 if problems else 0)
