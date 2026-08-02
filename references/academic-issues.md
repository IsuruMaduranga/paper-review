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

**Causal language without a causal design.** "Causes", "leads to", "drives",
"determines", "results in" applied to correlational or observational findings, with no
randomization, intervention, or explicit identification argument anywhere in the paper.
The rewrite downgrades to the association actually shown ("is associated with",
"co-occurs with").

**Mechanism asserted as fact.** An explanation of *why* a result holds stated as
established truth ("the gain comes from better token coverage") rather than as a
candidate explanation. Flag flat assertions in the abstract, intro, or conclusion; a
hedged interpretive sentence in the discussion is the correct form (see false
positives).

**Statistical vs. practical significance conflation.** A test is reported (so
"significant" is earned), but the paper then calls the effect "large", "substantial",
or "important" without ever giving its magnitude or an effect size. The rewrite either
adds the magnitude from the paper's own tables or drops the size adjective.

**Limitations spin.** A Limitations entry that reframes a real weakness as a selling
point ("we only evaluate on X, which demonstrates our method's efficiency") instead of
acknowledging its cost. A limitation followed by genuine mitigating evidence is fine
(see false positives); the tell is spin with nothing behind it.

## False positives — do not flag

- "To the best of our knowledge, ..." priority claims (accepted hedged form).
- "Significant" backed by a reported test (p-values, CIs, significance marks in tables).
- Superlatives with explicit scope that makes them checkable and true ("the largest
  *English–Sinhala* APE dataset").
- Deliberate strong claims the paper spends a section defending.
- Standard contribution-list framing; three contributions are not inflation just by
  being three.
- Causal verbs in genuinely causal designs: randomized/controlled experiments, explicit
  identification strategies (natural experiments, instrumental variables), or
  interventional/counterfactual ML setups the paper argues for. The check is whether
  the paper argues the identification, not whether causal words appear.
- A limitation followed by real mitigating evidence ("we only test one language pair,
  but Appendix C shows consistent results on a second") — honest mitigation, not spin.
- A single hedged mechanism sentence in the discussion ("we suspect this reflects...")
  — that is where informed speculation belongs.

## Severity

- **High**: a superlative or significance claim contradicted by the paper's own content;
  causal language on correlational evidence for a central claim.
- **Medium**: unscoped generalization; strength mismatch; "significant" with no test;
  mechanism asserted as fact outside the discussion; size adjectives with no magnitude;
  limitations spin.
- **Low**: mild contribution padding; a decorative superlative with plausible support.
