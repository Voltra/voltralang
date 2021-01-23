func_call -> expr func_args								{% data => ({ type: "func_call", func: t.first(data), args: t.last(data), }) %}

func_args -> "(" _ arg_list _ ")"						{% t.mid %}

arg_list -> expr (
		_ "," _ expr 									{% t.last %}
	):* ",":?											{% data => ({ type: "arg_list", args: [t.first(data), ...t.second(data)] }) %}

ufc -> expr "@" func_call								{% data => ({ type: "ufc", caller: t.first(data), call: t.last(data) }) %}

method_call -> expr "." ident func_args					{% data => ({ type: "method_call", object: t.first(data), method: t.beforeLast(data), args: t.last(data) }) %}
	| expr "[" _ expr _ "]" func_args					{% data => ({ type: "method_call", object: t.first(data), method: data[3], args: t.last(data) }) %}