#!/usr/bin/env bash
# Lists which skills/CLI this pipeline needs and which are missing.
roots="${HERMES_SKILLS_DIRS:-$HOME/.hermes/skills $HOME/.hermes/plugins/superpowers/skills}"
need="speckit-constitution speckit-specify speckit-clarify speckit-plan speckit-tasks speckit-analyze speckit-converge omh-deep-research omh-deep-interview omh-ralplan omh-ralph brainstorming test-driven-development verification-before-completion requesting-code-review"
miss=0
for s in $need; do
  found=0
  for r in $roots; do [ -n "$(find "$r" -maxdepth 4 -type d -name "$s" 2>/dev/null | head -1)" ] && found=1; done
  [ $found = 1 ] && echo "ok       $s" || { echo "MISSING  $s"; miss=1; }
done
command -v specify >/dev/null && echo "ok       specify CLI" || { echo "MISSING  specify CLI"; miss=1; }
exit $miss
