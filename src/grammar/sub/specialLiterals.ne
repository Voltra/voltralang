arrayLiteral -> "[" _nl arg_list _nl "]" 										{% data => ({ type: "arrayLiteral", items: t.mid(data) }) %}

objectLiteral -> "{" __nl "}" 													{% data => ({ type: "objectLiteral", entries: t.mid(data) }) %}
# TODO: Actual object literal

nullLiteral -> "null"															{% id %}