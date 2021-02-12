func_call -> simple_value func_args											{% data => ({ type: "func_call", func: t.first(data), args: t.last(data) }) %}

func_args -> %lparen _ arg_list _ %rparen									{% t.mid %}

arg_list -> null 															{% () => ({ type: "arg_list", args: [] }) %}
	| value_expr (_ %comma __nl value_expr):* (_ %comma __nl):?				{% data => ({ type: "arg_list", args: [t.first(data), ...t.second(data).map(t.last)] }) %}

ufc -> simple_value %ufc func_call											{% data => ({ type: "ufc", caller: t.first(data), call: t.last(data) }) %}

method_call -> simple_value %dot ident func_args							{% data => ({ type: "method_call", object: t.first(data), method: t.beforeLast(data), args: t.last(data) }) %}
	| simple_value %lbracket _nl value_expr _nl %rbracket func_args			{% data => ({ type: "method_call", object: t.first(data), method: data[3], args: t.last(data) }) %}