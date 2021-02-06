func_call -> value_expr func_args									{% data => ({ type: "func_call", func: t.first(data), args: t.last(data), }) %}

func_args -> "(" _ arg_list _ ")"									{% t.mid %}

arg_list -> null 													{% () => ({ type: "arg_list", args: [] }) %}
	| value_expr (_ "," __nl value_expr):* (_ "," __nl):?			{% data => ({ type: "arg_list", args: [t.first(data), ...t.second(data).map(t.last)] }) %}

ufc -> value_expr "@" func_call										{% data => ({ type: "ufc", caller: t.first(data), call: t.last(data) }) %}

method_call -> value_expr "." ident func_args						{% data => ({ type: "method_call", object: t.first(data), method: t.beforeLast(data), args: t.last(data) }) %}
	| value_expr "[" _nl value_expr _nl "]" func_args				{% data => ({ type: "method_call", object: t.first(data), method: data[3], args: t.last(data) }) %}