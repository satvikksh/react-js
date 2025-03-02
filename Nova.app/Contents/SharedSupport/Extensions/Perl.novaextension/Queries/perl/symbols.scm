; Types
(class_statement
  name: (package) @name
  (#set! role class)
) @subtree

; Properties
(class_statement
  (block
    (expression_statement
      (variable_declaration
        variable: [
          (scalar (varname) @name)
          (array (varname) @name)
          (hash (varname) @name)
        ]) @subtree
    )
  )
  (#set! role property)
)
(class_statement
  (block
    (expression_statement
      (assignment_expression
        left: (variable_declaration
          variable: [
            (scalar (varname) @name)
            (array (varname) @name)
            (hash (varname) @name)
          ]) @subtree
      )
    )
  )
  (#set! role property)
)

; Functions
(subroutine_declaration_statement
  name: (bareword) @name
  (#set! role function)
) @subtree

(method_declaration_statement
  name: (bareword) @name
  (#set! role method)
) @subtree

(phaser_statement
  phase: _ @name
  (#set! role static-property)
) @subtree

; Globals
(source_file
  (expression_statement
    (variable_declaration
      variable: [
        (scalar (varname) @name)
        (array (varname) @name)
        (hash (varname) @name)
      ]) @subtree
  )
  (#set! role variable)
)
(source_file
  (expression_statement
    (assignment_expression
      left: (variable_declaration
        variable: [
          (scalar (varname) @name)
          (array (varname) @name)
          (hash (varname) @name)
        ]) @subtree
    )
  )
  (#set! role variable)
)
