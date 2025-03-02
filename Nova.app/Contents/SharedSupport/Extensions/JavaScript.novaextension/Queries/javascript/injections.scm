; Parse the contents of tagged template literals using
; a language inferred from the tag.

(call_expression
  function: [
    (identifier) @injection.language
    (member_expression
      property: (property_identifier) @injection.language)
  ]
  arguments: (template_string 
    [
      (string_fragment) @injection.content
      (_)
    ]*
  )
 (#set! injection.reset)
)

; Parse regex syntax within regex literals

((regex_pattern) @injection.content
 (#set! injection.language "regex")
 (#set! injection.reset))

; Parse JSDoc annotations in comments

((comment) @injection.content
 (#set! injection.language "jsdoc")
 (#match? @injection.content "^/\\*\\*[^\\*]"))
