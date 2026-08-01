---
name: paper-review
description: >-
  Review an academic paper (LaTeX, Markdown, or plain text) across seven
  dimensions — signs of AI-generated writing, clarity, academic claims,
  grammar & consistency, citation hygiene, structure & argumentation, and
  venue compliance (anonymity, placeholders, required sections) — and produce
  a severity-ranked findings report with suggested rewrites; then, only for
  findings the user approves, apply fixes while preserving citations, labels,
  math, and reported numbers. Use when the user asks to review, audit,
  proofread, humanize, or "de-AI" a paper or draft, check clarity or grammar,
  do a camera-ready or submission check, or clean up paper prose.
license: MIT
metadata:
  author: IsuruMaduranga
  version: "0.1.0"
---

# paper-review

Two modes. **Review** (the default) analyzes a paper and writes a findings report —
it changes nothing. **Fix** applies findings from that report, and runs only when the
user has said which findings to apply. Never fix without an explicit selection.

## Categories

Each category is one checklist file under this skill's `references/` directory
(relative to this SKILL.md). Findings carry the category code.

| Code | Category | Checklist file |
|---|---|---|
| AI | AI-writing signs | `references/ai-writing-signs.md` |
| CL | Clarity | `references/clarity-checklist.md` |
| AC | Academic claims | `references/academic-issues.md` |
| GR | Grammar & consistency | `references/grammar-consistency.md` |
| CIT | Citation hygiene | `references/citation-hygiene.md` |
| ST | Structure & argumentation | `references/structure-argumentation.md` |
| VC | Venue compliance | `references/venue-compliance.md` |

**Selection:** all seven by default. If the user names categories (by code or by
words like "ai", "clarity", "grammar", "citations", "structure", "venue",
"humanize"/"de-AI" = AI, "proofread" = GR+CL, "camera-ready check" = VC+GR+CIT),
run only those. Read only the selected categories' files, plus
`references/academic-false-positives.md` (shared drop-list) always.

## Review mode

### 1. Locate the paper

- If the user gave a path, use it. Accepted: `.tex`, `.md`, `.txt`.
- Otherwise, find the main LaTeX file: the `.tex` containing `\begin{document}` in the
  working directory. If several candidates or none, ask the user.
- For multi-file LaTeX projects (`\input`/`\include`), analyze the main file plus every
  included file that contains prose.

### 2. What counts as prose (LaTeX preprocessing)

Analyze only rendered prose. Skip: everything before `\begin{document}`; `%` comments
(whole-line and inline tails) — except where a category says otherwise (VC checks
comment state deliberately); math (`$...$`, `\[...\]`, `equation`, `align`, and
similar); the bodies of `tabular`, `tikzpicture`, figure includes,
`lstlisting`/`verbatim` (verbatim prompts and examples shown as artifacts are not the
paper's prose); and the bibliography — except for CIT and GR cross-artifact checks,
which read tables, captions, and `.bib` files on purpose.

DO analyze: section titles, `\caption{...}` text, footnotes, and the abstract. Treat
`---` and `--` as em/en dashes — they render as such. For Markdown/plain text, skip
fenced code blocks and analyze everything else.

### 3. Mechanical checks (LaTeX targets, when GR, CIT, or VC is selected)

Run `scripts/mechanical-checks.sh <main.tex>` (from this skill's `scripts/`
directory). It prints candidate issues prefixed with a category code: cite keys
missing from the `.bib`, never-cited bib entries, `\ref` targets without labels,
draft markers, colored placeholder macros still used in the body, doubled words,
curly quotes, and the documentclass mode (review/final/preprint) that VC findings
must reference. Its output is **triage input, not findings**: check every line
against the category's false-positive list; drop non-prose artifacts (tikz node
names, table column specs) and macros whose definition shows they render normally.
If the script cannot run, do the equivalent greps manually.

### 4. Analyze

Work section by section. For every candidate finding:

