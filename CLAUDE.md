# CLAUDE.md

Guidance for Claude Code when working in this repository.

## What this repo is

An [Agent Skill](https://agentskills.io/specification) called `paper-review`: a
seven-dimension academic-paper reviewer (AI-writing signs, clarity, academic claims,
grammar & consistency, citation hygiene, structure & argumentation, venue compliance)
with a report-first / fix-on-approval workflow. Published at
https://github.com/IsuruMaduranga/paper-review (installable elsewhere via
`npx skills add IsuruMaduranga/paper-review`).

The repo root IS the skill directory: `SKILL.md` + `references/` + `scripts/`.

## Local install is a symlink — edits are live

(Author's dev setup — if you installed this skill via `npx skills add`, this section
doesn't apply to your copy.)

On the author's machine, `~/.claude/skills/paper-review` is a **symlink to this
repo**. Consequences:

- Any edit here is picked up by new Claude Code sessions immediately; there is no
  reinstall or cache-refresh step (unlike the plugin system).
- Do not rename or move this directory without recreating the symlink — and note the
  spec requires the skill `name:` in SKILL.md to match the directory name exactly.
- Other people get the skill only from GitHub, so push after meaningful changes.

## Layout and content rules

- `SKILL.md` — the orchestrator (review mode + fix mode). Keep it under ~250 lines;
  the spec recommends <500 and a <1024-char `description`. The `description` drives
  when harnesses activate the skill — edit it carefully.
- `references/<category>.md` — one checklist per category, each self-contained:
  patterns, a false-positive list, and a severity guide. `academic-false-positives.md`
  is the shared drop-list, always loaded.
- `scripts/mechanical-checks.sh` — deterministic LaTeX checks. **POSIX sh only**: no
  bashisms (no process substitution, no ERE backreferences — BSD grep on macOS lacks
  them; the doubled-word check uses awk for that reason). Its output is triage input
  for the model, never findings to paste directly into a report.

## Validating and testing

```
npx -y skills-ref validate .          # spec compliance (must pass before commit)
sh scripts/mechanical-checks.sh <main.tex>   # run the script directly on a paper
```

For behavioral testing, build a seeded `.tex` fixture: plant one instance of each
pattern you care about plus false-positive bait (Methods passives, "to the best of
our knowledge", venue-required boilerplate), then run the skill's review mode against
it and check plants are caught and bait is untouched. Findings must have grep-verified
line numbers — LaTeX paragraphs are often one source line, so estimated numbers drift.

## Releasing

Bump `metadata.version` in SKILL.md frontmatter, commit, tag (`vX.Y.Z`), push with the
tag. v0.1.0 is the initial release (single squashed commit).
