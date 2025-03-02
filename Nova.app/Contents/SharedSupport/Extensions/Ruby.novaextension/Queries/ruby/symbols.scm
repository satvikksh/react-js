; Method definitions
(
  [
    (method
      name: (_) @name
      parameters: (method_parameters)? @arguments.target)
    (singleton_method
      name: (_) @name
      parameters: (method_parameters)? @arguments.target)
  ] @subtree
 (#set! role method)
 (#set! arguments.query "ruby/arguments.scm")
)

((alias
  name: (_) @name)
 (#set! role method)
) @subtree

; Class definitions
(
  [
    (class
      name: [
        (constant) @name
        (scope_resolution
          name: (_) @name)
      ])
    (singleton_class
      value: [
        (constant) @name
        (scope_resolution
          name: (_) @name)
      ])
  ] @subtree
 (#set! role class)
)
