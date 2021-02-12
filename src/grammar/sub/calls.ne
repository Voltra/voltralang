callable -> fully_qualified_name 											{% id %}
	| func_call																{% id %}
	| ufc																	{% id %}
	| method_call															{% id %}

func_call -> callable func_args												{% data => ({ type: "func_call", func: t.first(data), args: t.last(data) }) %}

func_args -> %lparen _nl arg_list _nl %rparen								{% t.mid %}

arg_list -> null 															{% () => ({ type: "arg_list", args: [] }) %}
	| value_expr (_ %comma __nl value_expr):* (_ %comma __nl):?				{% data => ({ type: "arg_list", args: [t.first(data), ...t.second(data).map(t.last)] }) %}

ufc -> callable %ufc func_call												{% data => ({ type: "ufc", caller: t.first(data), call: t.last(data) }) %}

method_call -> callable %dot ident func_args								{% data => ({ type: "method_call", object: t.first(data), method: t.beforeLast(data), args: t.last(data) }) %}
	| callable %lbracket _nl value_expr _nl %rbracket func_args				{% data => ({ type: "method_call", object: t.first(data), method: data[3], args: t.last(data) }) %}