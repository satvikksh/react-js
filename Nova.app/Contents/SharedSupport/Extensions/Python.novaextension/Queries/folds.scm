((class_definition
  ":" @start
  body: (block) @end.after)
 (#set! role type)
)
(class_definition
  body: (block
    .
    (expression_statement
      (string
        (string_start) @start
        (string_end) @end
      )))
 (#set! role comment)
)

((function_definition
  ":" @start
  body: (block) @end.after)
 (#set! role function)
)

(function_definition
  body: (block
    .
    (expression_statement
      (string
        (string_start) @start
        (string_end) @end
      )))
 (#set! role comment)
)

(for_statement
  ":" @start
  body: (block) @end.after)

(if_statement
  ":" @start
  consequence: (block) @end.after)

(elif_clause
  ":" @start
  consequence: (block) @end.after)

(else_clause
  ":" @start
  body: (block) @end.after)

(while_statement
  ":" @start
  body: (block) @end.after)

(try_statement
  ":" @start
  body: (block) @end.after)

(except_clause
  ":" @start
  (block) @end.after)

(dictionary
  "{" @start
  "}" @end)

(list
  "[" @start
  "]" @end)

(tuple
  "(" @start
  ")" @end)

(argument_list
  "(" @start
  ")" @end)
