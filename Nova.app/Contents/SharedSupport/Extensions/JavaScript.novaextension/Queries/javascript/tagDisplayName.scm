; Tag name
(jsx_opening_element
  name: [
    (identifier)
    (member_expression)
    (jsx_namespace_name)
  ] @result
)
(jsx_self_closing_element
  name: [
    (identifier)
    (member_expression)
    (jsx_namespace_name)
  ] @result
)

; ID attributes, formatted to "#value"
((jsx_attribute
  (property_identifier) @_attrname
  (string
    (string_fragment) @result))
 (#match? @_attrname "(?i)^id$")
 (#prefix! @result "#")
)

; Class attributes, formatted to ".value"
((jsx_attribute
  (property_identifier) @_attrname
  (string
    (string_fragment) @result))
 (#match? @_attrname "(?i)^class$")
 (#replace! @result "\\s+" ".")
 (#prefix! @result ".")
)

; href, src, http-equiv, and name attributes, formatted to "- value"
((jsx_attribute
  (property_identifier) @_attrname
  (string
    (string_fragment) @result))
 (#match? @_attrname "(?i)^(src|href|http-equiv|name)$")
 (#prefix! @result " – ")
)
