(local_function_definition_statement
  name: [
    (identifier) @name
    (variable
      field: (identifier) @name)
    (variable
      method: (identifier) @name)
  ] @start @displayname
  parameters: (parameter_list)? @arguments.target
 (#set! role function)
 (#set! arguments.query "arguments.scm")
) @subtree

(function_definition_statement
  name: [
    (identifier) @name
    (variable
      field: (identifier) @name)
    (variable
      method: (identifier) @name)
  ] @start @displayname
  parameters: (parameter_list)? @arguments.target
 (#set! role function)
 (#set! arguments.query "arguments.scm")
) @subtree
