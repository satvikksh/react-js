; Rulesets
((rule_set
    (_)* @name (block)) @subtree
    (#set! role style-ruleset)
)

; Media statements
((media_statement
    "@media" @name
    (_)* @name (block)) @subtree
    (#set! role style-directive)
)

; Custom properties
((declaration
    (property_name) @name) @subtree
    (#match? @name "^--")
    (#set! role property)
)

; ID selectors
((id_selector
    (id_name) @name) @subtree
    (#set! role style-id)
)

; Class selectors
((class_selector
    (class_name) @name) @subtree
    (#set! role style-class)
)
