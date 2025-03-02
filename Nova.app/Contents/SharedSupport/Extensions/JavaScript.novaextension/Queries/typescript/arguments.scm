(formal_parameters
  [
    (required_parameter
      pattern: (identifier) @name
      type: (type_annotation
        [
          (generic_type)
          (parenthesized_type)
          (predefined_type)
          (object_type)
          (array_type)
          (tuple_type)
          (flow_maybe_type)
          (type_query)
          (index_type_query)
          (this_type)
          (existential_type)
          (literal_type)
          (lookup_type)
          (conditional_type)
          (template_literal_type)
          (intersection_type)
          (union_type)
        ]? @type))
    (optional_parameter
      pattern: (identifier) @name
      type: (type_annotation
        [
          (generic_type)
          (parenthesized_type)
          (predefined_type)
          (object_type)
          (array_type)
          (tuple_type)
          (flow_maybe_type)
          (type_query)
          (index_type_query)
          (this_type)
          (existential_type)
          (literal_type)
          (lookup_type)
          (conditional_type)
          (template_literal_type)
          (intersection_type)
          (union_type)
        ]? @type))
  ] @subtree
)