1. Match it against a specific named pattern from a selected checklist.
2. Check it against that checklist's false-positive list AND the shared
   `references/academic-false-positives.md` — a match means drop, not downgrade.
3. Assign severity using the checklist's severity guide.
4. Draft a suggested rewrite obeying the hard rules below.

**Hard rules for suggested rewrites:**
- Never invent facts, numbers, results, names, or citations.
- Never alter the content of a claim, only its wording.
- Preserve every `\cite`, `\ref`, `\label`, math fragment, and reported number verbatim.
- Prefer the shorter, plainer wording; do not swap one AI-ism for another.
- Match the paper's existing voice — if the paper says "we", the rewrite says "we".

Run whole-paper checks at whole-paper scope, not inside per-section chunks: ST's
promise–delivery and contribution mapping, GR's consistency drifts (spelling,
hyphenation, capitalization, cross-artifact naming).

**Large papers:** if the paper exceeds ~1,000 lines of prose and the harness supports
subagents, fan out one subagent per contiguous section group (3–4 groups). Give each
subagent only its own section range (by line numbers, not the whole paper), the
selected checklist files, and the finding format below — the point of the fan-out is
that no single context holds the entire paper plus all checklists.

Never delegate to section-scoped subagents: the whole-paper checks (they need one
reader who sees everything), mechanical-check triage, the final line-number
verification below, and report assembly. Merge and dedupe subagent findings yourself
(same line + same pattern = one finding), treating their line numbers as estimates.
Without subagents, work through the section groups sequentially — the review is the
same, just slower.

**Verify every line number before writing the report** — grep a distinctive fragment
of each quote in the source file and use the line number grep returns. Line numbers
estimated while reading drift, especially in LaTeX where a whole paragraph is often
one source line; subagent-reported numbers are estimates until verified. Also grep
each flagged phrase across the whole file: a "one-off" inconsistency often recurs
elsewhere, and the finding should list every site.

### 5. Report

Write `paper-review-report.md` into the same directory as the paper (if not writable,
the working directory):

```markdown
# Paper review: <file> (<date>)

## Summary
| Category | High | Medium | Low |
|---|---|---|---|
(one row per selected category)

One short paragraph: overall impression, densest sections and categories, whether
the paper reads as polished or still rough.

## Findings

### F1 [AI/high] <pattern name> — <file>:<line>
> exact quoted source text
**Why:** one sentence.
**Suggested rewrite:** the replacement text, or "cut".
```

Number findings `F1, F2, ...` sorted by severity (high → low), then by line. Fix mode
consumes these numbers, so quotes must be exact raw source text with verified line
numbers. Cap each category at ~15 findings, keeping the most severe; when you
truncate, say how many were dropped and where they cluster — never truncate silently.
End your reply with the summary table, the top findings, a pointer to the report
file, and how to apply fixes (e.g. "all", "high only", or "F3 F7 F12").

## Fix mode

Runs only against an existing report, and only for findings the user selected
("all", "high only", explicit numbers). If the user has not said which, ask — never
assume "all".

For each selected finding, in file order:

1. Verify the report's quoted text still exists at (or near) the reported line. If the
   file changed since the review, skip the finding and record it as **stale** — never
   guess at a fuzzy match.
2. Apply the suggested rewrite with an exact-string edit. For "cut", remove the quoted
   text and repair the surrounding sentence (whitespace, connectives, double periods).
3. Per-edit constraints: `\cite`/`\ref`/`\Cref`/`\label`/`\footnote` markers, math, and
   every reported number survive verbatim; no new facts or citations appear; braces stay
   balanced; the edit touches only the quoted prose. You may improve a rewrite in
   context, but stay within the finding's scope.

Afterwards: confirm the set of `\label{...}` and `\cite{...}` keys is unchanged
(grep + sort + diff against a pre-edit snapshot); offer a recompile if a LaTeX
toolchain is available; report per finding number what was applied, stale, or skipped;
and mark those outcomes in the report file.
