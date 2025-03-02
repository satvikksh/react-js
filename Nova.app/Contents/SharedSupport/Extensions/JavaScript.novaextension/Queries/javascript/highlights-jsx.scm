(jsx_opening_element
  "<" @jsx.tag
  [
    (identifier)
    (member_expression)
    (jsx_namespace_name)
  ] @jsx.tag.name
  ">" @jsx.tag
)
(jsx_closing_element
  "</" @jsx.tag
  [
    (identifier)
    (member_expression)
    (jsx_namespace_name)
  ] @jsx.tag.name
  ">" @jsx.tag
)
(jsx_self_closing_element
  "<" @jsx.tag
  [
    (identifier)
    (member_expression)
    (jsx_namespace_name)
  ] @jsx.tag.name
  "/>" @jsx.tag
)
(jsx_attribute
  (property_identifier) @jsx.tag.attribute.name)
(jsx_text) @jsx.text
