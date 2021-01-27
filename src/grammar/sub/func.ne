params -> "(" (_nl param_list _nl):? ")" 								{% t.mid %}
		| ident															{% t.id %}

lambda -> params expression_body										{% data => ({ type: "lambda", params: t.first(data), body: t.last(data) }) %}

anonymous_func -> function_prefix params expr_block						{% data => ({ type: "anonymous_func", params: t.mid(data), body: t.last(data) }) %}

computed_property -> ident computed_body 								{% data => ({ type: "computed_property", property: t.first(data), body: t.last(data) }) %}

param_list -> null 														{% () => ({ type: "param_list", params: [] }) %}
		| ident (_ "," _ ident):+ (_ "," _):?							{% data => ({ type: "param_list", params: [t.first(data), ...t.second(data).map(t.last)] }) %}