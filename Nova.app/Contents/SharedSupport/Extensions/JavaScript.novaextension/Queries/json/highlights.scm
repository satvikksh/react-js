; Pairs
;-------

(pair
  key: [
    (string
      .
      "\"" @identifier.key.delimiter.left
      "\"" @identifier.key.delimiter.left
      .
    ) @identifier.key
    (number) @identifier.key
  ])

; Literals
;-------

[
  (true)
  (false)
  (null)
] @keyword

(comment) @comment

(string
  .
  "\"" @string.delimiter.left
  "\"" @string.delimiter.right
  .
) @string

(number) @value.number

; Tokens
;-------

[
  ":"
  ","
] @punctuation.delimiter

[
  "["
  "]"
  "{"
  "}"
]  @bracket
