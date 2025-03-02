(prolog) @processing.prolog
(doctype) @processing.doctype

(tag_name) @tag.name
(erroneous_end_tag_name) @tag.name.error

(attribute
  (attribute_name) @tag.attribute.name
  ["="]? @tag.attribute.operator
  (quoted_attribute_value
    ["\"" "'"] @tag.attribute.value.delimiter.left
    (_)? @tag.attribute.value
    ["\"" "'"] @tag.attribute.value.delimiter.right
  )?
)

(start_tag ["<" ">"] @tag.bracket)
(end_tag ["</" ">"] @tag.bracket)
(self_closing_tag ["<" "/>"] @tag.bracket)

(cdata_start
  "<![" @cdata.delimiter
  "CDATA" @cdata.label
  "[" @cdata.delimiter)
(cdata_text) @cdata
(cdata_end
  "]]>" @cdata.delimiter)

(entity) @value.entity

(comment) @comment
