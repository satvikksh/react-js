; Types
(class_declaration
  body: (declaration_list
    "{" @start
    "}" @end)
  (#set! role type)
)
(interface_declaration
  body: (declaration_list
    "{" @start
    "}" @end)
  (#set! role type)
)
(trait_declaration
  body: (declaration_list
    "{" @start
    "}" @end)
  (#set! role type)
)
(enum_declaration
  body: (enum_declaration_list
    "{" @start
    "}" @end)
  (#set! role type)
)

; Namespaces
(namespace_definition
  body: (compound_statement
    "{" @start
    "}" @end))

; Functions
(function_definition
  body: (compound_statement
    "{" @start
    "}" @end)
  (#set! role function)
)
(method_declaration
  body: (compound_statement
    "{" @start
    "}" @end)
  (#set! role function)
)
(anonymous_function
  body: (compound_statement
    "{" @start
    "}" @end)
  (#set! role function)
)

; Statements
(try_statement
  body: (compound_statement
    "{" @start
    "}" @end))
(catch_clause
  body: (compound_statement
    "{" @start
    "}" @end))
(finally_clause
  body: (compound_statement
    "{" @start
    "}" @end))
(while_statement
  body: (compound_statement
    "{" @start
    "}" @end))
(do_statement
  body: (compound_statement
    "{" @start
    "}" @end))
(if_statement
  body: (compound_statement
    "{" @start
    "}" @end))
(foreach_statement
  body: (compound_statement
    "{" @start
    "}" @end))
(for_statement
  (compound_statement
    "{" @start
    "}" @end))
(if_statement
  body: (compound_statement
    "{" @start
    "}" @end))
(else_if_clause
  body: (compound_statement
    "{" @start
    "}" @end))
(else_clause
  body: (compound_statement
    "{" @start
    "}" @end))
(switch_statement
  body: (switch_block
    "{" @start
    "}" @end))
(case_statement
  (compound_statement
    "{" @start
    "}" @end))
(default_statement
  (compound_statement
    "{" @start
    "}" @end))
(compound_statement
  (compound_statement
    "{" @start
    "}" @end))

; Literals
(array_creation_expression
  "[" @start
  "]" @end
)
