(atx_heading) @markup.heading
(setext_heading) @markup.heading

[
  (atx_h1_marker)
  (atx_h2_marker)
  (atx_h3_marker)
  (atx_h4_marker)
  (atx_h5_marker)
  (atx_h6_marker)
  (setext_h1_underline)
  (setext_h2_underline)
] @markup.heading.prefix

(fenced_code_block
  (info_string
    (language) @markup.code-block.language))
(fenced_code_block_delimiter) @markup.code-block.delimiter

[
  (list_marker_plus)
  (list_marker_minus)
  (list_marker_star)
] @markup.list.item.unordered

[
  (list_marker_dot)
  (list_marker_parenthesis)
] @markup.list.item.ordered

(thematic_break) @markup.line

(backslash_escape) @markup.string.escape

(link_title) @markup.string
(link_destination) @markup.link

(link_label
  "[" @markup.link-label.bracket
  "]" @markup.link-label.bracket
  ) @markup.link-label
((link_label
  "[" @markup.link-label.bracket
  "]" @markup.link-label.bracket
  ) @markup.link-label.value.number
  (#match? @markup.link-label.value.number "^\\[\\d+\\]$")
)
