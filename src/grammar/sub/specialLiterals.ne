arrayLiteral -> "[" _ arg_list _ "]" 										{% data => ({ type: "arrayLiteral", items: t.mid(data) }) %}

objectLiteral -> "{" _ "}" 													{% data => ({ type: "objectLiteral", entries: t.mid(data) }) %}
# TODO: Actual object literal