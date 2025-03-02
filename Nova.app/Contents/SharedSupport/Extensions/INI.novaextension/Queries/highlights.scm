(section
  (section_name
    "[" @bracket
    (text) @string
    "]" @bracket))

(setting
  (setting_name) @identifier.key
  "="? @operator)

(setting
  (setting_value) @_value @value.number
  (#match? @_value "^\\s*-?(0b|0o|0x)?((\\d+(\\.\\d*)?)|(\\.\\d+))\\s*$")
)
(setting
  (setting_value) @_value @value.boolean
  (#match? @_value "^\\s*(true|false|yes|no|True|False|Yes|No|TRUE|FALSE|YES|NO)\\s*$")
)
(setting
  (setting_value) @_value @value.null
  (#match? @_value "^\\s*(null|nil|Null|Nil|NULL|NIL)\\s*$")
)

(comment) @comment
