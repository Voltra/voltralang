array_destructuring -> "[" _ destructuring_list _ "]" 		{% data => ({ type: "array_destructuring", structure: t.mid(data) }) %}
object_destructuring -> "{" _ destructuring_list _ "}" 		{% data => ({ type: "object_destructuring", structure: t.mid(data) }) %}

destructuring_list -> ident
	(_ "," _ ident _):* 									{% t.beforeLast %}
	("," _)? 												{% data => ({ type: "destructuring_list", items: [t.first(data), ...t.mid(data)] }) %}


# TODO: Nested destructuring