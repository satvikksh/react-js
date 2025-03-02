(local_function_definition_statement
  name: (_) @start
  ")"? @start
  "end" @end
 (#set! scope.byLine)
 (#set! role function)
)

(function_definition_statement
  name: (_) @start
  ")"? @start
  "end" @end
 (#set! scope.byLine)
 (#set! role function)
)

(if_statement
  "then" @start
  consequence: (_)?
  .
  alternative: [(elseif_clause) (else_clause)]? @end
  "end" @end
 (#set! scope.byLine)
)
(elseif_clause
  "then" @start
  consequence: (_)?
  .
  alternative: [(elseif_clause) (else_clause)]? @end
 (#set! scope.byLine)
) @end.after
(else_clause
  "else" @start
  (#set! scope.byLine)
) @end.after

(while_statement
  "do" @start
  "end" @end
 (#set! scope.byLine)
)

(for_generic_statement
  "do" @start
  "end" @end
 (#set! scope.byLine)
)

(for_numeric_statement
  "do" @start
  "end" @end
 (#set! scope.byLine)
)

(repeat_statement
  "repeat" @start
  "until" @end
 (#set! scope.byLine)
)

(do_statement
  "do" @start
  "end" @end
 (#set! scope.byLine)
)

(table
  "{" @start
  "}" @end)
