; Tags
((element
  (start_tag (tag_name) @tag.start.name) @tag.start
  (end_tag (tag_name) @tag.end.name)? @tag.end)
)

; CDATA
((cdata
  (cdata_start
    "CDATA" @tag.start.name) @tag.start
  (cdata_end) @tag.end)
 (#set! role block)
)
