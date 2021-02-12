operation -> assign_expr 														{% id %}
	| precendence_operation 													{% id %}
	| spe_expr 																	{% id %}


assign_expr ->
	fully_qualified_name __nl %assign __ value_expr 							{% t.binaryOp("assign") %}
	| fully_qualified_name __nl %plus_eq __ value_expr 							{% t.binaryOp("plus_eq") %}
	| fully_qualified_name __nl %minus_eq __ value_expr 						{% t.binaryOp("minus_eq") %}
	| fully_qualified_name __nl %times_eq __ value_expr 						{% t.binaryOp("times_eq") %}
	| fully_qualified_name __nl %div_eq __ value_expr 							{% t.binaryOp("div_eq") %}
	| fully_qualified_name __nl %mod_eq __ value_expr 							{% t.binaryOp("mod_eq") %}
	| fully_qualified_name __nl %bitwise_and_eq __ value_expr 					{% t.binaryOp("bitwise_and_eq") %}
	| fully_qualified_name __nl %bitwise_or_eq __ value_expr 					{% t.binaryOp("bitwise_or_eq") %}
	| fully_qualified_name __nl %bitwise_xor_eq __ value_expr 					{% t.binaryOp("bitwise_xor_eq") %}
	| fully_qualified_name __nl %land_eq __ value_expr 							{% t.binaryOp("land_eq") %}
	| fully_qualified_name __nl %lor_eq __ value_expr 							{% t.binaryOp("lor_eq") %}
	| %unary_neg_eq fully_qualified_name 										{% t.unaryOp("unary_neg_eq") %}


precendence_operation -> zero_precedence 										{% id %}

zero_precedence ->
	one_precedence __nl %plus __ zero_precedence 								{% t.binaryOp("plus") %}
	| one_precedence __nl %minus __ zero_precedence 							{% t.binaryOp("minus") %}
	| one_precedence __nl %lor __ zero_precedence								{% t.binaryOp("lor") %}
	| one_precedence 															{% id %}


one_precedence ->
	two_precedence __nl %times __  one_precedence								{% t.binaryOp("times") %}
	| two_precedence __nl %div __ one_precedence 								{% t.binaryOp("div") %}
	| two_precedence __nl %mod __ one_precedence 								{% t.binaryOp("mod") %}
	| two_precedence __nl %land __  one_precedence								{% t.binaryOp("land") %}
	| two_precedence 															{% id %}

two_precedence ->
	three_precedence __nl %pow __ two_precedence 								{% t.binaryOp("pow") %}
	| simple_value __nl %kWin __ simple_value 									{% t.binaryOp("in") %}
	| simple_value __nl %eq __ simple_value 									{% t.binaryOp("eq") %}
	| simple_value __nl %neq __ simple_value 									{% t.binaryOp("neq") %}
	| simple_value __nl %lt __ simple_value 									{% t.binaryOp("lt") %}
	| simple_value __nl %gt __ simple_value 									{% t.binaryOp("gt") %}
	| simple_value __nl %leq __ simple_value 									{% t.binaryOp("leq") %}
	| simple_value __nl %geq __ simple_value 									{% t.binaryOp("geq") %}
	| three_precedence 															{% id %}

three_precedence ->
	four_precedence __nl %bitwise_and __ three_precedence 						{% t.binaryOp("bitwise_and") %}
	| four_precedence __nl %bitwise_or __ three_precedence 						{% t.binaryOp("bitwise_or") %}
	| four_precedence __nl %bitwise_xor __ three_precedence 					{% t.binaryOp("bitwise_xor") %}
	| four_precedence 															{% id %}

four_precedence ->
	%incr fully_qualified_name 													{% t.unaryOp("pre_increment") %}
	| %decr fully_qualified_name 												{% t.unaryOp("pre_decrement") %}
	| fully_qualified_name %incr 												{% t.unaryOpPost("post_increment") %}
	| fully_qualified_name %decr 												{% t.unaryOpPost("post_decrement") %}
	| %minus atomic_value 														{% t.unaryOp("unary_minus") %}
	| %plus atomic_value 														{% t.unaryOp("unary_plus") %}
	| %neg simple_value 														{% t.unaryOp("neg") %}
	| %bitwise_neg simple_value 												{% t.unaryOp("bitwise_neg") %}
	| simple_value 																{% id %}


spe_expr ->
	value_expr __nl %null_coal __ value_expr 									{% t.binaryOp("null_coalescing") %}
	| value_expr __nl %question __ value_expr __nl %colon __ value_expr			{% data => ({ type: "ternary", condition: t.first(data), ifTrue: t.mid(data), ifFalse: t.last(data) }) %}
