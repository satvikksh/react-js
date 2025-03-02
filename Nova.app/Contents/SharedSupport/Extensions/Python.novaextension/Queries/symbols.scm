; Class definitions
; --------------------

((class_definition
  name: (identifier) @name)
  (#set! role class)
) @subtree

; Function / method definitions
; --------------------

; Undecorated functions and methods
((function_definition
  name: (identifier) @name
  parameters: (parameters)? @arguments.target) @_def @subtree
  (#not-has-parent? @_def "decorated_definition")
  
  (#set-by-case-eq! @name role
    "__init__" constructor
    function-or-method
  )
  (#set! arguments.query "arguments.scm")
)

; Property declarations using `@property` or `@cached_property`
(decorated_definition
  (decorator (identifier) @_dec)+
  (#any-eq? @_dec "property" "cached_property")
  
  definition: (function_definition
    name: (identifier) @name
    parameters: (parameters)? @arguments.target) @subtree
  
  (#set! role property)
)

; Decorated functions and methods
(decorated_definition
  (decorator (identifier) @_dec)*
  (#not-eq? @_dec "property" "cached_property")
  
  ; Skip symbolicating setters and deleters
  (decorator
    (attribute
      object: (identifier) @_decobj
      attribute: (identifier) @_decattr))*
  (#not-eq? @_decattr "setter" "deleter")
  
  definition: (function_definition
    name: (identifier) @name
    parameters: (parameters)? @arguments.target) @subtree
  
  (#set-by-case-eq! @name role
    "__init__" constructor
    function-or-method
  )
  (#set! arguments.query "arguments.scm")
)

