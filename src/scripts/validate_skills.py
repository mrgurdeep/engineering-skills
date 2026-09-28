#!/usr/bin/env python3
"""Validate src/skills: front-matter, step files, links, templates, shared procedures, guide catalogue."""
import pathlib, re, sys

SRC = pathlib.Path(__file__).resolve().parent.parent
SKILLS = SRC / "skills"
errors = []
dirs = sorted(p for p in SKILLS.iterdir() if p.is_dir())
names = {p.name for p in dirs}

for d in dirs:
    f = d / "SKILL.md"
    if not f.exists():
        errors.append(f"{d.name}: missing SKILL.md"); continue
    t = f.read_text()
    m = re.match(r"^---\nname: (.+)\ndescription: (.+?)\n---\n", t, re.S)
    if not m:
        errors.append(f"{d.name}: bad front-matter"); continue
    name, desc = m.group(1).strip(), m.group(2).strip()
    if name != d.name: errors.append(f"{d.name}: name '{name}' != folder")
    if len(desc) > 1024: errors.append(f"{d.name}: description > 1024 chars")
    if re.search(r":\s", desc): errors.append(f"{d.name}: description contains ': ' (breaks YAML)")
    # every linked step exists, every step file is linked
    linked = set(re.findall(r"\]\(steps/([^)]+)\)", t))
    files = {p.name for p in (d / "steps").glob("*.md")}
    if not files: errors.append(f"{d.name}: no steps/")
    for x in linked - files: errors.append(f"{d.name}: links missing step {x}")
    for x in files - linked: errors.append(f"{d.name}: step {x} not listed in SKILL.md")
    for s in (d / "steps").glob("*.md"):
        st = s.read_text()
        for x in re.findall(r"\]\(([^)]+\.md)\)", st):
            if not (s.parent / x).exists(): errors.append(f"{d.name}/{s.name}: broken link {x}")
    for tpl in re.findall(r"src/templates/([\w./-]+\.md)", "\n".join([t] + [s.read_text() for s in (d / "steps").glob("*.md")])):
        if not (SRC / "templates" / tpl).exists(): errors.append(f"{d.name}: missing template {tpl}")
    for ref in re.findall(r"skill `([a-z-]+)`", t + "".join(s.read_text() for s in (d / "steps").glob("*.md"))):
        if ref not in names: errors.append(f"{d.name}: references unknown skill {ref}")

# the guide's catalogue must list exactly the skills that exist
guide = (SKILLS / "guide" / "SKILL.md").read_text()
listed = set(re.findall(r"^\| \*\*[^*]+\*\* \| `([a-z-]+)` \|", guide, re.M))
for x in names - listed: errors.append(f"guide catalogue is missing skill {x}")
for x in listed - names: errors.append(f"guide catalogue lists unknown skill {x}")
# shared procedures referenced by skills must exist
for d in dirs:
    blob = "\n".join(p.read_text() for p in [d / "SKILL.md", *(d / "steps").glob("*.md")])
    for sh in re.findall(r"src/shared/([\w.-]+\.md)", blob):
        if not (SRC / "shared" / sh).exists(): errors.append(f"{d.name}: missing shared procedure {sh}")
    if "**SDLC phase:**" not in blob or "**Typical roles:**" not in blob: errors.append(f"{d.name}: missing SDLC phase / roles line")

steps = sum(len(list((d / "steps").glob("*.md"))) for d in dirs)
print(f"{len(dirs)} skills, {steps} steps checked")
if errors:
    print("\n".join("✗ " + e for e in errors)); sys.exit(1)
print("✓ all skills valid")
