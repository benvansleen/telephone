(function_declaration
  name: (identifier) @function.name
  body: (block) @function.body) @function

(method_declaration
  receiver: (parameter_list) @method.receiver
  name: (field_identifier) @method.name
  body: (block) @method.body) @method
