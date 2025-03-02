((source_file . (comment) @processing)
  (#match? @processing "^#!/"))

[ "use" "no" "require" ] @keyword

[ "if" "elsif" "unless" "else" ] @keyword.condition

(conditional_expression [ "?" ":" ] @operator) 

[ "while" "until" "for" "foreach" ] @keyword.condition
("continue" @repeat (block))

[ "try" "catch" "finally" "defer" ] @keyword

"return" @keyword

[ "sub" "method" ] @keyword.construct

[ "map" "grep" "sort" ] @identifier.function.builtin

[ "package" "class" ] @keyword

[
  "do" "eval"
  "my" "our" "local" "state" "field"
  "last" "next" "redo" "goto"
  "undef"
] @keyword

[ "BEGIN" "INIT" "CHECK" "UNITCHECK" "END" ] @keyword.condition

(yadayada) @operator

(phaser_statement phase: _ @keyword)

(_ operator: _ @operator)
"\\" @operator

[
  "or" "and"
  "eq" "ne" "cmp" "lt" "le" "ge" "gt"
  "isa"
] @keyword

(eof_marker) @processing
(data_section) @comment

(pod) @comment

[
  (number)
  (version)
] @value.number

[
  (string_literal) 
  (interpolated_string_literal) 
  (quoted_word_list)
  (command_string) 
  (heredoc_content)
  (replacement)
  (transliteration_content)
] @string

(interpolated_string_literal
  (scalar
    "$" @identifier.variable.prefix.scalar))

(interpolated_string_literal
  (scalar
    (varname) @identifier.variable.scalar))

[
  (heredoc_token)
  (command_heredoc_token)
  (heredoc_end)
] @comment.doctag

[(escape_sequence) (escaped_delimiter)] @string.escape

(regexp_content) @regex

[
 (quoted_regexp)
  (match_regexp)
  (substitution_regexp)
] @regex.delimiter

(autoquoted_bareword) @string

(use_statement (package) @identifier.type)
(package_statement (package) @identifier.type)
(class_statement (package) @identifier.type)
(require_expression (bareword) @identifier.type)

(subroutine_declaration_statement name: (bareword) @identifier.function)
(method_declaration_statement name: (bareword) @identifier.method)
(attribute_name) @decorator
(attribute_value) @string

(label) @identifier.constant

(statement_label label: _ @identifier.constant)

(list_expression "," @operator)
(relational_expression operator: "isa" right: (bareword) @identifier.type)

(function) @identifier.function

(function_call_expression (function) @identifier.function)
(method_call_expression (method) @identifier.method)
(method_call_expression invocant: (bareword) @identifier.type)

(func0op_call_expression function: _ @identifier.function.builtin)
(func1op_call_expression function: _ @identifier.function.builtin)

([(function)(expression_statement (bareword))] @identifier.function.builtin
 (#match? @identifier.function.builtin
   "^(accept|atan2|bind|binmode|bless|crypt|chmod|chown|connect|die|dbmopen|exec|fcntl|flock|getpriority|getprotobynumber|gethostbyaddr|getnetbyaddr|getservbyname|getservbyport|getsockopt|glob|index|ioctl|join|kill|link|listen|mkdir|msgctl|msgget|msgrcv|msgsend|opendir|print|printf|push|pack|pipe|return|rename|rindex|read|recv|reverse|say|select|seek|semctl|semget|semop|send|setpgrp|setpriority|seekdir|setsockopt|shmctl|shmread|shmwrite|shutdown|socket|socketpair|split|sprintf|splice|substr|system|symlink|syscall|sysopen|sysseek|sysread|syswrite|tie|truncate|unlink|unpack|utime|unshift|vec|warn|waitpid|formline|open|sort)$"
))

; (ERROR) @error

(
  [(varname) (filehandle)] @identifier.constant.builtin
  (#match? @identifier.constant.builtin "^((ENV|ARGV|INC|ARGVOUT|SIG|STDIN|STDOUT|STDERR)|[_ab]|\\W|\\d+|\\^.*)$")
)

(scalar
  "$" @identifier.variable.prefix.scalar) @identifier.variable.scalar
(scalar_deref_expression
  [ "$" "*" ] @identifier.variable.prefix.scalar) @identifier.variable.scalar
(array
  "@" @identifier.variable.prefix.array) @identifier.variable.array
(arraylen
  "$#" @identifier.variable.prefix.array) @identifier.variable.array
(array_deref_expression
  [ "@" "*" ] @identifier.variable.prefix.array) @identifier.variable.array
(hash
  "%" @identifier.variable.prefix.hash) @identifier.variable.hash
(hash_deref_expression
  [ "%" "*" ] @identifier.variable.prefix.hash) @identifier.variable.hash

(array_element_expression
  array: (_) @identifier.variable.array)
(slice_expression
  array: (_) @identifier.variable.array)
(keyval_expression
  array: (_) @identifier.variable.array)

(hash_element_expression
  hash: (_) @identifier.variable.hash)
(slice_expression
  hash: (_) @identifier.variable.hash)
(keyval_expression
  hash: (_) @identifier.variable.hash)

(container_variable
  [ "$" "@" "%" ] @identifier.variable.prefix)
(slice_container_variable
  [ "@" "%" ] @identifier.variable.prefix)

(comment) @comment

([ "," ";" ] @punctuation.delimiter)
([ "=>" "->" ] @operator)

(
  [ "[" "]" "{" "}" "(" ")" ] @bracket
)

(_
  "{" @punctuation.special
  (varname)
  "}" @punctuation.special)

(varname 
  (block
    "{" @punctuation.special 
    "}" @punctuation.special))


