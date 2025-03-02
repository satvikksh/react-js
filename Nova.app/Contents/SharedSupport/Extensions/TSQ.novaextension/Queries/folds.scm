(list
  "[" @start
  "]" @end)

(named_node
  name: (identifier) @start
  ")" @end)

(predicate
  type: (predicate_type) @start
  ")" @end)
