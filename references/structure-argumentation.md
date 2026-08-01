# Structure and argumentation

Category code: `ST`. Whether the paper's parts do their jobs and the promises match
the delivery. These checks need cross-section context — run them at whole-paper scope,
not inside per-section chunks.

## Patterns

**Promise–delivery match.** Collect every promise in the abstract, intro, and
contribution list ("we show", "we release", "we prove", "Section 5 demonstrates") and
check each has a section/table/statement that delivers it. Also the reverse: a strong
delivered result the abstract undersells. This absorbs the old abstract–body check.

**Contribution list vs paper.** Each contribution item should map to a section with
evidence; flag items with no home and sections with major results absent from the
list.

**Paragraph-point check.** For each body paragraph: could a reader state its point
from the first or last sentence? Flag paragraphs that are pure citation lists with no
stance (common in related work) or that drift across topics without a seam. Quote the
opening sentence, and suggest a topic-sentence rewrite or a split.

**Orphaned floats.** Figures/tables never referenced from prose (`\ref` never appears
for their label). Mechanical candidates come from the script; confirm before reporting.

**Confusing forward references.** Prose that depends on a concept only defined later,
without a "(Section~N)" pointer. A pointer fixes it; absence of one is the finding.

**Section imbalance.** A results section dwarfed by setup, or a discussion that
introduces new results (results belong in Results). Note-level unless egregious.

**Roadmap drift.** If the paper has an "organized as follows" roadmap, its claims must
match the actual section order and content.

## False positives — do not flag

- Venue-conventional sections (Limitations, Ethics, Acknowledgments) need no
  argumentative arc and no contribution mapping.
- Appendix content promised as "details in Appendix X" — delivery in an appendix
  counts.
- Deliberate suspense structure ("we return to this in Section 6") with an explicit
  pointer.
- Short linking paragraphs whose job is transition, not argument.

## Severity

- **High**: a promise with no delivery anywhere in the paper; a contribution item the
  paper does not substantiate.
- **Medium**: pointless related-work paragraphs; orphaned float; forward reference
  with no pointer; roadmap that misdescribes a section.
- **Low**: section imbalance; undersold result; transition-paragraph nitpicks.
