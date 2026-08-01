# Academic claim issues

Category code: `AC`. Problems with what the paper claims, as opposed to how it is
worded (CL) or whether it sounds AI-written (AI). Terminology consistency lives in GR;
abstract–body match lives in ST.

## Patterns

**Overclaiming.** "Significant(ly)" with no statistical test reported nearby;
"substantial/dramatic improvement" where the table shows a marginal one; results stated
without their conditions ("our method improves TER" when it improves on 2 of 5 splits).
The rewrite states the measured fact with its scope.

**Unsupported superlatives.** "The first", "state-of-the-art", "best-performing",
"largest" — flag when the related-work section itself names something that contradicts
the claim, or when the claim has no hedge and no evidence. ("To the best of our
knowledge, the first" is the accepted form — see shared false-positives file.)

**Contribution inflation.** Contribution lists where an item is a routine step dressed
as a contribution ("we conduct extensive experiments"), or where two items restate one
contribution to reach a rounder count.

**Unscoped generalization.** Findings from one setting stated as universal: "LLMs
cannot learn from inconsistent signals" when the evidence is one model family on one
language pair. The rewrite adds the scope, not a hedge stack.

**Strength mismatch between venues of the claim.** The same result claimed strongly in
the abstract/intro and weakly in the results/limitations (or vice versa). Quote both
sites; the rewrite aligns them to what the evidence supports.

## False positives — do not flag

- "To the best of our knowledge, ..." priority claims (accepted hedged form).
- "Significant" backed by a reported test (p-values, CIs, significance marks in tables).
- Superlatives with explicit scope that makes them checkable and true ("the largest
  *English–Sinhala* APE dataset").
- Deliberate strong claims the paper spends a section defending.
- Standard contribution-list framing; three contributions are not inflation just by
  being three.

## Severity

- **High**: a superlative or significance claim contradicted by the paper's own content.
- **Medium**: unscoped generalization; strength mismatch; "significant" with no test.
- **Low**: mild contribution padding; a decorative superlative with plausible support.
