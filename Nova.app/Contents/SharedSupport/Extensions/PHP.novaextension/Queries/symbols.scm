(class_declaration
  name: (name) @name
 (#set! role class)
) @subtree

(interface_declaration
  name: (name) @name
 (#set! role interface)
) @subtree

(trait_declaration
  name: (name) @name
 (#set! role type)
) @subtree

(enum_declaration
  name: (name) @name
 (#set! role enum)
) @subtree

(namespace_definition
  name: (namespace_name) @name
 (#set! role type)
) @subtree

(property_declaration
  (property_element
    (variable_name (_) @name)
  )
 (#set! role property)
) @subtree

(method_declaration
  name: (_) @name
  parameters: (formal_parameters) @arguments.target
 (#set! role method)
 (#set! arguments.query "arguments.scm")
) @subtree

(function_definition
  name: (_) @name
  parameters: (formal_parameters) @arguments.target
 (#set! role function)
 (#set! arguments.query "arguments.scm")
) @subtree
