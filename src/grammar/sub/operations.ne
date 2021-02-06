@include "./calls.ne" # func_call, arg_list, ufc, method_call

operation -> assign_expr 														{% id %}
	| sum_expr 																	{% id %}
	| logical_expr 																{% id %}
	| spe_expr 																	{% id %}
	| func_call																	{% id %}
	| ufc																		{% id %}
	| method_call																{% id %}


assign_expr ->
	fully_qualified_name __nl "=" __ operation 									{% t.binaryOp("assign") %}
	| fully_qualified_name __nl "+=" __ operation 								{% t.binaryOp("plus_eq") %}
	| fully_qualified_name __nl "-=" __ operation 								{% t.binaryOp("minus_eq") %}
	| fully_qualified_name __nl "*=" __ operation 								{% t.binaryOp("times_eq") %}
	| fully_qualified_name __nl "/=" __ operation 								{% t.binaryOp("div_eq") %}
	| fully_qualified_name __nl "%=" __ operation 								{% t.binaryOp("mod_eq") %}
	| fully_qualified_name __nl "&=" __ operation 								{% t.binaryOp("bitwise_and_eq") %}
	| fully_qualified_name __nl "|=" __ operation 								{% t.binaryOp("bitwise_or_eq") %}
	| fully_qualified_name __nl "^=" __ operation 								{% t.binaryOp("bitwise_xor_eq") %}
	| fully_qualified_name __nl "~=" __ operation 								{% t.binaryOp("bitwise_neg_eq") %}
	| fully_qualified_name __nl "&&=" __ operation 								{% t.binaryOp("land_eq") %}
	| fully_qualified_name __nl "||=" __ operation 								{% t.binaryOp("lor_eq") %}
	| "!!=" fully_qualified_name 												{% t.unaryOp("unary_neg_eq") %}


sum_expr ->
	sum_expr __nl "+" __ mult_expr 												{% t.binaryOp("plus") %}
	| sum_expr __nl "-" __ mult_expr 											{% t.binaryOp("minus") %}
	| mult_expr 																{% id %}

mult_expr ->
	mult_expr __nl "*" __ pow_expr 												{% t.binaryOp("times") %}
	| mult_expr __nl "/" __ pow_expr 											{% t.binaryOp("div") %}
	| mult_expr __nl "%" __ pow_expr 											{% t.binaryOp("mod") %}
	| pow_expr 																	{% id %}

pow_expr ->
	pow_expr __nl "**" __ bit_expr 												{% t.binaryOp("pow") %}
	| "-" bit_expr 																{% t.unaryOp("unary_minus") %}
	| "+" bit_expr 																{% t.unaryOp("unary_plus") %}
	| bit_expr 																	{% id %}

bit_expr ->
	bit_expr __nl "&" __ unary_expr 											{% t.binaryOp("bitwise_and") %}
	| bit_expr __nl "|" __ unary_expr 											{% t.binaryOp("bitwise_or") %}
	| bit_expr __nl "^" __ unary_expr 											{% t.binaryOp("bitwise_xor") %}
	| "~" unary_expr 															{% t.unaryOp("bitwise_neg") %}
	| unary_expr 																{% id %}

unary_expr ->
	"++" fully_qualified_name 													{% t.unaryOp("pre_increment") %}
	| "--" fully_qualified_name 												{% t.unaryOp("pre_decrement") %}
	| fully_qualified_name "++" 												{% t.unaryOpPost("post_increment") %}
	| fully_qualified_name "--" 												{% t.unaryOpPost("post_decrement") %}

logical_expr ->
	logical_expr __nl "&&" __ value_expr 										{% t.binaryOp("land") %}
	| logical_expr __nl "||" __ value_expr  									{% t.binaryOp("lor") %}								
	| logical_expr __nl "==" __ value_expr 										{% t.binaryOp("eq") %}
	| logical_expr __nl "!=" __ value_expr 										{% t.binaryOp("neq") %}
	| logical_expr __nl "<" __ value_expr 										{% t.binaryOp("lt") %}
	| logical_expr __nl ">" __ value_expr 										{% t.binaryOp("gt") %}
	| logical_expr __nl "<=" __ value_expr 										{% t.binaryOp("leq") %}
	| logical_expr __nl ">=" __ value_expr 										{% t.binaryOp("geq") %}
	| "!" logical_expr 															{% t.unaryOp("neg") %}

spe_expr ->
	value_expr __nl "in" __ value_expr 											{% t.binaryOp("in") %}
	| value_expr __nl "??" __ value_expr 										{% t.binaryOp("null_coalescing") %}
	| value_expr __nl "?" __ value_expr __nl ":" __ value_expr					{% data => ({ type: "ternary", condition: t.first(data), ifTrue: t.mid(data), ifFalse: t.last(data) }) %}
