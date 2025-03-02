(comment) @comment
; For some reason, the YAML grammar defines some booleans as string scalars
((string_scalar) @string
  (#not-match? @string "(?i)^(yes|no|true|false|on|off)$")
)
((string_scalar) @value.boolean
  (#match? @value.boolean "(?i)^(yes|no|true|false|on|off)$")
)
(double_quote_scalar) @string
(single_quote_scalar) @string
(boolean_scalar) @value.boolean
(integer_scalar) @value.number
(float_scalar) @value.number
(null_scalar) @value.null
(block_mapping_pair key: (_) @identifier.key)
(tag) @identifier.type
(block_scalar "|" @operator) @string

[
  "---"
  "..."
  "-"
  "?"
  ":"
  ":"
  "|"
  ">"
  "["
  "]"
  "{"
  "}"
  ","
  "?"
  ":"
  "*"
  "&"
] @operator
