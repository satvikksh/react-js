(emphasis
  (emphasis_delimiter) @markup.italic.delimiter) @markup.italic
(strong_emphasis
  (emphasis_delimiter) @markup.bold.delimiter) @markup.bold
(strikethrough
  (emphasis_delimiter) @markup.strikethrough.delimiter) @markup.strikethrough
(code_span
  (code_span_delimiter) @markup.code.delimiter) @markup.code

(backslash_escape) @markup.string.escape
(hard_line_break) @markup.string.escape 

(link_title) @markup.string
(link_destination) @markup.link

(link_label
  "[" @markup.link-label.bracket @punctuation.delimiter
  "]" @markup.link-label.bracket @punctuation.delimiter
  ) @markup.link-label
((link_label
  "[" @markup.link-label.bracket @punctuation.delimiter
  "]" @markup.link-label.bracket @punctuation.delimiter
  ) @markup.link-label.value.number
  (#match? @markup.link-label.value.number "^\[\d+\]$")
)

(uri_autolink) @markup.link
(email_autolink) @markup.link

(inline_link [ "[" "]" "(" ")" ] @markup.link-label.bracket @punctuation.delimiter)
(shortcut_link [ "[" "]" ] @markup.link-label.bracket @punctuation.delimiter)
(full_reference_link [ "[" "]" ] @markup.link-label.bracket @punctuation.delimiter)

(image "!" @operator)
(image_description) @markup.link-label
(image [ "[" "]" "(" ")" ] @markup.link-label.bracket @punctuation.delimiter)
