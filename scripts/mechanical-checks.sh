#!/bin/sh
# mechanical-checks.sh — deterministic LaTeX checks for the paper-preflight skill.
# Usage: mechanical-checks.sh <main.tex>
# Prints candidate issues, one per line, prefixed with a category code (GR/CIT/VC).
# Output is triage INPUT for the reviewing agent, not findings: every line must be
# checked against the category's false-positive list before it may enter a report.

set -u
MAIN="${1:?usage: mechanical-checks.sh <main.tex>}"
[ -f "$MAIN" ] || { echo "error: $MAIN not found" >&2; exit 1; }
DIR=$(dirname "$MAIN")
TMP="${TMPDIR:-/tmp}/paper-preflight-$$"
mkdir -p "$TMP"
trap 'rm -rf "$TMP"' EXIT

# --- Collect source files: main + \input/\include siblings ---------------------
FILES="$MAIN"
for inc in $(grep -oE '\\(input|include)\{[^}]+\}' "$MAIN" 2>/dev/null \
             | sed -E 's/.*\{([^}]+)\}.*/\1/'); do
  for cand in "$DIR/$inc" "$DIR/$inc.tex"; do
    [ -f "$cand" ] && FILES="$FILES $cand"
  done
done

# Strip comments: drop whole-line comments and inline tails (keeping \% escapes),
# preserving line numbers via grep -n on per-file stripped copies.
strip_comments() { # $1 = file -> stripped copy on stdout, line numbers preserved
  sed -E 's/([^\\])%.*/\1/; s/^%.*//' "$1"
}

echo "== paper-preflight mechanical checks: $FILES"
for f in $FILES; do strip_comments "$f"; done > "$TMP/stripped_all"

# --- VC: documentclass mode ----------------------------------------------------
MODE=$(grep -oE '\\usepackage\[[^]]*\]\{acl\}|\\documentclass\[[^]]*\]' "$TMP/stripped_all" \
       | grep -oE 'review|final|preprint' | head -1)
echo "VC mode: documentclass/style option = ${MODE:-unknown}"

# --- CIT: cite keys vs .bib ----------------------------------------------------
grep -oE '\\[cC]ite[a-zA-Z]*\*?(\[[^]]*\])*\{[^}]+\}' "$TMP/stripped_all" \
  | sed -E 's/.*\{([^}]+)\}.*/\1/' | tr ',' '\n' | sed 's/ //g' | sort -u > "$TMP/cited"
BIBS=$(ls "$DIR"/*.bib 2>/dev/null)
if [ -n "$BIBS" ]; then
  grep -hoE '^[[:space:]]*@[a-zA-Z]+\{[^,]+,' $BIBS \
    | sed -E 's/.*\{([^,]+),.*/\1/' | sort -u > "$TMP/bibkeys"
  comm -23 "$TMP/cited" "$TMP/bibkeys" | sed 's/^/CIT cite key not in any .bib: /'
  comm -13 "$TMP/cited" "$TMP/bibkeys" | sed 's/^/CIT bib entry never cited: /'
  sort "$TMP/bibkeys" | uniq -d | sed 's/^/CIT duplicate bib key: /'
else
  echo "CIT note: no .bib files found next to $MAIN (skipping cite/bib checks)"
fi

# --- VC: refs vs labels ---------------------------------------------------------
grep -oE '\\[cC]?[rR]ef\{[^}]+\}' "$TMP/stripped_all" \
  | sed -E 's/.*\{([^}]+)\}.*/\1/' | tr ',' '\n' | sort -u > "$TMP/refs"
grep -oE '\\label\{[^}]+\}' "$TMP/stripped_all" \
  | sed -E 's/.*\{([^}]+)\}.*/\1/' | sort > "$TMP/labels"
sort -u "$TMP/labels" > "$TMP/labels_u"
comm -23 "$TMP/refs" "$TMP/labels_u" | sed 's/^/VC ref target has no label: /'
uniq -d "$TMP/labels" | sed 's/^/VC duplicate label: /'

# --- VC: draft debris ------------------------------------------------------------
# Rendered text (high concern) and comments (low concern: often gates missing content).
for f in $FILES; do
  strip_comments "$f" | grep -nE 'TODO|FIXME|XXX|TBD|\[REF\]|\?\?' \
    | sed "s|^|VC draft marker (renders) $f:|"
  grep -nE '(^|[^\\])%.*(TODO|FIXME|XXX|TBD)' "$f" \
    | sed "s|^|VC draft marker (in comment) $f:|"
done

# Placeholder/comment macros: find \newcommand defs that wrap colored text,
# then report body usages of those macros.
MACROS=$(grep -hoE '\\newcommand\\?\{?\\[a-zA-Z]+\}?\[?[0-9]?\]?\{[^}]*\\(textcolor|color)' $FILES \
         | grep -oE '\\newcommand\\?\{?\\[a-zA-Z]+' | grep -oE '\\[a-zA-Z]+$' | sort -u)
for m in $MACROS; do
  n=$(grep -cF "$m{" "$TMP/stripped_all")
  # subtract the definition line itself
  [ "$n" -gt 1 ] && printf 'VC colored placeholder macro still used in body: %s (%d uses)\n' "$m" "$((n-1))"
done

# --- GR: doubled words and curly quotes -----------------------------------------
# Doubled words via awk (ERE backreferences are not portable across grep flavors).
for f in $FILES; do
  strip_comments "$f" | awk '
    { line = $0
      # LaTeX commands (with one brace arg), sentence punctuation, and digits become
      # boundary tokens ("zz"), not deletions — deleting them would make the words
      # around them look adjacent and fabricate doubled words.
      gsub(/\\[a-zA-Z]+(\{[^{}]*\})?/, " zz ", line)
      gsub(/[.!?;:()&0-9]/, " zz ", line)
      line = tolower(line); gsub(/[^a-z ]/, " ", line)
      n = split(line, w, /[ ]+/)
      for (i = 2; i <= n; i++)
        if (length(w[i]) >= 2 && w[i] == w[i-1] && w[i] != "zz" && w[i] != "that" && w[i] != "had")
          printf "GR doubled word FILE:%d: %s %s\n", NR, w[i-1], w[i]
    }' | sed "s|FILE|$f|"
  strip_comments "$f" | grep -nE '[“”‘’]' | sed "s|^|GR curly quote in source $f:|"
done

echo "== end mechanical checks"
