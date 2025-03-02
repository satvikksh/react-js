; Properties
;-----------

((member_expression
  property: (property_identifier) @identifier.property) @_expr
  (#not-has-parent? @_expr "call_expression" "jsx_opening_element" "jsx_closing_element" "jsx_self_closing_element"))
((member_expression
  property: (private_property_identifier) @identifier.property) @_expr
  (#not-has-parent? @_expr "call_expression"))

; Function and method definitions
;--------------------------------

(function_expression
  name: (identifier) @identifier.function)
(function_declaration
  name: (identifier) @identifier.function)
(method_definition
  name: (property_identifier) @identifier.method)

(pair
  key: (property_identifier) @identifier.key)

(assignment_expression
  left: (member_expression
    property: (property_identifier) @identifier.method)
  right: [(function_expression) (arrow_function)])

(variable_declarator
  name: (identifier) @identifier.method
  value: [(function_expression) (arrow_function)])

(assignment_expression
  left: (identifier) @identifier.method
  right: [(function_expression) (arrow_function)])

; Function and method calls
;--------------------------

((call_expression
  function: (identifier) @identifier.function) @_call
  (#not-has-parent? @_call "decorator"))

(call_expression
  function: (member_expression
    property: (property_identifier) @identifier.method))

; Decorators
;-----------

(decorator
  "@" @identifier.decorator.prefix
  (identifier)? @identifier.decorator
  (call_expression function: (identifier) @identifier.decorator)?)

; Special identifiers
;--------------------

((identifier) @identifier.type.constructor
 (#match? @identifier.type.constructor "^[A-Z]"))

([
    (identifier)
    (shorthand_property_identifier)
    (shorthand_property_identifier_pattern)
 ] @identifier.constant
 (#match? @identifier.constant "^[A-Z_][A-Z\\d_]+$"))

((identifier) @identifier.variable.builtin
 (#match? @identifier.variable.builtin "^(arguments|module|console|window|document)$"))

((identifier) @identifier.function.builtin
 (#eq? @identifier.function.builtin "require"))

; Literals
;---------

(this) @keyword.self
(super) @keyword.self

[
  (true)
  (false)
] @value.boolean

[
  (null)
  (undefined)
] @value.null

(comment) @comment

[
  (string
    ["\"" "'"] @string.delimiter.left
    ["\"" "'"] @string.delimiter.right
  )
  (template_string
    "`" @string.delimiter.left
    "`" @string.delimiter.right
  )
] @string

(template_substitution) @embedded
(template_substitution
  . "${" @processing.delimiter.left
  "}" @processing.delimiter.right . )

(regex) @regex
(regex "/" @regex.delimiter) @regex

(number) @value.number

; Tokens
;-------

[
  ";"
  "."
  ","
] @punctuation.delimiter

(optional_chain) @operator

(spread_element
  "..." @operator
)

(binary_expression
  operator: "/" @operator)

[
  "-"
  "--"
  "-="
  "+"
  "++"
  "+="
  "*"
  "*="
  "**"
  "**="
  ;"/" Handled separately for regex
  "/="
  "%"
  "%="
  ;"<" Handled separately for jsx except below
  "<="
  "<<"
  "<<="
  "="
  "=="
  "==="
  "!"
  "!="
  "!=="
  "=>"
  ;">" Handled separately for jsx except below
  ">="
  ">>"
  ">>="
  ">>>"
  ">>>="
  "~"
  "^"
  "&"
  "|"
  "^="
  "&="
  "|="
  "&&"
  "||"
  "??"
  "&&="
  "||="
  "??="
] @operator

(binary_expression operator: "<" @operator)
(binary_expression operator: ">" @operator)

(ternary_expression "?" @operator ":" @operator)

[
  "("
  ")"
  "["
  "]"
  "{"
  "${"
  "}"
]  @bracket

[
  "await"
  "break"
  "case"
  "catch"
  "class"
  "const"
  "continue"
  "debugger"
  "default"
  "delete"
  "do"
  "else"
  "finally"
  "for"
  "function"
  "if"
  "import"
  "let"
  "new"
  "return"
  "switch"
  "target"
  "throw"
  "try"
  "var"
  "void"
  "while"
  "with"
  "yield"
] @keyword

[
  "as"
  "async"
  "export"
  "extends"
  "from"
  "get"
  "in"
  "instanceof"
  "of"
  "set"
  "static"
  "typeof"
] @keyword.modifier
