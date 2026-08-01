# Citation hygiene

Category code: `CIT`. Whether citations exist where needed, point where claimed, and
are used with correct mechanics. Several checks are mechanical — take candidates from
`scripts/mechanical-checks.sh` and triage them here. Never judge whether a cited paper
actually says what is claimed unless its title/venue in the .bib makes the mismatch
obvious; wording-level checks only.

## Patterns

**`\citet` vs `\citep` misuse (natbib/ACL style).** `\citet{x}` is textual — the name
is part of the sentence ("\citet{x} show that..."); `\citep{x}` is parenthetical
("...is heterogeneous \citep{x}"). Flag a parenthetical cite used as a sentence
subject ("\citep{x} show...") and a textual cite dangling after a claim it isn't the
subject of.

**Uncited strong claim.** A specific factual or comparative claim about prior work,
numbers, or the field with no citation in the sentence or the one before it. The
paper's own results need no citation (see false positives).

**Breadth mismatch.** "Many studies", "a long line of work", "extensive research"
backed by one or two citations — either add cites or narrow the claim.

**Mechanical integrity** (from the script): `\cite*` keys missing from the local
`.bib` files; bib entries never cited anywhere (dead weight, or a lost citation);
duplicate bib entries for the same work under two keys.

**arXiv-when-published.** A .bib entry citing the arXiv preprint of a paper whose
published version is standard (the anthology-style key or venue field reveals this).
Low severity; suggest the published version.

**Citation clumping.** Five-plus citations bolted to one vague sentence
("\citep{a,b,c,d,e,f}") where the works support different specific points — unpack
into the specific claims they actually back.

## False positives — do not flag

- The paper's own results, definitions, and design decisions — no citation needed.
- Common-knowledge field statements ("transformers are widely used in NLP").
- "Prior work [1,2,3]" with a breadth that matches the count — the pattern is fine,
  only the mismatch is a finding.
- Shared-task and dataset descriptions cited once at first mention and then used
  freely.
- Self-citations phrased anonymously in a review build (that's VC's concern, not CIT's).

## Severity

- **High**: `\cite` key missing from the .bib (build-breaking or renders as ?);
  uncited specific claim about a competitor's numbers.
- **Medium**: citet/citep misuse; breadth mismatch; duplicate bib entries; citation
  clumping on load-bearing claims.
- **Low**: never-cited bib entries; arXiv-when-published; clumping on background prose.
