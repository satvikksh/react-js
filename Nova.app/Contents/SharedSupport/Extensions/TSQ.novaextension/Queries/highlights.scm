; Strings
(string
  "\"" @string.delimiter.left
  "\"" @string.delimiter.right) @string
(escape_sequence) @string.escape

; Captures
"@" @identifier.variable.prefix
(capture
  (identifier) @identifier.variable)
((parameters
  (identifier) @value.number)
  (#match? @value.number "^[-+]?[0-9]+(.[0-9]+)?$"))

; Predicates
(predicate
  name: "#" @tag.framework.name.prefix)
(predicate
  name: (identifier) @tag.framework.name)
(predicate
  type: (predicate_type) @tag.framework.name)

; Nodes
"_" @identifier.constant
(anonymous_node
  (identifier
    "\"" @string.delimiter.left
    "\"" @string.delimiter.right
  ) @string)
(named_node
  name: (identifier) @tag.name)
(field_definition
  name: (identifier) @tag.attribute.name)
(negated_field
  "!" @operator
  (identifier) @tag.attribute.name)

; Comments
(comment) @comment

; Operators
(quantifier) @operator
"." @operator

; Punctuation
[
  "["
  "]"
  "("
  ")"
] @bracket
":" @punctuation.delimiter
