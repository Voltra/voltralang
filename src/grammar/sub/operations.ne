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
	sum_expr __nl %plus __ sum_expr 											{% t.binaryOp("plus") %}
	| sum_expr __nl %minus __ sum_expr 										{% t.binaryOp("minus") %}
	| mult_expr 																{% id %}

mult_expr ->
	mult_expr __nl %times __ mult_expr 											{% t.binaryOp("times") %}
	| mult_expr __nl %div __ mult_expr 											{% t.binaryOp("div") %}
	| mult_expr __nl %mod __ mult_expr 											{% t.binaryOp("mod") %}
	| pow_expr 																	{% id %}

pow_expr ->
	pow_expr __nl %pow __ bit_expr 												{% t.binaryOp("pow") %}
	| %minus value_expr 														{% t.unaryOp("unary_minus") %}
	| %plus value_expr 															{% t.unaryOp("unary_plus") %}
	| bit_expr 																	{% id %}

bit_expr ->
	bit_expr __nl %bitwise_and __ bit_expr 									{% t.binaryOp("bitwise_and") %}
	| bit_expr __nl %bitwise_or __ bit_expr 									{% t.binaryOp("bitwise_or") %}
	| bit_expr __nl %bitwise_xor __ bit_expr 									{% t.binaryOp("bitwise_xor") %}
	| %bitwise_neg value_expr 													{% t.unaryOp("bitwise_neg") %}
	| unary_expr 																{% id %}

unary_expr ->
	%incr fully_qualified_name 													{% t.unaryOp("pre_increment") %}
	| %decr fully_qualified_name 												{% t.unaryOp("pre_decrement") %}
	| fully_qualified_name %incr 												{% t.unaryOpPost("post_increment") %}
	| fully_qualified_name %decr 												{% t.unaryOpPost("post_decrement") %}
	| simple_value 																{% id %}


logical_expr -> disjonction 													{% id %}


disjonction -> conjonction __nl %lor __ conjonction								{% t.binaryOp("lor") %}
	| conjonction 																{% id %}

conjonction -> logical_unary __nl %land __ logical_unary 						{% t.binaryOp("land") %}
	| logical_unary

logical_unary -> %neg value_expr 												{% t.unaryOp("neg") %} 
	| value_expr __nl %kWin __ value_expr 										{% t.binaryOp("in") %}							
	| logical_unary __nl %eq __ logical_unary 									{% t.binaryOp("eq") %}
	| logical_unary __nl %neq __ logical_unary 									{% t.binaryOp("neq") %}
	| logical_unary __nl %lt __ logical_unary 									{% t.binaryOp("lt") %}
	| logical_unary __nl %gt __ logical_unary 									{% t.binaryOp("gt") %}
	| logical_unary __nl %leq __ logical_unary 									{% t.binaryOp("leq") %}
	| logical_unary __nl %geq __ logical_unary 									{% t.binaryOp("geq") %}
	| simple_value 																{% id %}



spe_expr ->
	value_expr __nl %null_coal __ value_expr 									{% t.binaryOp("null_coalescing") %}
	| value_expr __nl %question __ value_expr __nl %colon __ value_expr			{% data => ({ type: "ternary", condition: t.first(data), ifTrue: t.mid(data), ifFalse: t.last(data) }) %}
