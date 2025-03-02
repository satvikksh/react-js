(interface_declaration
  body: (interface_body
    "{" @start
    "}" @end)
  (#set! role class)
)

(enum_declaration
  body: (enum_body
    "{" @start
    "}" @end)
  (#set! role class)
)
