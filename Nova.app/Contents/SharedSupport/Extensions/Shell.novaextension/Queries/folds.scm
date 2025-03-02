((if_statement
  "then" @start
  (else_clause)? @end
  "fi" @end)
  (#set! scope.byLine)
)

((elif_clause
  "then" @start) @end.after
  (#set! scope.byLine)
)

((else_clause
  "else" @start) @end.after
  (#set! scope.byLine)
)

((do_group
  "do" @start
  "done" @end)
  (#set! scope.byLine)
)

((case_statement
  "in" @start
  "esac" @end)
  (#set! scope.byLine)
)

((case_item
  ")" @start) @end.after
  (#set! scope.byLine)
)

(function_definition
  body: (compound_statement
    "{" @start
    "}" @end)
  (#set! role function)
)
