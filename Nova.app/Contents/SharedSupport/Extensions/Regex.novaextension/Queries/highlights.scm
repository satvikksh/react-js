(pattern) @regex

[
  (identity_escape)
  (control_letter_escape)
  (character_class_escape)
  (control_escape)
  (start_assertion)
  (end_assertion)
  (boundary_assertion)
  (non_boundary_assertion)
] @regex.escape

(pattern_character) @regex.character

; (class_character) @regex.escape

(group_name) @regex.capture-group.name

[
  "("
  ")"
  "(?"
  "(?:"
  "(?<"
  ">"
  "["
  "]"
  "{"
  "}"
] @regex.bracket

[
  "*"
  "+"
  "?"
  "|"
  "="
  "!"
  (lazy)
] @regex.operator

; (count_quantifier
;   [
;     (decimal_digits) @value.number
;     "," @punctuation.delimiter
;   ])
