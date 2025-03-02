; Keywords

[
  "alias"
  "and"
  "begin"
  "break"
  "case"
  "class"
  "def"
  "do"
  "else"
  "elsif"
  "end"
  "ensure"
  "for"
  "if"
  "in"
  "module"
  "next"
  "or"
  "rescue"
  "retry"
  "return"
  "then"
  "undef"
  "unless"
  "until"
  "when"
  "while"
  "yield"
] @keyword

((identifier) @keyword
 (#match? @keyword "^(private|protected|public)$"))

; Function calls

((identifier) @identifier.method.builtin
 (#eq? @identifier.method.builtin "require"))

"defined?" @identifier.method.builtin

(call
  method: [(identifier) (constant)] @identifier.method)

; Function definitions

(alias (identifier) @identifier.method)
(setter (identifier) @identifier.method)
(method name: [(identifier) (constant)] @identifier.method)
(method name: (operator) @operator)
(singleton_method name: [(identifier) (constant)] @identifier.method)

; Class definitions

(class
  name: (constant) @identifier.type.class.declare
  superclass: (superclass
    "<" @operator
    (constant) @identifier.type.class)?)

; Module definitions

(module
  name: (constant) @identifier.type.module.declare
)

; Identifiers

[
  (class_variable)
  (instance_variable)
] @identifier.property

((identifier) @identifier.constant.builtin
 (#match? @identifier.constant.builtin "^__(FILE|LINE|ENCODING)__$"))

(file) @identifier.constant.builtin
(line) @identifier.constant.builtin
(encoding) @identifier.constant.builtin

(hash_splat_nil
  "**" @operator
) @identifier.constant.builtin

(self) @keyword
(super) @keyword

(block_parameter (identifier) @identifier.argument)
(block_parameters (identifier) @identifier.argument)
(destructured_parameter (identifier) @identifier.argument)
(hash_splat_parameter (identifier) @identifier.argument)
(lambda_parameters (identifier) @identifier.argument)
(method_parameters (identifier) @identifier.argument)
(splat_parameter (identifier) @identifier.argument)

(keyword_parameter name: (identifier) @identifier.argument)
(optional_parameter name: (identifier) @identifier.argument)

((constant) @identifier.type
 (#not-match? @identifier.type "^[A-Z\\d_]+$"))
((constant) @identifier.constant
 (#match? @identifier.constant "^[A-Z\\d_]+$"))

; Literals

[
  (string)
  (bare_string)
  (subshell)
  (heredoc_body)
] @string

(heredoc_beginning) @string.delimiter.left
(heredoc_end) @string.delimiter.left

[
  (simple_symbol)
  (delimited_symbol)
  (bare_symbol)
] @string.special.symbol

(regex) @string.special.regex
(escape_sequence) @string.escape

(hash_key_symbol) @identifier.key

(argument_list
  (pair
    key: (hash_key_symbol) @identifier.argument))

[
  (integer)
  (float)
] @value.number

(nil) @value.null

[
  (true)
  (false)
] @value.boolean

(interpolation) @embedded
(interpolation
  . "#{" @processing.delimiter.left
  "}" @processing.delimiter.right .)

(comment) @comment

; Operators

[
"="
"=>"
"->"
"+"
"-"
"*"
"/"
"%"
"**"
"=="
"!="
"<"
"<="
">"
">="
"<=>"
"==="
"+="
"-="
"*="
"/="
"%="
"**="
"&"
"|"
"^"
"~"
"<<"
">>"
"&="
"|="
"^="
"<<="
">>="
"&&"
"&&="
"||"
"||="
"!"
".."
"..."
"[]"
"[]="
] @operator

[
  ","
  ";"
  "."
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "%w("
  "%i("
  "#{"
] @bracket
