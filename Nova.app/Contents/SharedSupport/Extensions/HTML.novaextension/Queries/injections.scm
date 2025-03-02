; Script tags
((script_element
  (raw_text) @injection.content)
 (#set! injection.language "javascript"))

; Style tags
((style_element
  (raw_text) @injection.content)
 (#set! injection.language "css"))
 
; Style attributes
(attribute
 (attribute_name) @_attrname
 (quoted_attribute_value
   (attribute_value) @injection.content)
 (#set! injection.language "css")
 (#set! injection.reset)
 (#match? @_attrname "(?i)^style$")
)

; Event handler attributes
(
  (start_tag
    (attribute
      (attribute_name) @name
      (quoted_attribute_value
        ["\"" "'"]
        (_) @injection.content
        ["\"" "'"])
    )
  )
  (#match? @name "(?i)^on(abort|auxclick|beforematch|blur|cancel|canplay|canplaythrough|change|click|close|contextlost|contextmenu|contextrestored|copy|cuechange|cut|dblclick|drag|dragend|dragenter|dragleave|dragover|dragstart|drop|durationchange|emptied|ended|error|focus|formdata|input|invalid|keydown|keypress|keyup|load|loadeddata|loadedmetadata|loadstart|mousedown|mouseenter|mouseleave|mousemove|mouseout|mouseover|mouseup|paste|pause|play|playing|progress|ratechange|reset|resize|scroll|securitypolicyviolation|seeked|seeking|select|slotchange|stalled|submit|suspend|timeupdate|toggle|volumechange|waiting|webkitanimationend|webkitanimationiteration|webkitanimationstart|webkittransitionend|wheel)$")
  (#set! injection.language "javascript")
  (#set! injection.reset)
)
