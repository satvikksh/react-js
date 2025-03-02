; Types
(class_body
    "{" @start
    "}" @end
    (#set! role class)
)

; Functions
(function_expression
  body: (statement_block
  "{" @start
  "}" @end)
  (#set! role function)
)
(function_declaration
  body: (statement_block
  "{" @start
  "}" @end)
  (#set! role function)
)
(generator_function
  body: (statement_block
  "{" @start
  "}" @end)
  (#set! role function)
)
(generator_function_declaration
  body: (statement_block
  "{" @start
  "}" @end)
  (#set! role function)
)
(arrow_function
  body: (statement_block
  "{" @start
  "}" @end)
  (#set! role function)
)
(method_definition
  body: (statement_block
  "{" @start
  "}" @end)
  (#set! role function)
)

; Statements
(try_statement
  body: (statement_block
      "{" @start
      "}" @end
  ))
(catch_clause
  body: (statement_block
      "{" @start
      "}" @end
  ))
(finally_clause
  body: (statement_block
      "{" @start
      "}" @end
  ))
(with_statement
  body: (statement_block
      "{" @start
      "}" @end
  ))
(for_statement
  body: (statement_block
      "{" @start
      "}" @end
  ))
(for_in_statement
  body: (statement_block
      "{" @start
      "}" @end
  ))
(while_statement
  body: (statement_block
      "{" @start
      "}" @end
  ))
(do_statement
  body: (statement_block
      "{" @start
      "}" @end
  ))
(labeled_statement
  body: (statement_block
      "{" @start
      "}" @end
  ))
(switch_statement
  body: (switch_body
      "{" @start
      "}" @end
  ))
(switch_case
  body: (statement_block
      "{" @start
      "}" @end
  ))
(switch_default
  body: (statement_block
      "{" @start
      "}" @end
  ))
(if_statement
  consequence: (statement_block
      "{" @start
      "}" @end
  ))
(else_clause
  (statement_block
      "{" @start
      "}" @end
  ))
(statement_block
  (statement_block
      "{" @start
      "}" @end
  ))

; Literals
(object
  "{" @start
  "}" @end)
(array
  "[" @start
  "]" @end)
(template_string
  "`" @start
  "`" @end)
