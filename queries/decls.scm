[
  (function_declaration name: (identifier) @fn.name) @fn.decl
  (method_declaration
    receiver: (parameter_list
      (parameter_declaration
        type: (_) @method.receiver))
    name: (field_identifier) @method.name) @method.decl
]
