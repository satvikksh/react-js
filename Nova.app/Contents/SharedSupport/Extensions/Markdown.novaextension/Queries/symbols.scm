; Headings; Headings
(section
  .
  (atx_heading (atx_h1_marker) heading_content: (_) @name)
  (#set! role heading)
  (#set! scope.level 1)
) @subtree

(section
  .
  (setext_heading heading_content: (_) @name (setext_h1_underline))
  (#set! role heading)
  (#set! scope.level 1)
) @subtree

(section
  .
  (atx_heading (atx_h2_marker) heading_content: (_) @name)
  (#set! role heading)
  (#set! scope.level 2)
) @subtree

(section
  .
  (setext_heading heading_content: (_) @name (setext_h2_underline))
  (#set! role heading)
  (#set! scope.level 2)
) @subtree

(section
  .
  (atx_heading (atx_h3_marker) heading_content: (_) @name)
  (#set! role heading)
  (#set! scope.level 3)
) @subtree

(section
  .
  (atx_heading (atx_h4_marker) heading_content: (_) @name)
  (#set! role heading)
  (#set! scope.level 4)
) @subtree

(section
  .
  (atx_heading (atx_h5_marker) heading_content: (_) @name)
  (#set! role heading)
  (#set! scope.level 5)
) @subtree

(section
  .
  (atx_heading (atx_h6_marker) heading_content: (_) @name)
  (#set! role heading)
  (#set! scope.level 6)
) @subtree
