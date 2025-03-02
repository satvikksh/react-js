; Properties
;-----------

(public_field_definition (property_identifier) @identifier.property)
(public_field_definition (private_property_identifier) @identifier.property)

; Tokens
;-------

"?." @operator

[
  "enum"
  "interface"
  "namespace"
  "type"
] @keyword

[
  "abstract"
  "declare"
  "implements"
  "keyof"
  "override"
  "private"
  "protected"
  "public"
  "readonly"
] @keyword.modifier

; Types
;-------

(type_identifier) @identifier.type
(predefined_type) @identifier.type.builtin

(type_annotation ":" @operator)

(interface_declaration name: (type_identifier) @identifier.type.interface.declare)
(class_declaration name: (type_identifier) @identifier.type.class.declare)
(enum_declaration name: (identifier) @identifier.type.enum.declare)
(type_alias_declaration name: (type_identifier) @identifier.type.typealias.declare)

(type_parameters
  "<" @bracket
  ">" @bracket)
(type_arguments
  "<" @bracket
  ">" @bracket)

; Variables
;-------

(required_parameter (identifier) @identifier.argument)
(optional_parameter (identifier) @identifier.argument)
(required_parameter
  pattern: (rest_pattern
    "..." @operator
    (identifier) @identifier.argument))
