arrayLiteral -> %lbracket _nl arg_list _nl %rbracket 										{% data => ({ type: "arrayLiteral", items: t.mid(data) }) %}

objectLiteral -> %lcurly __nl %rcurly 													{% data => ({ type: "objectLiteral", entries: t.mid(data) }) %}
# TODO: Actual object literal

nullLiteral -> %kWnull															{% id %}