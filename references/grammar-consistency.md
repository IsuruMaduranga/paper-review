# Grammar and consistency

Category code: `GR`. Surface correctness and one-paper-one-convention consistency.
Many candidates here come from `scripts/mechanical-checks.sh`; triage its output
against the false positives below before reporting.

## Grammar

- **Typos and doubled words** ("the the", "form" for "from", misspelled technical terms).
- **Subject–verb agreement**, especially across long subjects ("the set of edits ...
  were") and after Latin plurals (data/criteria/phenomena).
- **Article errors** — missing or spurious a/an/the, common in prose by non-native
  speakers. Flag the error, keep the tone neutral, and fix only clear cases; when a
  bare noun phrase is defensible (headlinese in captions, established jargon), skip it.
- **Dangling modifiers** ("Using constrained decoding, the dataset was evaluated").
- **Tense drift** — results narrated partly in past, partly in present, within one
  section. Convention: past for what was done, present for what the paper/figures show.

## Consistency (one paper, one convention)

- **Spelling variant drift**: US/UK mixing (modeling/modelling, tokenize/tokenise).
  Pick the majority variant; list every minority site.
- **Hyphenation drift**: fine-tuning vs finetuning, low-resource vs low resource
  (attributive vs predicative use is legitimate — see false positives), test-set vs
  test set.
- **Capitalization of named concepts**: a term the paper coins or capitalizes (Binary
  Collapse) must be capitalized the same way at every site.
- **Cross-artifact naming**: the same quantity must carry the same label in prose,
  table headers, captions, and figure legends (the "Prob." column vs "PMT" caption
  class of bug). Check tables/captions against the surrounding prose explicitly.
- **Number style**: 66k vs 66,082 vs "sixty-six thousand" — consistent style per
  context (approximations vs exact counts are legitimately different).
- **Abbreviation discipline**: expanded once at first use, abbreviation used
  thereafter; no re-expansions; no unexpanded first uses (standard field acronyms
  exempt, per the shared false-positives file).
- **LaTeX spacing**: missing `~` before `\ref`/`\cite` (line-breakable references),
  `\eg`/`e.g.,` style drift.
- **Misdirected cross-reference**: the `\ref` resolves (so the mechanical check passes)
  but the prose describes the wrong target — "see Table~2 for hyperparameters" when
  Table 2 holds dataset statistics. Flag only when the mismatch is unambiguous from
  reading both sites; a loose pointer that is broadly right is not a finding.

## False positives — do not flag

- Attributive vs predicative hyphenation: "low-resource languages" vs "the language is
  low resource" are both correct.
- Sentence-case vs title-case differences dictated by position (heading vs prose).
- Direct quotes and verbatim artifact text (prompts, dataset examples) — never
  "correct" quoted material.
- Deliberate singular "they".
- Tense differences that follow the past-for-methods / present-for-results convention.
- British vs American spelling inside proper nouns or cited titles.

## Severity

- **High**: a grammar error that changes or obscures meaning; a cross-artifact naming
  mismatch within one table/figure; a misdirected cross-reference.
- **Medium**: agreement/article/dangling-modifier errors; spelling or hyphenation drift
  with 2+ minority sites; capitalization drift of a coined term.
- **Low**: single-site drift; missing `~`; tense wobble; number-style inconsistency.
