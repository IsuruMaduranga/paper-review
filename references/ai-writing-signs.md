# Signs of AI-generated text in academic papers

Adapted from Wikipedia's [Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
and [blader/humanizer](https://github.com/blader/humanizer) (MIT), tuned for the academic register.
Category code for findings: `AI`.

A single match is a smell, not proof. Density is the signal: several patterns in one
paragraph, or the same pattern repeated across sections. Always check
`academic-false-positives.md` before reporting a finding.

## 1. Vocabulary tells

**AI vocabulary (high frequency in LLM output, rare in careful human prose).**
Flag when used as filler rather than with technical meaning:

- Verbs: *delve (into), leverage, harness, foster, underscore, showcase, bolster,
  streamline, unlock, empower, elevate, navigate (a landscape), spearhead*
- Adjectives: *crucial, pivotal, vital, seamless, robust (as praise, not a property being
  measured), comprehensive, invaluable, groundbreaking, notable, myriad, multifaceted,
  intricate, nuanced (as filler)*
- Nouns: *tapestry, landscape (metaphorical), realm, testament, journey, synergy,
  paradigm (outside Kuhn contexts), cornerstone, plethora*
- Connectives opening sentences: *Moreover, Furthermore, Additionally, Notably,
  Importantly, Interestingly, Crucially* — flag when 3+ paragraphs in a row open with
  one, or when one section uses them more than ~once per paragraph.
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

**Vague attribution.** Opinions assigned to unnamed groups: "researchers argue",
"experts believe", "it is widely recognized", "many studies have shown" *without a
citation attached*. With a citation, check that the citation plausibly covers the claim's
breadth (one paper cited for "many studies").

## 3. Content patterns

**Hollow section boilerplate.** "Challenges and Future Directions" content that states a
generic problem then a speculative solution, applicable to any paper in the field.
Conclusions that restate the abstract sentence-for-sentence. Closing paragraphs of the
shape "As the field continues to evolve, X will play an increasingly important role."

**Generic broader-impact sentences.** Statements true of almost any paper: "This work has
implications for a wide range of applications." If swapping in a different paper's title
leaves the sentence true, flag it.

**Manufactured punchlines and aphorisms.** Sentences engineered to sound quotable:
"The question is not whether X, but when." "In the end, X is only as good as Y."

**Knowledge-cutoff / chatbot artifacts.** "As of [date]", "While specific details are not
publicly available", "It is worth noting that information may have changed", first-person
assistant voice ("I hope this helps"), leftover prompt or citation artifacts
(`contentReference`, `oaicite`, `turn0search`, `[cite: 1]`, `grok_card`,
`attached_file`). Any of these is automatically **high** severity.

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
- **Emoji, curly quotes in source, horizontal rules before headings** — rare in papers,
  automatic flags when present.

## 5. Severity guide for AI findings

- **High**: chatbot/citation artifacts; vague attribution without citation on a load-bearing
  claim; significance inflation in the abstract or intro; 3+ distinct patterns in one
  paragraph.
- **Medium**: AI vocabulary as filler; superficial -ing clauses; negative parallelism
  (2nd+ instance); copula avoidance; elegant variation.
- **Low**: isolated connective openers; mild rule-of-three; em-dash density slightly above
  threshold; single decorative adjective.
