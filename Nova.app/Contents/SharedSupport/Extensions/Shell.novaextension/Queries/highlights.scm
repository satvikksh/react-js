[
  (string)
  (raw_string)
  (heredoc_body)
  (heredoc_start)
] @string

((command_name) @identifier.function
  (#not-match? @identifier.function "^(\"|')")
)

(simple_expansion
  "$" @identifier.property.prefix
  (variable_name) @identifier.property)
(simple_expansion
  "$" @identifier.property
  (special_variable_name) @identifier.property)

(expansion
  (variable_name) @identifier.property)

(variable_assignment
  name: (variable_name) @identifier.variable)

(if_statement
  ";" @operator)
(elif_clause
  ";" @operator)
(while_statement
  ";" @operator)
(for_statement
  ";" @operator)
(for_statement
  variable: (variable_name) @identifier.variable)

((word) @value.number
  (#match? @value.number "^([0-9]+(\.[0-9]*)?|\.[0-9]+)$")
)

[
  "case"
  "done"
  "elif"
  "else"
  "esac"
  "export"
  "fi"
  "for"
  "function"
  "if"
  "local"
  "unset"
  "while"
] @keyword

[
  "do"
  "in"
  "then"
] @keyword.modifier

(comment) @comment

(function_definition name: (word) @identifier.function)

(file_descriptor) @value.number

(number) @value.number

[
  (command_substitution)
  (process_substitution)
  (expansion)
] @embedded

(command_substitution
  . "$(" @processing.delimeter.left
  ")" @processing.delimeter.left .)

(command_substitution
  . "$`" @processing.delimeter.left
  "`" @processing.delimeter.left .)

(process_substitution
  . ["<(" ">("] @processing.delimeter.left
  ")" @processing.delimeter.left .)

(expansion
  . "${" @processing.delimiter.left
  "}" @processing.delimiter.right . )

(test_operator) @operator

[
  "="
  "=="
  "=~"
  "!="
  "+"
  "-"
  "+="
  "-="
  ">"
  "<"
  ">="
  "<="
  "!"
  "&&"
  "||"
  ">>"
  "&>"
  "&>>"
  "<&"
  ">&"
  ">|"
  "|"
  "|&"
  "?"
  ":"
  ":?"
  ":-"
  "%"
  "#"
  "<("
  ">("
  ";;"
] @operator

[
  "["
  "]"
  "[["
  "]]"
  "("
  ")"
  "$("
  "(("
  "))"
  "{"
  "}"
  "${"
] @bracket

(
  (command (_) @identifier.constant)
  (#match? @identifier.constant "^-")
)
