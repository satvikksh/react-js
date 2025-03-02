(class
  name: (constant) @start
  superclass: (superclass)? @start
  "end" @end
 (#set! role type)
 (#set! scope.byLine)
)

(singleton_class
  value: (identifier) @start
  "end" @end
 (#set! role type)
 (#set! scope.byLine)
)

(module
  name: (constant) @start
  (#set! role type)
  "end" @end
)

(method
  name: (identifier) @start
  parameters: (method_parameters)? @start
  "end" @end
 (#set! role function)
 (#set! scope.byLine)
)
(singleton_method
  name: (identifier) @start
  parameters: (method_parameters)? @start
  (#set! role function)
  "end" @end
)

(block
  "{" @start
  "}" @end
)
(hash
  "{" @start
  "}" @end
)

(begin
  "begin" @start
  (rescue)? @end
  "end" @end
 (#set! scope.byLine)
)
(rescue
  "rescue" @start
  exceptions: (exceptions)? @start
  variable: (exception_variable)? @start
  (#set! scope.byLine)
) @end.after

(if
  consequence: (then) @start.before
  alternative: [(elsif) (else)]? @end
  "end" @end
 (#set! scope.byLine)
)
(elsif
  consequence: (then) @start.before
  alternative: [(elsif) (else)]? @end
 (#set! scope.byLine)
) @end.after
(else
  "else" @start
  (#set! scope.byLine)
) @end.after

(unless
  (then) @start.before
  "end" @end
 (#set! scope.byLine)
)

(do
  (_)
  "end" @end
 (#set! scope.byLine)
) @start.before

(do_block
  "do" @start
  "end" @end
 (#set! scope.byLine)
)
