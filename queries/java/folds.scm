[
  (block)
  (class_body)
  (constructor_declaration)
  (argument_list)
  (annotation_argument_list)
  (import_declaration)+
] @fold

[
  ((class_declaration) @fold)
  ((method_declaration) @fold)
  ((if_statement) @fold)
  ((for_statement) @fold)
  ((while_statement) @fold)
]

[
  ((line_comment) @fold)
  ((block_comment) @fold)
]
