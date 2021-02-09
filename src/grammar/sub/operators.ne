operator_name -> %kWoperator "\"" operator "\""				{% data => ({ type: "operator_name", operator: t.beforeLast(data) }) %}

# Overloadable operator
operator -> %lt												{% id %}
			| %gt 											{% id %}
			| %leq 											{% id %}
			| %geq 											{% id %}
			| %lor 											{% id %}
			| %bitwise_or											{% id %}
			| %land 											{% id %}
			| %bitwise_and 											{% id %}
			| %neg 											{% id %}
			| %bitwise_neg 											{% id %}
			| %bitwise_xor 											{% id %}
			| %plus 											{% id %}
			| %minus 											{% id %}
			| %times 											{% id %}
			| %div 											{% id %}
			| %mod 											{% id %}
			| %eq 											{% id %}
			| %neq 											{% id %}
			| %assign 											{% id %}
			| %null_coal 											{% id %}
			| %plus_eq 											{% id %}
			| %minus_eq 											{% id %}
			| %times_eq 											{% id %}
			| %div_eq 											{% id %}
			| %mod_eq 											{% id %}
			| %bitwise_and_eq 											{% id %}
			| %bitwise_or_eq 											{% id %}
			| %bitwise_xor_eq 											{% id %}
			# | "~=" 											{% id %}
			| %land_eq 										{% id %}
			| %lor_eq 										{% id %}
			| %unary_neg_eq 										{% id %}
			| %incr 											{% id %}
			| %decr 											{% id %}
			| %pow 											{% id %}
			| %kWin 											{% id %}
			| %lparen %rparen 											{% id %}
			| %lbracket %rbracket 											{% id %}
