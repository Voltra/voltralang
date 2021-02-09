destructuring -> array_destructuring 							{% id %}
	| object_destructuring 										{% id %}

array_destructuring -> %lbracket _ destructuring_list _ %rbracket 			{% data => ({ type: "array_destructuring", structure: t.mid(data) }) %}
object_destructuring -> %lcurly _ destructuring_list _ %rcurly 			{% data => ({ type: "object_destructuring", structure: t.mid(data) }) %}

destructuring_list -> ident (_ %comma __ ident):* (_ %comma __):? 	{% data => ({ type: "destructuring_list", items: [t.first(data), ...t.mid(data).map(t.beforeLast)] }) %}


# TODO: Nested destructuring