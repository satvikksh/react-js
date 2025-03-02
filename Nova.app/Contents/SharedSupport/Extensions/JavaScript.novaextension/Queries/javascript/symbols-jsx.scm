; Tags with closing tags
(jsx_element
  open_tag: (jsx_opening_element
  name: [
    (identifier)
    (member_expression)
    (jsx_namespace_name)
  ] @name) @start.before @displayname.target
  close_tag: (jsx_closing_element)? @end.after
  (#not-match? @name "(?i)^(embed|keygen|param|source|wbr|area|hr|col|command|br|img|input|base|track|link|meta)$")
  (#set-by-case-match! @name role
    "(?i)^(h1|h2|h3|h4|h5|h6|header|hgroup)$" tag-heading
    "(?i)^(article|aside|main|nav|section)$" tag-section
    "(?i)^(ul)$" tag-ul
    "(?i)^(ol)$" tag-ol
    "(?i)^(li)$" tag-li
    "(?i)^(form)$" tag-form
    "(?i)^(input)$" tag-form-field
    "(?i)^(a)$" tag-anchor
    "(?i)^(link)$" tag-link
    "(?i)^(img)$" tag-image
    "(?i)^(meta)$" tag-meta
    tag
  )
  (#set-by-case-eq! @name scope.level
   "h1" 1
   "h2" 2
   "h3" 3
   "h4" 4
   "h5" 5
   "h6" 6
  )
  (#set! displayname.query "javascript/tagDisplayName.scm")
  (#set! autoclose.expression "</")
  (#set! autoclose.completion "${name}>")
  (#set! scope.extend)
)

; Tags without closing tags (void tags)
(jsx_element
  open_tag: (jsx_opening_element
  name: [
    (identifier)
    (member_expression)
    (jsx_namespace_name)
  ] @name) @subtree @displayname.target
 (#match? @name "(?i)^(embed|keygen|param|source|wbr|area|hr|col|command|br|img|input|base|track|link|meta)$")
 (#set-by-case-match! @name role
   "(?i)^(input)$" tag-form-field
   "(?i)^(link)$" tag-link
   "(?i)^(img)$" tag-image
   "(?i)^(meta)$" tag-meta
   tag
 )
 (#set! displayname.query "javascript/tagDisplayName.scm")
)

; Tags with an invalid end tag
((ERROR
  (jsx_opening_element
  name: [
    (identifier)
    (member_expression)
    (jsx_namespace_name)
  ] @name) @start.before @displayname.target)
 (#not-match? @name "(?i)^(embed|keygen|param|source|wbr|area|hr|col|command|br|img|input|base|track|link|meta)$")
 (#set-by-case-match! @name role
   "(?i)^(h1|h2|h3|h4|h5|h6|header|hgroup)$" tag-heading
   "(?i)^(article|aside|main|nav|section)$" tag-section
   "(?i)^(ul)$" tag-ul
   "(?i)^(ol)$" tag-ol
   "(?i)^(li)$" tag-li
   "(?i)^(form)$" tag-form
   "(?i)^(a)$" tag-anchor
   tag
 )
 (#set-by-case-eq! @name scope.level
   "h1" 1
   "h2" 2
   "h3" 3
   "h4" 4
   "h5" 5
   "h6" 6
 )
 (#set! displayname.query "javascript/tagDisplayName.scm")
 (#set! autoclose.expression "</")
 (#set! autoclose.completion "${name}>")
 (#set! scope.extend)
)

; Self-closing tags
((jsx_self_closing_element
  name: [
    (identifier)
    (member_expression)
    (jsx_namespace_name)
  ] @name) @subtree @displayname.target
  (#set-by-case-match! @name role
    "(?i)^(input)$" tag-form-field
    "(?i)^(link)$" tag-link
    "(?i)^(img)$" tag-image
    "(?i)^(meta)$" tag-meta
    tag
  )
  (#set! displayname.query "javascript/tagDisplayName.scm")
)
