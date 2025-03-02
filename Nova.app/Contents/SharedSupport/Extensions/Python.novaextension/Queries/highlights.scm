; Properties
; -------------------

(attribute attribute: (identifier) @identifier.property)

; Function calls
; -------------------

; Non-built-in functions
((call
  function: (identifier) @identifier.function) @_call
  (#not-has-parent? @_call "decorator")
  (#not-match?
    @identifier.function
    "^(abs|all|any|ascii|bin|bool|breakpoint|bytearray|bytes|callable|chr|classmethod|compile|complex|delattr|dict|dir|divmod|enumerate|eval|exec|filter|float|format|frozenset|getattr|globals|hasattr|hash|help|hex|id|input|int|isinstance|issubclass|iter|len|list|locals|map|max|memoryview|min|next|object|oct|open|ord|pow|print|property|range|repr|reversed|round|set|setattr|slice|sorted|staticmethod|str|sum|super|tuple|type|vars|zip|__import__)$")
)

; Built-in functions
((call
  function: (identifier) @identifier.function.builtin) @_call
  (#not-has-parent? @_call "decorator")
  (#match?
    @identifier.function.builtin
    "^(abs|all|any|ascii|bin|bool|breakpoint|bytearray|bytes|callable|chr|classmethod|compile|complex|delattr|dict|dir|divmod|enumerate|eval|exec|filter|float|format|frozenset|getattr|globals|hasattr|hash|help|hex|id|input|int|isinstance|issubclass|iter|len|list|locals|map|max|memoryview|min|next|object|oct|open|ord|pow|print|property|range|repr|reversed|round|set|setattr|slice|sorted|staticmethod|str|sum|tuple|type|vars|zip|__import__)$"))
 
; Decorators
(decorator "@" @identifier.decorator.prefix)
(decorator (identifier) @identifier.decorator)
(decorator
  (attribute object: (identifier) @identifier.decorator))
(decorator
  (call
    function: (attribute
      object: (identifier))))

((call
  function: (identifier) @identifier.decorator) @_call
  (#has-parent? @_call "decorator")
)
((call
  function: (attribute object: (identifier) @identifier.decorator)) @_call
  (#has-parent? @_call "decorator")
)

; Methods
(call
  function: (attribute attribute: (identifier) @identifier.method)
  (#set! priority 10)
)

; super
((call
  function: (identifier) @keyword)
  (#eq? @keyword "super")
)

; Function definitions
; -------------------

(function_definition
  name: (identifier) @identifier.function)

(parameters
  [
    (identifier) @identifier.argument
    (default_parameter (identifier) @identifier.argument)
    (list_splat_pattern (identifier) @identifier.argument)
    (dictionary_splat_pattern (identifier) @identifier.argument)
    (typed_parameter (identifier) @identifier.argument)
    (typed_default_parameter
      name: (identifier) @identifier.argument)
  ]
  (#not-eq? @identifier.argument "self")
)

; Class definitions
; -------------------

(class_definition
  name: (identifier) @identifier.type.class.declare)

; Types
; -------------------

(type) @identifier.type

; Literals
; -------------------

((identifier) @keyword
  (#match? @keyword "^(self|super)$"))

(none) @value.null

[
  (true)
  (false)
] @value.boolean

[
  (integer)
  (float)
] @value.number

(string
  (string_start) @string.delimiter.left
  (string_end) @string.delimiter.right) @string
(escape_sequence) @string.escape

; Comments
; -------------------

(comment) @comment

(function_definition
  body: (block
    .
    (expression_statement
      (string
        (string_start) @comment.delimiter
        (string_end) @comment.delimiter
      ) @comment)
  )
  (#set! priority 10)
)
(class_definition
  body: (block
    .
    (expression_statement
      (string
      (string_start) @comment.delimiter
      (string_end) @comment.delimiter
      ) @comment)
  )
  (#set! priority 10)
)

; Keywords
; -------------------

[
  "and"
  "in"
  "is"
  "not"
  "or"
  "as"
  "assert"
  "async"
  "await"
  "break"
  "class"
  "continue"
  "def"
  "del"
  "elif"
  "else"
  "except"
  "exec"
  "finally"
  "for"
  "from"
  "global"
  "if"
  "import"
  "lambda"
  "nonlocal"
  "pass"
  "print"
  "raise"
  "return"
  "try"
  "while"
  "with"
  "yield"
  "match"
  "case"
] @keyword

; Punctuation
; -------------------

(interpolation) @embedded
(interpolation
  . "{" @processing.delimiter.left
  "}" @processing.delimiter.right .)

[
  "-"
  "-="
  "!="
  "*"
  "**"
  "**="
  "*="
  "/"
  "//"
  "//="
  "/="
  "&"
  "&="
  "%"
  "%="
  "^"
  "^="
  "+"
  "->"
  "+="
  "<"
  "<<"
  "<="
  "<>"
  "="
  ":="
  "=="
  ">"
  ">="
  ">>"
  "|"
  "|="
  "~"
] @operator

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
]  @bracket
