@{%
	const { lexer } = require("../lexer");
%}

@lexer lexer
@builtin "whitespace.ne" # `_` means arbitrary amount of whitespace
@builtin "number.ne" # `int`, `decimal`, and `percentage` number primitives

ident -> %ident		{% id %}
