@include "./calls.ne" # func_call, arg_list, ufc, method_call

operation -> assign_expr 														{% id %}
	| sum_expr 																	{% id %}
	| logical_expr 																{% id %}
	| spe_expr 																	{% id %}
	| func_call																	{% id %}
	| ufc																		{% id %}
	| method_call																{% id %}


assign_expr ->
	fully_qualified_name __nl %assign __ operation 								{% t.binaryOp("assign") %}
	| fully_qualified_name __nl %plus_eq __ operation 							{% t.binaryOp("plus_eq") %}
	| fully_qualified_name __nl %minus_eq __ operation 							{% t.binaryOp("minus_eq") %}
	| fully_qualified_name __nl %times_eq __ operation 							{% t.binaryOp("times_eq") %}
	| fully_qualified_name __nl %div_eq __ operation 							{% t.binaryOp("div_eq") %}
	| fully_qualified_name __nl %mod_eq __ operation 							{% t.binaryOp("mod_eq") %}
	| fully_qualified_name __nl %bitwise_and_eq __ operation 					{% t.binaryOp("bitwise_and_eq") %}
	| fully_qualified_name __nl %bitwise_or_eq __ operation 					{% t.binaryOp("bitwise_or_eq") %}
	| fully_qualified_name __nl %bitwise_xor_eq __ operation 					{% t.binaryOp("bitwise_xor_eq") %}
	| fully_qualified_name __nl %land_eq __ operation 							{% t.binaryOp("land_eq") %}
	| fully_qualified_name __nl %lor_eq __ operation 							{% t.binaryOp("lor_eq") %}
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
	| %minus simple_value 														{% t.unaryOp("unary_minus") %}
	| %plus simple_value 														{% t.unaryOp("unary_plus") %}
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
	| simple_value 																{% id %}
	# | simple_value 																{% data => ({ type: "sv_unary_expr", data: id(data) }) %}


logical_expr -> disjonction 													{% id %}


disjonction -> conjonction __nl %lor __ disjonction								{% t.binaryOp("lor") %}
	| conjonction 																{% id %}

conjonction -> logical_unary __nl %land __  conjonction							{% t.binaryOp("land") %}
	| logical_unary 															{% id %}

logical_unary -> %neg value_expr 												{% t.unaryOp("neg") %}
	| value_expr __nl %kWin __ value_expr 										{% t.binaryOp("in") %}
	| value_expr __nl %eq __ value_expr 										{% t.binaryOp("eq") %}
	| value_expr __nl %neq __ value_expr 										{% t.binaryOp("neq") %}
	| value_expr __nl %lt __ value_expr 										{% t.binaryOp("lt") %}
	| value_expr __nl %gt __ value_expr 										{% t.binaryOp("gt") %}
	| value_expr __nl %leq __ value_expr 										{% t.binaryOp("leq") %}
	| value_expr __nl %geq __ value_expr 										{% t.binaryOp("geq") %}
	# | value_expr 																{% id %}
	# | simple_value 																{% data => ({ type: "sv_logical_unary", data: id(data) }) %}



spe_expr ->
	value_expr __nl %null_coal __ value_expr 									{% t.binaryOp("null_coalescing") %}
	| value_expr __nl %question __ value_expr __nl %colon __ value_expr			{% data => ({ type: "ternary", condition: t.first(data), ifTrue: t.mid(data), ifFalse: t.last(data) }) %}
