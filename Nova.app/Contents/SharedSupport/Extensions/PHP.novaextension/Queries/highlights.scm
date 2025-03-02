; Shebang

((program . (text) @_text @processing.shebang)
  (#match? @_text "^#!")
)

; Types

(primitive_type) @identifier.type.builtin
(cast_type) @identifier.type.builtin
(named_type (name) @identifier.type)
(named_type (qualified_name (name) @identifier.type))
(optional_type "?" @operator)
(object_creation_expression (name) @identifier.type)
(object_creation_expression (qualified_name (name) @identifier.type))

(qualified_name
  prefix: "\\" @operator)
(qualified_name
  prefix: (namespace_name (name) @identifier.type.namespace))

(namespace_name "\\" @operator)

(class_declaration
  name: (name) @identifier.type.class.declare)
(enum_declaration
  name: (name) @identifier.type.enum.declare)
(interface_declaration
  name: (name) @identifier.type.interface.declare)
(trait_declaration
  name: (name) @identifier.type.trait.declare)

(namespace_definition
  name: (namespace_name (name) @identifier.type.namespace.declare))
(namespace_use_clause (name) @identifier.type)
(namespace_use_clause
  (qualified_name (name) @identifier.type))

(base_clause (name) @identifier.type)
(class_interface_clause (name) @identifier.type)

(use_declaration
  (name) @identifier.type.namespace)

; Attributes

(attribute (name) @processing.attribute)
(attribute
  (qualified_name (name) @processing.attribute))

; Functions

(array_creation_expression "array" @identifier.function.builtin)
(list_literal "list" @identifier.function.builtin)

(method_declaration
  name: (name) @identifier.method)

(function_call_expression
  function: (name) @identifier.function)
(function_call_expression
  function: (qualified_name (name)) @identifier.function)

(scoped_call_expression
  scope: (name) @identifier.type)
(scoped_call_expression
  scope: (qualified_name (name) @identifier.type))
(scoped_call_expression
  name: (name) @identifier.function)

(member_call_expression
  name: (name) @identifier.method)
(nullsafe_member_call_expression
  name: (name) @identifier.method)

(function_definition
  name: (name) @identifier.function)
  
; "exit" is a function in the grammar, but is a keyword in the language
(expression_statement (name) @keyword
  (#equal? @keyword "exit"))

(argument name: (name) @identifier.argument)

; Member

(property_element
  (variable_name "$" @identifier.property.prefix) @identifier.property)

(member_access_expression
  name: (variable_name "$" @identifier.property.prefix) @identifier.property)
(member_access_expression
  name: (name) @identifier.property)

; Variables

; (relative_scope) @identifier.variable.builtin

; ((name) @identifier.constant
;  (#match? @identifier.constant "^_?[A-Z][A-Z\\d_]+$"))

((name) @identifier.constant
  (#match? @identifier.constant "^__(LINE|FILE|DIR|FUNCTION|CLASS|TRAIT|METHOD|NAMESPACE)__$"))
((name) @identifier.constant
  (#match? @identifier.constant "^(M_PI|M_E|M_LOG2E|M_LOG10E|M_LN2|M_LN10|M_PI_2|M_PI_4|M_1_PI|M_2_PI|M_SQRTPI|M_SQRT2|M_SQRT3|M_SQRT1_2|M_LNPI|M_EULER|PHP_ROUND_HALF_UP|PHP_ROUND_HALF_DOWN|PHP_ROUND_HALF_EVEN|PHP_ROUND_HALF_ODD|NAN|INF|E_ERROR|E_WARNING|E_PARSE|E_NOTICE|E_CORE_ERROR|E_CORE_WARNING|E_COMPILE_ERROR|E_COMPILE_WARNING|E_USER_ERROR|E_USER_WARNING|E_USER_NOTICE|E_STRICT|E_RECOVERABLE_ERROR|E_DEPRECATED|E_USER_DEPRECATED|E_ALL)$"))

(class_constant_access_expression . (name) @identifier.type.class)
(class_constant_access_expression . (qualified_name (name) @identifier.type.class))
(class_constant_access_expression (name) @identifier.property . )

(object_creation_expression
  (name) @identifier.type.constructor
 (#match? @identifier.type.constructor "^[A-Z]"))

(binary_expression operator: "instanceof" right: (name) @identifier.type)
(binary_expression operator: "instanceof" right: (qualified_name (name) @identifier.type))

((variable_name "$" @identifier.variable.prefix) @identifier.variable
  (#not-has-parent? @identifier.variable "property_element" "member_access_expression"))

(member_access_expression object: (variable_name "$" @identifier.variable.prefix (name) @identifier.variable))

(use_as_clause . (name) @identifier.property (name) @identifier.key . )

; Basic tokens

(string
  "'" @string.delimiter.left
  "'" @string.delimiter.right) @string
(encapsed_string
  "\"" @string.delimiter.left
  "\"" @string.delimiter.right) @string
(shell_command_expression
  "`" @string.delimiter.left
  "`" @string.delimiter.right) @string
(heredoc
  "<<<" @string.delimiter.left
  identifier: (heredoc_start) @string.escape
  end_tag: (heredoc_end) @string.escape) @string
(nowdoc
  "<<<" @string.delimiter.left
  "'" @string.delimiter.left
  identifier: (heredoc_start) @string.escape
  "'" @string.delimiter.left
  end_tag: (heredoc_end) @string.escape) @string
(boolean) @value.boolean
(null) @value.null
(integer) @value.number
(float) @value.number
(comment) @comment

[
  "="
  "=>"
  "->"
  "?->"
  "::"
  "~"
  "!"
  "||"
  "&&"
  "|"
  "^"
  "&"
  "=="
  "!="
  "<>"
  "==="
  "!=="
  "<"
  ">"
  "<="
  ">="
  "<=>"
  "<<"
  ">>"
  "+"
  "-"
  "."
  "*"
  "/"
  "%"
  "|="
  "^="
  "&="
  "++"
  "--"
  "+="
  "-="
  ".="
  "*="
  "/="
  "%="
  "??"
  "??="
] @operator

(variadic_parameter "..." @operator)
(variadic_unpacking "..." @operator)

; Keywords

[
  "break"
  "case"
  "catch"
  "clone"
  "const"
  "continue"
  "default"
  "do"
  "echo"
  "else"
  "elseif"
  "enddeclare"
  "endfor"
  "endforeach"
  "endif"
  "endswitch"
  "endwhile"
  "exit"
  "finally"
  "for"
  "foreach"
  "goto"
  "if"
  "include"
  "include_once"
  "interface"
  "match"
  "new"
  "print"
  "require"
  "require_once"
  "return"
  "switch"
  "throw"
  "try"
  "unset"
  "while"
  "yield"
] @keyword

[
  "class"
  "enum"
  "fn"
  "function"
  "namespace"
  "trait"
] @keyword.construct

[
  "and"
  "or"
  "xor"
] @keyword.operator

[
  "abstract"
  "as"
  "declare"
  "extends"
  "final"
  "from"
  "global"
  "implements"
  "instanceof"
  "insteadof"
  "parent"
  "private"
  "protected"
  "public"
  "readonly"
  "self"
  "static"
] @keyword.modifier

((variable_name
  "$" @keyword.self.prefix
  (name) @keyword.self)
 (#eq? @keyword.self "this"))

(property_declaration (var_modifier) @keyword)

(use_declaration "use" @keyword)
(namespace_use_declaration "use" @keyword)
(anonymous_function_use_clause "use" @keyword.modifier)

(conditional_expression "?" @operator)
(conditional_expression ":" @operator)

["{" "}" "(" ")" "[" "]"] @bracket
(attribute_group "#[" @bracket)

[";" ","] @punctuation.delimiter
