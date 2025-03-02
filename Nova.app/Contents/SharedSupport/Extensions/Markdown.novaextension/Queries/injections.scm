; Yaml frontmatter
((minus_metadata) @injection.content
 (#set! injection.language "yaml")
)

; Inline Markdown
(
(inline) @injection.content
(#set! injection.language "markdown_inline")
)

; HTML blocks
((html_block) @injection.content
 (#set! injection.language html)
 (#set! injection.combined))

; Fenced code blocks
(fenced_code_block
  (info_string (language) @injection.language)
  (code_fence_content) @injection.content
)
