# Signs of AI-generated text in academic papers

Adapted from Wikipedia's [Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
and [blader/humanizer](https://github.com/blader/humanizer) (MIT, last synced at v2.9.1),
tuned for the academic register. Category code for findings: `AI`.

A single match is a smell, not proof. Density is the signal: several patterns in one
paragraph, or the same pattern repeated across sections. Always check
`academic-false-positives.md` before reporting a finding.

**Covered elsewhere — do not double-report here:** filler phrases, hedging stacks, and
passive voice are Clarity (`CL`) patterns; hyphenation drift and predicate-position
hyphens ("the method is data-driven") are Grammar (`GR`). If one of those co-occurs with
AI tells in the same paragraph, mention the cluster in the AI finding's "why" but file
the finding under its own category.

## 1. Vocabulary tells

**AI vocabulary (high frequency in LLM output, rare in careful human prose).**
Flag when used as filler rather than with technical meaning:

- Verbs: *delve (into), leverage, harness, foster, underscore, showcase, bolster,
  streamline, unlock, empower, elevate, navigate (a landscape), spearhead, garner,
  enhance (as vague improvement), highlight (as verb of emphasis), exemplify*
- Adjectives: *crucial, pivotal, vital, seamless, robust (as praise, not a property being
  measured), comprehensive, invaluable, groundbreaking, notable, myriad, multifaceted,
  intricate, nuanced (as filler), key (as decoration: "a key aspect"), valuable,
  vibrant, profound, enduring, rich (figurative: "a rich literature")*
- Nouns: *tapestry, landscape (metaphorical), realm, testament, journey, synergy,
  paradigm (outside Kuhn contexts), cornerstone, plethora, interplay (without saying
  what interacts how)*
- Promotional register (rare in papers, automatic flags): *renowned, cutting-edge,
  state-of-the-art as praise for one's own unevaluated method, a commitment to,
  revolutionize, game-changing, innovative/pioneering/transformative (self-applied),
  breakthrough, remarkable, superior (without a comparison), pave(s) the way*
- Connectives opening sentences: *Moreover, Furthermore, Additionally, Notably,
  Importantly, Interestingly, Crucially, Building on this, Taking this a step further*
  — flag when 3+ paragraphs in a row open with one, or when one section uses them more
  than ~once per paragraph.
- Newer-model favorites (2025+): *aligns with, highlights, showcasing, underscores,
  it's important to note, a key aspect of*

**Copula avoidance.** Simple "is/are" replaced with dressier verbs: *serves as,
functions as, acts as, stands as, marks, represents, constitutes, boasts, features*.
"X serves as a baseline" → "X is our baseline".

**Elegant variation (synonym cycling).** The same concept renamed every mention to avoid
repetition: *model → architecture → system → framework → approach* within one
paragraph. In papers, terminological consistency beats variety; flag the cycling, and in
the rewrite pick one term.

## 2. Rhetorical structures

**Rule of three.** Triads used to manufacture comprehensiveness: "adjective, adjective,
adjective" ("a simple, scalable, and effective method") and three-item lists where the
paper only supports one or two. Flag when the triad is padding; do not flag when the
three items are genuinely the complete enumerated set (see false positives).

**Negative parallelism.** "Not just X, but Y", "not only ... but also", "not X — rather Y",
"X isn't about Y; it's about Z". One instance is fine; flag from the second occurrence in a
paper, or any instance that corrects a misconception nobody holds.

**Tailing negations and staccato fragments.** Clipped verbless negations tacked on for
punch: "..., no retraining required", "No extra parameters. No task-specific heads."
A run of two or more short fragments engineered for drama is a tell; one short sentence
used for emphasis is not. Rewrite as a real clause ("without retraining").

**Persuasive authority tropes.** Phrases that stage a reveal of some deeper truth, then
restate an ordinary point: "the real question is", "at its core", "fundamentally",
"what really matters", "the deeper issue", "the heart of the matter". Flag when the
sentence that follows adds no new content.

**Aphorism formulas.** Template profundity: "X is the Y of Z", "the currency of",
"the language of", "X is not a tool but a mirror", "X becomes a trap". Replace with the
concrete claim the formula gestures at.

**Superficial -ing analysis.** A trailing participial clause bolted onto a factual sentence
to assert unearned significance: "..., highlighting the importance of robust evaluation",
"..., underscoring the need for further research", "..., demonstrating the potential of
LLMs". The clause is synthesis without support — either the point deserves its own
supported sentence, or it should be cut.

**Significance inflation.** Claims of importance instead of demonstrated results:
"marks a pivotal shift", "plays a vital role", "has garnered significant attention",
"is of paramount importance", "represents a major milestone". In a paper, importance is
argued from evidence and citations, not asserted.

**False ranges.** "From X to Y" constructions where X and Y are not endpoints of a real
scale: "from healthcare to education", "spanning classification to generation".

**Manufactured balance.** Decorative "on one hand ... on the other hand" framing where
the paper doesn't actually weigh two comparable alternatives. A real trade-off backed
by numbers (precision vs. recall) is not a finding.

**Vague attribution.** Opinions assigned to unnamed groups: "researchers argue",
"experts believe", "it is widely recognized", "many studies have shown" *without a
citation attached*. With a citation, check that the citation plausibly covers the claim's
breadth (one paper cited for "many studies").

**Speculative gap-filling.** A guess dressed up as fact where a citation or measurement
should be: "it is believed that", "presumably", "likely" carrying a narrative claim with
no source ("this likely stems from the model's training data"). Say what is unknown,
cite something, or cut — a deliberate, single hedge on the authors' own interpretation
of their own results is fine (see false positives).

## 3. Content patterns

**Hollow section boilerplate.** "Challenges and Future Directions" content that states a
generic problem then a speculative solution, applicable to any paper in the field.
Conclusions that restate the abstract sentence-for-sentence. Closing paragraphs of the
shape "As the field continues to evolve, X will play an increasingly important role."

**Generic broader-impact sentences.** Statements true of almost any paper: "This work has
implications for a wide range of applications." If swapping in a different paper's title
leaves the sentence true, flag it.

**Manufactured punchlines.** Sentences engineered to sound quotable, especially as
section closers: "The question is not whether X, but when." "In the end, X is only as
good as Y." (Template-shaped variants are aphorism formulas, §2.)

**Signposting and chatty announcements.** Tutorial-voice meta-commentary announcing what
the text is about to do: "Let's dive into", "let's break this down", "here's what you
need to know", and fake-candid openers ("Here's the thing", "Honestly,"). Automatic
flags in a paper. Do NOT flag conventional academic signposting — roadmap paragraphs
("The remainder of this paper..."), "In this section, we describe..." — see false
positives.

**Fragmented headers.** A heading followed by a one-line warm-up that restates it before
the content starts: "\subsection{Evaluation} Evaluation is a critical component of our
study. We evaluate..." Cut the warm-up sentence.

**Knowledge-cutoff / chatbot artifacts.** "As of [date]", "While specific details are not
publicly available", "It is worth noting that information may have changed", first-person
assistant voice ("I hope this helps"), leftover prompt or citation artifacts
(`contentReference`, `oaicite`, `turn0search`, `[cite: 1]`, `grok_card`,
`attached_file`), unfilled template slots ("[Insert dataset name]"), text that cuts off
mid-sentence (a truncated generation pasted without reading to the end). Any of these
is automatically **high** severity.

**Revision narration left in the body.** Prose narrating the edit instead of the content:
"In this revised version, we have added...", "As suggested, we now clarify...",
"(added per reviewer request)". Response-letter voice pasted into the paper; **high**
severity in a camera-ready.

## 4. Formatting and punctuation

- **Em/en-dash overuse.** LLMs reach for `---`/`--`/`—` where a comma, colon, or period
  would do. Count per page (~40 lines of prose); more than ~2 em-dash pairs per page is a
  tell. In LaTeX, `---` renders as an em dash — count it.
- **Boldface overuse.** Mechanical `\textbf{}`/`**bold**` on key terms outside
  definitions, headings, and table headers ("key takeaways" styling).
- **Inline-header bullet lists.** Bullets of the shape "**Term:** description" where prose
  would read better (common in AI-drafted related-work sections).
- **Title Case in headings** where the venue style is sentence case (check the style file:
  ACL uses title case for sections, so do not flag it in ACL papers).
- **Emoji, horizontal rules before headings** — rare in papers, automatic flags when
  present.
- **Curly quotes in LaTeX source** — a paste-from-chatbot tell (LaTeX authors type
  `` ` ``/`''`), and they typeset wrong. In Markdown/plain-text drafts they are NOT a
  tell on their own: word processors auto-curl. There, count them only alongside other
  patterns.

## 5. Severity guide for AI findings

- **High**: chatbot/citation artifacts; revision narration in a camera-ready; chatty
  signposting ("Let's dive in"); vague attribution or speculative gap-filling without
  citation on a load-bearing claim; significance inflation in the abstract or intro;
  promotional register applied to the authors' own work; 3+ distinct patterns in one
  paragraph.
- **Medium**: AI vocabulary as filler; superficial -ing clauses; negative parallelism
  (2nd+ instance); tailing negations and staccato runs; copula avoidance; elegant
  variation; persuasive authority tropes; aphorism formulas; fragmented headers.
- **Low**: isolated connective openers; mild rule-of-three; em-dash density slightly above
  threshold; single decorative adjective; a lone short fragment used for emphasis;
  manufactured balance.
