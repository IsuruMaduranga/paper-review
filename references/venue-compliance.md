# Venue compliance

Category code: `VC`. Submission-mechanics problems that get papers desk-rejected or
embarrass a camera-ready. LaTeX-specific checks assume ACL-style venues unless the
style file says otherwise; adapt to the venue the paper targets.

**Build mode matters.** Read the documentclass options first (the script echoes them):
`review` = anonymous submission build, `final` = camera-ready, `preprint` =
non-anonymous preprint. Several checks flip meaning with the mode — every finding in
those checks must name the mode it assumed.

## Patterns

**Anonymity (review builds only).**
- Author block, acknowledgments, or grant numbers active (not commented) in the source.
- Self-identifying citation phrasing: "our previous work \citep{...}", "we showed in
  \citet{...}" — must be third person in a review build.
- Self-citation to *inaccessible* prior work: even correctly third-personed, citing the
  authors' own unpublished/unavailable work identifies them because reviewers cannot
  check it (ARR rule). Third-person cites to publicly available work are fine.
- Identifying URLs: personal GitHub, lab pages, "our repository at github.com/<name>".
- Links via services that track access (Dropbox is named in the ARR CFP; Google Drive
  behaves the same) — the tracking itself can deanonymize, even with a clean URL. Use
  anonymous mirrors (anonymous.4open.science, OSF anonymized views).
- PDF-level identity (author metadata) — note as a reminder; source review cannot
  verify the PDF.

**Camera-ready readiness (final builds only).**
- Author block still commented out or anonymized.
- documentclass still `[review]`.
- Acknowledgments missing.

**Draft debris (any mode).**
- TODO/FIXME/XXX/TBD in prose or comments that gate content.
- Placeholder macros still used in the body: red-placeholder wrappers (e.g. a
  `\fake{}`-style command), supervisor/author comment macros (`\sr{}`, `\nds{}`-style
  colored notes) — any `\newcommand` whose definition wraps text in a loud color and
  is still called in the body.
- "citation needed"-type notes, `??` from unresolved refs, `[REF]` placeholders.
- Unfilled chatbot template slots: "[Insert dataset name]", "[Your institution]" —
  bracketed fill-me-in text of any kind (the script greps for the common forms).

**Required sections (ACL-family).** Limitations section (mandatory at *ACL venues);
Ethics statement where the work involves human annotators or released data. Flag
absence, not content.

**Required checklists (venue-conditional).** NeurIPS desk-rejects papers without the
paper checklist (it sits after references and doesn't count against the page limit);
ARR requires the Responsible NLP checklist; ICML requires a Broader Impact statement.
Where a checklist is present, spot-check "yes" answers whose justification points at a
section: the section must exist and plausibly contain the claimed material ("yes, see
Section 5.2" for error bars when 5.2 reports none). Honest "no"/"N/A" answers are never
findings. Where these sections are optional (ICLR, AAAI, COLM for Broader Impact),
absence is at most a low note — check the venue's current CFP.

**LLM-usage disclosure.** ICLR requires a separate section describing any significant
LLM role in ideation or writing (non-disclosure risks desk rejection); NeurIPS and
others have lighter parallels. If this review's AI category found dense AI-writing
signs and the paper targets such a venue, note the missing disclosure. Grammar checking
and minor editing don't require disclosure.

**Style-file tampering.** Preamble hacks that alter the venue geometry: `\setlength` on
margins or floats, global font-size changes, `\vspace` abuse, `geometry`/`fullpage`
loaded over the venue class. Many venues (AAAI strictest) desk-reject any deviation;
some permit narrow exceptions (`\small` in tables) — check the venue's instructions.

**Appendix load-bearing content (ARR-family).** Reviewers aren't obligated to read
appendices, and ARR forbids material "essential for assessing novelty or correctness"
living only there. Flag a core claim whose *only* support (proof, key ablation) is in
an appendix. Genuinely supplementary extras are fine.

**Length limits.** Abstract over the venue's word cap (commonly 250–300); body pages
over the limit. Note: page count is a PDF-level property — from source, flag only clear
signals (e.g. the venue's own overfull warnings, or an abstract you can count) and
otherwise record it as a reminder, like PDF metadata. References, Limitations, Ethics,
and appendices are excluded from page caps at all surveyed venues.

**Mechanical integrity** (from the script): `\ref`/`\Cref` targets with no matching
`\label` (renders as ??); duplicate `\label` keys.

**Style-file conventions.** Sectioning depth the style supports; title case vs
sentence case per the venue's own headings; footnote and caption conventions obviously
violated. Only flag what the venue's style file or formatting guide actually requires.

## False positives — do not flag

- A commented-out author block in a `review` build — that is the correct state (it
  becomes a finding only in a `final` build).
- Anonymized placeholders ("Anonymous ARR submission") in review builds.
- `\true{}`-style confirmed-value markers or draft toggles that render normally in the
  final build — check the macro definition before flagging its uses.
- TODOs inside fully commented-out blocks that cannot render (still worth a low-severity
  note only if the user asked for a camera-ready sweep).
- Standard shared-task/dataset URLs that don't identify the authors.
- Third-person self-citation to publicly available work in a review build — that is
  the correct ARR pattern, not a leak.
- Checklist items honestly answered "no" or "N/A" with a reasonable justification.
- Broader Impact absent at venues where it is optional (ICLR, AAAI, COLM) — low note
  at most.

## Severity

- **High**: anonymity leak in a review build (including tracking links and
  inaccessible self-citations); unresolved `\ref`/`\cite` (renders ??); placeholder
  macro or unfilled template slot rendering visibly; missing Limitations or required
  checklist at a venue that mandates it; style-file tampering at a strict venue.
- **Medium**: draft debris in prose; camera-ready still carrying review-mode state;
  self-identifying URL; checklist "yes" with a broken pointer; load-bearing
  appendix-only content; missing LLM disclosure where required and AI signs are dense.
- **Low**: TODOs in comments; style-convention nitpicks; PDF-metadata and page-count
  reminders; optional-section absences.
