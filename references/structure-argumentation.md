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
match the actual section order and content. The same applies at section level: an
opening sentence enumerating topics ("we discuss X, Y, and Z") must match what the
subsections actually cover.

**Unaddressed obvious objection.** A point where a skeptical reader would immediately
ask "but what about...?" — an evident confound, an alternative explanation, a threat to
the central claim — and the paper never raises it anywhere, including Limitations.
Addressing it briefly anywhere (even an appendix) counts as delivery.

**Motivation before methods.** The intro presents the "how" before any "why" — the
approach is described before the reader has a reason to care, and no motivation appears
elsewhere in the intro. Methods papers may foreground the technique briefly, but the
motivation must still arrive within the intro.

**Conclusion that doesn't close the loop, or oversells.** Two failure modes: the
conclusion never returns to the question the introduction posed (pure results
restatement), or it introduces broader practical implications that appear nowhere else
and that the results don't support. Implications explicitly framed as speculative
future work are fine.

**Body repetition without new insight.** The same point restated later in the body with
nothing added — e.g., related-work framing repeated nearly verbatim in the discussion.
The abstract/intro/conclusion echo is structural convention, not repetition (see false
positives).

**Section-boundary jumps.** The end of one section gives no bridge into the next and
the topic shifts abruptly. Low severity, and only where the sections are meant to build
on each other — parallel case studies or independent experiment suites need no bridges.

## False positives — do not flag

- Venue-conventional sections (Limitations, Ethics, Acknowledgments) need no
  argumentative arc and no contribution mapping.
- Appendix content promised as "details in Appendix X" — delivery in an appendix
  counts.
- Deliberate suspense structure ("we return to this in Section 6") with an explicit
  pointer.
- Short linking paragraphs whose job is transition, not argument.
- The conclusion echoing the abstract's core result, or the intro's preview matching
  the results in more detail — structurally required repetition, not padding.
- An objection or caveat handled anywhere in the paper, however briefly — delivery
  elsewhere (including an appendix) counts.

## Severity

- **High**: a promise with no delivery anywhere in the paper; a contribution item the
  paper does not substantiate; an unaddressed obvious objection to the central claim.
- **Medium**: pointless related-work paragraphs; orphaned float; forward reference
  with no pointer; roadmap that misdescribes a section; methods with no motivation in
  the intro; a conclusion introducing unsupported implications.
- **Low**: section imbalance; undersold result; transition-paragraph nitpicks;
  section-boundary jumps; body repetition without new insight.
