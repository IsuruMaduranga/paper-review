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
- Identifying URLs: personal GitHub, lab pages, "our repository at github.com/<name>".
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

**Required sections (ACL-family).** Limitations section (mandatory at *ACL venues);
Ethics statement where the work involves human annotators or released data. Flag
absence, not content.

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

## Severity

- **High**: anonymity leak in a review build; unresolved `\ref`/`\cite` (renders ??);
  placeholder macro rendering visibly in the output; missing Limitations at a venue
  that requires it.
- **Medium**: draft debris in prose; camera-ready still carrying review-mode state;
  self-identifying URL.
- **Low**: TODOs in comments; style-convention nitpicks; PDF-metadata reminder.
