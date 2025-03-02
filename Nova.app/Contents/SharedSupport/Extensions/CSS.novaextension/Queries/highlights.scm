(comment) @comment
(js_comment) @comment

; Operators
[
  "~"
  ">"
  "+"
  "-"
  "*"
  "/"
  "="
  "^="
  "|="
  "~="
  "$="
  "*="
] @operator

; Keywords
"and" @keyword
"or" @keyword
"not" @keyword
"only" @keyword

; At Rules
"@import" @style.at
"@media" @style.at
"@charset" @style.at
"@namespace" @style.at
"@keyframes" @style.at
"@supports" @style.at
(at_keyword) @style.at

(keyword_query) @style.value.keyword
(feature_name) @identifier.property

(namespace_name) @identifier.type.declare

(keyframes_statement (keyframes_name) @identifier.type.declare)
(to) @keyword
(from) @keyword
(important) @keyword

; Selectors
(class_selector "." @style.selector.class.prefix . (class_name) @style.selector.class)
(id_selector "#" @style.selector.id.prefix . (id_name) @style.selector.id)
(pseudo_element_selector "::" @style.selector.pseudoelement.prefix . (tag_name) @style.selector.pseudoelement)
(pseudo_class_selector ":" @style.selector.pseudoclass.prefix . (class_name) @style.selector.pseudoclass)
((tag_name) @style.selector.element)
(attribute_name) @tag.attribute.name
(nesting_selector) @style.selector.nesting @operator
(universal_selector) @style.selector.universal @operator
(selectors "," @punctuation.delimiter)

; Declarations
(declaration (property_name) @style.attribute.name) @style.attribute
(declaration ":" @punctuation.delimiter)
(declaration ";" @punctuation.delimiter)

; Values
((plain_value) @style.value.keyword
  (#match? @style.value.keyword "^(?!--)"))
((plain_value) @style.identifier.property
  (#match? @style.identifier.property "^--"))
(string_value) @string
(color_value "#" @style.value.color.hex.prefix) @style.value.color.hex
(integer_value) @style.value.number
(float_value) @style.value.number
(unit) @style.value.number.unit

; Function Calls
(function_name) @identifier.function
(call_expression
  (function_name) @_func
  (arguments
    "("
    ")") @var-function.arguments
  (#eq? @_func "var")) @var-function

; Brackets
[ "{" "}" "(" ")" "[" "]" ] @bracket
