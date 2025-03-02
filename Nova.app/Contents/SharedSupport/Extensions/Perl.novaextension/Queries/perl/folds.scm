; Blocks
(block_statement
  "{" @start
  "}" @end
)

(conditional_statement
  block: (block
    "{" @start
    "}" @end)
)

(elsif
  block: (block
    "{" @start
    "}" @end)
)

(else
  block: (block
    "{" @start
    "}" @end)
)

(for_statement
  (block
    "{" @start
    "}" @end)
)

(cstyle_for_statement
  (block
  "{" @start
  "}" @end)
)

(loop_statement
  (block
    "{" @start
    "}" @end)
)

(try_statement
  (block
    "{" @start
    "}" @end)
)

(defer_statement
  (block
    "{" @start
    "}" @end)
)

(eval_expression
  (block
    "{" @start
    "}" @end)
)

; Types
(class_statement
  (block
    "{" @start
    "}" @end)
  (#set! role type)
)

; Functions
(subroutine_declaration_statement
  body: (block
    "{" @start
    "}" @end)
  (#set! role function)
)

(method_declaration_statement
  body: (block
    "{" @start
    "}" @end)
  (#set! role method)
)

(anonymous_subroutine_expression
  body: (block
    "{" @start
    "}" @end)
  (#set! role function)
)

(phaser_statement
  (block
    "{" @start
    "}" @end)
  (#set! role function)
)
