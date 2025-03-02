(comment) @comment

(number) @value.number
(string) @string
(nil) @value.null
[
  (true)
  (false)
] @value.boolean

(call
  function: (variable
    name: (identifier) @identifier.function))
    
(call
  function: (variable
    field: (identifier) @identifier.method))
        
(call
  function: (variable
    method: (identifier) @identifier.method))

(variable
  field: (identifier) @identifier.property)

(variable
  (identifier) @identifier.constant
 (#match? @identifier.constant "^[A-Z][A-Z0-9_]*$")
)

(function_definition_statement
  name: (identifier) @identifier.method)
(function_definition_statement
  name: (variable
    table: (identifier) @identifier.type
    method: (identifier) @identifier.method))

(parameter_list
  (identifier) @identifier.argument)

(table
  (field_list
    (field
      key: (identifier) @identifier.key)))

[ "." ";" ":" "," ] @punctuation.delimiter
[ "(" ")" "[" "]" "{" "}" ] @bracket

[
  "import"
  "return"
  "local"
  "function"
  "end"
  "for"
  "in"
  "do"
  "if"
  "then"
  "elseif"
  "else"
  "repeat"
  "until"
  "while"
  "goto"
  "and"
  "or"
  "not"
] @keyword

((identifier) @keyword
 (#eq? @keyword "self")
)

(break_statement) @keyword

((attribute
  name: (identifier) @keyword.modifier)
 (#eq? @keyword.modifier "const")
)

[
  "="
  "+="
  "-="
  "*="
  "/="
  "//="
  "%="
  "<<="
  ">>="
  "&="
  "|="
  "^="
  "=="
  "~="
  "<"
  ">"
  "<="
  ">="
  "|"
  "~"
  "&"
  "<<"
  ">>"
  "+"
  "-"
  "*"
  "/"
  "//"
  "%"
] @operator
