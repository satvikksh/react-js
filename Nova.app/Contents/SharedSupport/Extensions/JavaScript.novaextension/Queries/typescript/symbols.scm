; Object literal declarations
(
    (comment)* @doc
    .
    (lexical_declaration
        (variable_declarator
            name: (identifier) @name
            value: [(object) (object_pattern)]
        ) @subtree @_object
    ) 
    (#strip! @doc "^[\\s\\*/]+|^[\\s\\*/]$")
    (#select-adjacent! @doc @_object)
    (#set! role variable)
)
(
    (comment)* @doc
    .
    (variable_declaration
        (variable_declarator
        name: (identifier) @name
        value: [(object) (object_pattern)]
        ) @subtree @_object
    )
    (#strip! @doc "^[\\s\\*/]+|^[\\s\\*/]$")
    (#select-adjacent! @doc @_object)
    (#set! role variable)
    ; (#replace! @name "(.*)" "k\1")
)

; Method definitions
(
  (comment)* @doc
  .
  (method_definition
    ["get" "set"]? @_modifier
    name: [
      (property_identifier)
      (computed_property_name)
    ] @name
    parameters: (formal_parameters) @arguments.target
  ) @subtree @_method
  (#set-by-case-eq! @_modifier role
    "get" getter
    "set" setter
    method
  )
  (#not-eq? @name "constructor")
  (#strip! @doc "^[\\s\\*/]+|^[\\s\\*/]$")
  (#select-adjacent! @doc @_method)
  (#set! arguments.query "typescript/arguments.scm")
)

; Constructor definitions
((method_definition
    name: (property_identifier) @name
    parameters: (formal_parameters) @arguments.target) @subtree
  (#set! role constructor)
  (#eq? @name "constructor")
  (#set! arguments.query "typescript/arguments.scm")
)

; Property definition
((public_field_definition
    name: (property_identifier) @name) @subtree
  (#set! role property)
)

; Class definitions
(
  (comment)* @doc
  .
  [
    (class
      name: (_) @name)
    (class_declaration
      name: (_) @name)
  ] @subtree @_class
  (#set! role class)
  (#strip! @doc "^[\\s\\*/]+|^[\\s\\*/]$")
  (#select-adjacent! @doc @_class)
)

; Function definitions
(
  (comment)* @doc
  .
  [
    (function_expression
      name: (identifier) @name
      parameters: (formal_parameters) @arguments.target)
    (function_declaration
      name: (identifier) @name
      parameters: (formal_parameters) @arguments.target)
    (generator_function
      name: (identifier) @name
      parameters: (formal_parameters) @arguments.target)
    (generator_function_declaration
      name: (identifier) @name
      parameters: (formal_parameters) @arguments.target)
  ] @subtree @_function
  (#set! role function)
  (#strip! @doc "^[\\s\\*/]+|^[\\s\\*/]$")
  (#select-adjacent! @doc @_function)
  (#set! arguments.query "typescript/arguments.scm")
)

; Arrow or anonymous function definition
(
  (comment)* @doc
  .
  [
    (lexical_declaration
      (variable_declarator
        name: (identifier) @name
        value: [
          (arrow_function)
          (function_expression)
        ]) @subtree)
    (variable_declaration
      (variable_declarator
        name: (identifier) @name
        value: [
          (arrow_function)
          (function_expression)
        ]) @subtree)
  ] @_function
  (#set! role function)
  (#strip! @doc "^[\\s\\*/]+|^[\\s\\*/]$")
  (#select-adjacent! @doc @_function)
)

; Function assignment
((assignment_expression
    left: [
      (identifier) @name
      (member_expression
        property: (property_identifier) @name)
    ]
    right: [
      (arrow_function)
      (function_expression)
    ] @subtree
  )
  (#set! role function)
)

; Object pairs
((pair
   key: (property_identifier) @name
   value: [
     (object)
   ] @subtree)
   (#set! role class)
)
((pair
  key: (property_identifier) @name
  value: [
    (arrow_function)
    (function_expression)
  ] @subtree)
  (#set! role function)
)

; Object assignment
((assignment_expression
    left: [
      (identifier) @name
      (member_expression) @name
    ]
    right: [
      (object)
      (object_pattern)
    ] @subtree
  )
  (#set! role variable)
)


; Typealias declaration
((type_alias_declaration
  name: (type_identifier) @name)
 (#set! role type)
) @subtree

; Interface declaration
((interface_declaration
  name: (type_identifier) @name) @subtree
 (#set! role interface)
)

; Enum declaration
((enum_declaration
  name: (identifier) @name) @subtree
 (#set! role enum)
)

; Function signature
((function_signature
  name: (identifier) @name) @subtree
 (#set! role function)
)

; Method signature
((method_signature
  name: (property_identifier) @name) @subtree
 (#set! role method)
)
