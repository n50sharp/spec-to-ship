"""Validate the skill: frontmatter, every referenced skill name resolves in the stage map, links exist."""
import re, sys, pathlib
root = pathlib.Path(__file__).resolve().parent.parent / "skills" / "spec-to-ship"
text = (root / "SKILL.md").read_text()
fm = re.match(r"---\n(.*?)\n---\n", text, re.S)
assert fm, "no frontmatter"
assert re.search(r"^name: spec-to-ship$", fm.group(1), re.M)
d = re.search(r"^description: (.*)$", fm.group(1), re.M).group(1)
assert d.startswith("Use when") and len(d) < 500, "bad description"
for rel in re.findall(r"`(references/[\w.-]+)`", text):
    assert (root / rel).exists(), f"missing {rel}"
sm = (root / "references" / "stage-map.md").read_text()
names = set(re.findall(r"\b(speckit-[a-z]+|omh-[a-z-]+)\b", text))
for n in names:
    assert n in sm or n in ("omh-ralph",), f"{n} not in stage map"
assert len(text.split()) < 900, "SKILL.md too long"
print("ok", len(text.split()), "words,", len(names), "skill refs")
