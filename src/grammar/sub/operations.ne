operation -> assign_expr 														{% id %}
	| sum_expr 																	{% id %}
	| logical_expr 																{% id %}
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


sum_expr ->
	mult_expr __nl %plus __ sum_expr 											{% t.binaryOp("plus") %}
	| mult_expr __nl %minus __ sum_expr 										{% t.binaryOp("minus") %}
	| mult_expr 																{% id %}

mult_expr ->
	pow_expr __nl %times __  mult_expr											{% t.binaryOp("times") %}
	| pow_expr __nl %div __ mult_expr 											{% t.binaryOp("div") %}
	| pow_expr __nl %mod __ mult_expr 											{% t.binaryOp("mod") %}
	| pow_expr 																	{% id %}

pow_expr ->
	bit_expr __nl %pow __ pow_expr 												{% t.binaryOp("pow") %}
	| %minus atomic_value 														{% t.unaryOp("unary_minus") %}
	| %plus atomic_value 														{% t.unaryOp("unary_plus") %}
	| bit_expr 																	{% id %}

bit_expr ->
	unary_expr __nl %bitwise_and __ bit_expr 									{% t.binaryOp("bitwise_and") %}
	| unary_expr __nl %bitwise_or __ bit_expr 									{% t.binaryOp("bitwise_or") %}
	| unary_expr __nl %bitwise_xor __ bit_expr 									{% t.binaryOp("bitwise_xor") %}
	| %bitwise_neg simple_value 												{% t.unaryOp("bitwise_neg") %}
	| unary_expr 																{% id %}

unary_expr ->
	%incr fully_qualified_name 													{% t.unaryOp("pre_increment") %}
	| %decr fully_qualified_name 												{% t.unaryOp("pre_decrement") %}
	| fully_qualified_name %incr 												{% t.unaryOpPost("post_increment") %}
	| fully_qualified_name %decr 												{% t.unaryOpPost("post_decrement") %}
	# | simple_value 																{% id %}
	| simple_value 																{% data => ({ type: "sv_unary_expr", data: id(data) }) %}


logical_expr -> disjonction 													{% id %}

disjonction -> conjonction __nl %lor __ disjonction								{% t.binaryOp("lor") %}
	| conjonction 																{% id %}

conjonction -> logical_unary __nl %land __  conjonction							{% t.binaryOp("land") %}
	| logical_unary 															{% id %}

logical_unary -> %neg simple_value 												{% t.unaryOp("neg") %}
	| simple_value __nl %kWin __ simple_value 									{% t.binaryOp("in") %}
	| simple_value __nl %eq __ simple_value 									{% t.binaryOp("eq") %}
	| simple_value __nl %neq __ simple_value 									{% t.binaryOp("neq") %}
	| simple_value __nl %lt __ simple_value 									{% t.binaryOp("lt") %}
	| simple_value __nl %gt __ simple_value 									{% t.binaryOp("gt") %}
	| simple_value __nl %leq __ simple_value 									{% t.binaryOp("leq") %}
	| simple_value __nl %geq __ simple_value 									{% t.binaryOp("geq") %}
	# | simple_value 																{% id %}
	| simple_value 																{% data => ({ type: "sv_logical_unary", data: id(data) }) %}


spe_expr ->
	value_expr __nl %null_coal __ value_expr 									{% t.binaryOp("null_coalescing") %}
	| value_expr __nl %question __ value_expr __nl %colon __ value_expr			{% data => ({ type: "ternary", condition: t.first(data), ifTrue: t.mid(data), ifFalse: t.last(data) }) %}
