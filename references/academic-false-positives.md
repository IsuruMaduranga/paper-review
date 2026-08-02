# False positives: legitimate academic writing that must NOT be flagged

Check every candidate finding against this list before it goes in the report. A finding
that matches an entry here is dropped, not downgraded. When genuinely unsure, report it
as **low** severity with a note that it may be intentional.

## Standard academic moves

- "We introduce / we propose / we present / we show / we find" — the standard
  contribution voice. Not significance inflation.
- "To the best of our knowledge, X is the first..." — the accepted hedged-priority claim.
- "The remainder of this paper is organized as follows" — venue convention, leave it.
- Conventional signposting: "In this section, we describe...", "We now turn to...",
  "As discussed in Section 3" — standard academic navigation, not chatty announcement.
- "state-of-the-art" — technical when naming the best published result or backed by the
  paper's own comparison table; a tell only as unevaluated self-praise.
- Explicit contribution lists ("Our contributions are threefold") — flag only if the
  three items are padding, not because there are three.
- Limitations-section hedging — hedges are the point of that section.

## Passive voice that is fine

- Methods/experimental-setup passives describing standard procedure: "The data was
  tokenized with SentencePiece", "Models were trained for 10 epochs." The agent (the
  authors) is obvious and uninformative.
- Passives keeping the topic in subject position for cohesion: "These embeddings are then
  passed to the decoder."

## Field terminology that overlaps with AI vocabulary

Flag these only when used as decoration, never when used as technical terms:

- *robust / robustness* — a measured property (robustness to noise, adversarial
  robustness). "A robust improvement" is filler; "robust to distribution shift" is not.
- *leverage* — borderline even in ML ("leverage a pretrained encoder" → "use"), but so
  common it is at most **low** severity when it takes a concrete technical object.
- *alignment / aligned* — technical in RLHF/safety and in MT (word alignment).
- *grounding / grounded* — technical in multimodal and dialogue work.
- *emergent / emergence* — technical in scaling-law literature.
- *attention, transformer, diffusion, distillation, hallucination* — model terminology.
- *significant / significantly* — fine when a statistical test is reported nearby; flag
  as overclaiming (category `AC`) only when no test backs it.
- *novel* — conventional in contribution claims; flag only when repeated (3+ uses) or
  applied to something the related-work section shows is not new.
- *framework, pipeline, architecture* — fine as concrete referents to a system being
  described; a tell only when cycled as synonyms for one thing.
- Frozen terms of art — never synonym-swap these in rewrites, even to fix elegant
  variation: *ablation study* (not "component analysis"), *baseline* vs *benchmark*
  (different things, not interchangeable), *corpus* vs *dataset* (a corpus is the
  linguistic-specific term). Repetition of the correct term of art is correct.

## Structure and formatting

- Rule of three where the items are the actual complete set (three experiments, three
  baselines, three languages).
- Title-case section headings when the venue style requires them (ACL and most *CL
  venues do — check the style file before flagging).
- Boldface in definitions ("we call this \textbf{binary collapse}"), table headers, and
  the first use of a named method.
- Em dashes used sparingly (≤ ~2 pairs per page) and correctly — the threshold is
  density, not existence.
- Enumerated inline lists "(1) ..., (2) ..., (3) ..." — standard in abstracts and intros.
- `\textit{}` on newly introduced terms and non-English words.

## Citation-adjacent

- "Prior work has shown X [1,2,3]" — vague attribution *with* citations is normal; flag
  only if the breadth claim clearly exceeds what the citations could support ("many
  studies" backed by one citation).
- Direct quotes and claims attributed to specific cited papers — never rewrite the claim
  content, even if the wording trips a pattern.

## Human-writing signals to preserve, not "fix"

- Varied sentence length, including very short sentences — one clipped sentence landing
  a point is emphasis, not staccato drama (that needs a run of them).
- A single deliberate hedge on the authors' interpretation of their own results
  ("we suspect this reflects...") — informed speculation, clearly marked, is normal
  Discussion-section writing, not speculative gap-filling.
- First-person singular in acknowledgments; idiosyncratic phrasing; dry humor.
- Repetition of the *correct technical term* — do not introduce synonyms to reduce
  repetition; that would create elegant variation.
- Hedges chosen deliberately and used once per claim.
