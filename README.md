# paper-review

An [Agent Skill](https://agentskills.io/specification) that reviews academic papers —
LaTeX, Markdown, or plain text — across seven dimensions:

| Code | Category | Examples |
|---|---|---|
| AI | AI-writing signs | AI vocabulary, significance inflation, rule-of-three, superficial "-ing" clauses, em-dash overuse, chatbot artifacts |
| CL | Clarity | overlong sentences, nominalization, hedging stacks, ambiguous antecedents, filler |
| AC | Academic claims | overclaiming, unsupported superlatives, contribution inflation, unscoped generalization |
| GR | Grammar & consistency | typos, agreement, US/UK & hyphenation drift, cross-artifact naming, notation consistency |
| CIT | Citation hygiene | \citet/\citep misuse, uncited claims, breadth mismatch, dead/missing bib entries |
| ST | Structure & argumentation | promise–delivery match, paragraph-point check, orphaned floats, roadmap drift |
| VC | Venue compliance | anonymity leaks, placeholder/draft markers, missing Limitations, unresolved refs |

It is **report-first**: review mode writes a severity-ranked findings report with
suggested rewrites and changes nothing; fix mode applies only the findings you approve,
preserving every citation, label, math fragment, and reported number.
`scripts/mechanical-checks.sh` adds deterministic LaTeX checks (cite/bib and ref/label
integrity, draft markers, doubled words) whose output the model triages against
per-category false-positive guards.

The AI-writing checklist is adapted from Wikipedia's
[Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing) and
[blader/humanizer](https://github.com/blader/humanizer) (MIT), tuned for the academic
register with an AI/ML-paper false-positive guard (so "robust to noise", "word
alignment", or Methods-section passives don't get flagged).

## Install

The repo root is the skill directory (per the spec: `SKILL.md` + `references/` +
`scripts/`), so it works in any harness that supports Agent Skills.

**Skills CLI (cross-harness):**

```
npx skills add IsuruMaduranga/paper-review
```

**Claude Code (personal skill):**

```
ln -s /path/to/paper-review ~/.claude/skills/paper-review   # or cp -R
```

**Codex / Cursor / other harnesses without skill support:** point your rules file
(`AGENTS.md`, `.cursor/rules`, …) at `SKILL.md`, or paste the `references/*.md`
checklists into the tool's instruction mechanism.

## Use

```
/paper-review latex/main.tex              # full review, all seven categories
/paper-review latex/main.tex grammar venue   # only GR + VC
# "humanize this paper"                   → AI category
# "camera-ready check"                    → VC + GR + CIT
# read paper-review-report.md, decide what you agree with
# then: "apply F3 F7 F12"  or  "apply high only"  or  "apply all"
```

## Layout

```
SKILL.md                                  the skill (review + fix modes)
scripts/mechanical-checks.sh              deterministic LaTeX checks (POSIX sh)
references/ai-writing-signs.md            AI  — AI-text patterns (academic-tuned)
references/clarity-checklist.md           CL  — clarity checks
references/academic-issues.md             AC  — claim-level issues
references/grammar-consistency.md         GR  — grammar + one-paper-one-convention
references/citation-hygiene.md            CIT — citation existence, fit, mechanics
references/structure-argumentation.md     ST  — promises, paragraphs, floats
references/venue-compliance.md            VC  — anonymity, placeholders, required sections
references/academic-false-positives.md    shared drop-list (always loaded)
```

## License

MIT. Pattern content adapted from blader/humanizer (MIT) and Wikipedia
(CC BY-SA 4.0), both credited above.
