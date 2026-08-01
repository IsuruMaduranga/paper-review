# Clarity checklist for academic prose

Category code for findings: `CL`. These are not AI tells — they are readability problems,
common in both AI-drafted and human-drafted papers. LLM-drafted papers (Claude/Anthropic
models especially) tend toward unnecessarily complex language; the fix direction is always
*simpler, shorter, more direct*, never fancier.

## Sentence-level

**Overlong sentences.** Over ~35 words *and* doing more than one job (a claim plus its
caveat plus its evidence). Long but single-purpose sentences with clear structure are
fine. Suggested rewrite: split at the seam between jobs.

**Nominalization.** Verb smothered into a noun plus light verb: "perform an evaluation
of" → "evaluate", "the utilization of" → "using", "provides an improvement over" →
"improves on", "conduct an analysis" → "analyze".

**Stacked noun phrases.** Four or more nouns/modifiers in a row: "low-resource language
machine translation quality estimation model performance". Unpack with a preposition or
split.

**Passive voice where the agent matters.** "The threshold was chosen to be 0.5" hides who
chose and why. Flag only when the hidden agent is informative (design decisions,
judgments). Methods-section passives describing standard procedure are fine (see false
positives).

**Buried main claim.** The sentence's point arrives after two subordinate clauses:
"Although X, and despite Y, we find Z." If Z is the contribution, lead with it.

**Double negatives and litotes.** "not uncommon", "cannot be ruled out", "not without
merit" → say the positive thing.

**Filler phrases.** "it is worth noting that", "it should be mentioned that", "in order
to" (→ "to"), "due to the fact that" (→ "because"), "a number of" (→ "several" or the
number), "in the context of" (when deletable), "with respect to" (→ "for"/"on").

**Hedging stacks.** Two or more hedges on one claim: "may potentially suggest",
"could possibly indicate", "seems to perhaps". One hedge per claim, chosen deliberately.

## Discourse-level

**Ambiguous *this/it/these*.** A sentence opening with bare "This shows..." where two or
more candidate antecedents exist in the previous sentence. Fix: "This gap shows...".

**Unexplained acronyms.** Acronym used before its expansion, or expanded more than once.
(Standard field acronyms — see false positives — need no expansion.)

**Paragraph without a point.** A paragraph whose first and last sentences could not tell
a reader what it argues. Common in AI-drafted related work: a list of citations with no
stance.

**Redundant restatement.** The same claim made twice in adjacent sentences with different
words (often elegant variation at sentence scale): "X improves accuracy. This gain in
performance demonstrates that X is beneficial."

(Abstract–body / promise–delivery checking lives in the structure category, `ST` —
see `structure-argumentation.md`.)

## Severity guide for clarity findings

- **High**: a sentence a careful reader must re-read to parse; ambiguous antecedent on a
  load-bearing claim.
- **Medium**: nominalization, filler, hedging stacks, buried claims, overlong multi-job
  sentences.
- **Low**: mild wordiness; a passive that would merely read better active.
