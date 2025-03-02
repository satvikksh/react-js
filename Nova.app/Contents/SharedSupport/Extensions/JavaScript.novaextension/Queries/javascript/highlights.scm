; Class definitions
;--------------------------------

(class_declaration
  name: (identifier) @identifier.type.class.declare)

; Properties
;-----------

(field_definition
  property: (property_identifier) @identifier.property)
(field_definition
  property: (private_property_identifier) @identifier.property)
  
; Parameters
;-----------

(formal_parameters
  [
    (identifier) @identifier.argument
    (assignment_pattern
      left: (identifier) @identifier.argument)
    (array_pattern
      (identifier) @identifier.argument)
    (object_pattern
      [
        (pair_pattern value: (identifier) @identifier.argument)
        (shorthand_property_identifier_pattern) @identifier.argument
      ])
    (rest_pattern
      "..." @operator
      (identifier) @identifier.argument)
  ]
)
