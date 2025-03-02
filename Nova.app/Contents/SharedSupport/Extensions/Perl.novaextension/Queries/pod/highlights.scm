[
  (pod_command)
  (command)
  (cut_command)
] @keyword

(command_paragraph
  command: (command) @keyword
  (#match? @keyword "^=head$")
  (content) @markup.heading)

(command_paragraph
  command: (command) @keyword
  (#match? @keyword "^=over$")
  (content) @value.number)

(command_paragraph
  command: (command) @keyword
  (#match? @keyword "^=item$")
  (content) @markup.list.item)

(command_paragraph
  command: (command) @keyword
  (#match? @keyword "^=encoding$")
  (content) @processing)

(command_paragraph
  command: (command) @keyword
  (#not-match? @keyword "^=(head|over|item|encoding)$")
  (content) @string)

(verbatim_paragraph (content) @text.literal)

(interior_sequence
  (sequence_letter) @character
  ["<" ">"] @punctuation.delimiter
)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "B")
  (content) @markup.bold)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "C")
  (content) @markup.code)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "F")
  (content) @markup.underline)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "I")
  (content) @markup.italic)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "L")
  (content) @markup.link)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "X")
  (content) @markup.reference)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "E")
  (content) @string.escape)
