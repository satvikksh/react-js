(formal_parameters
  [
    (identifier) @name
    (assignment_pattern
      left: (identifier) @name)
    (array_pattern
      (identifier) @name)
    (object_pattern
      [
        (pair_pattern value: (identifier) @name)
        (shorthand_property_identifier_pattern) @name
      ])
    (rest_pattern
      (identifier) @name)
  ] @subtree
)
