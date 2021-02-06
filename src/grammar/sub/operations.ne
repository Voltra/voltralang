operation -> assign_expr 													{% id %}
	| pow_expr 																{% id %}
	| logical_expr 															{% id %}
	| spe_expr 																{% id %}


assign_expr ->
	fully_qualified_name __nl "=" __ expr 									{% t.binaryOp("assign") %}
	| fully_qualified_name __nl "+=" __ expr 								{% t.binaryOp("plus_eq") %}
	| fully_qualified_name __nl "-=" __ expr 								{% t.binaryOp("minus_eq") %}
	| fully_qualified_name __nl "*=" __ expr 								{% t.binaryOp("times_eq") %}
	| fully_qualified_name __nl "/=" __ expr 								{% t.binaryOp("div_eq") %}
	| fully_qualified_name __nl "%=" __ expr 								{% t.binaryOp("mod_eq") %}
	| fully_qualified_name __nl "&=" __ expr 								{% t.binaryOp("bitwise_and_eq") %}
	| fully_qualified_name __nl "|=" __ expr 								{% t.binaryOp("bitwise_or_eq") %}
	| fully_qualified_name __nl "^=" __ expr 								{% t.binaryOp("bitwise_xor_eq") %}
	| fully_qualified_name __nl "~=" __ expr 								{% t.binaryOp("bitwise_neg_eq") %}
	| fully_qualified_name __nl "&&=" __ expr 								{% t.binaryOp("land_eq") %}
	| fully_qualified_name __nl "||=" __ expr 								{% t.binaryOp("lor_eq") %}
	| "!!=" fully_qualified_name 											{% t.unaryOp("unary_neg_eq") %}

pow_expr ->
	pow_expr __nl "**" __ mult_expr 										{% t.binaryOp("pow") %}
	| "-" mult_expr 														{% t.unaryOp("unary_minus") %}
	| "+" mult_expr 														{% t.unaryOp("unary_plus") %}
	| mult_expr

mult_expr ->
	mult_expr __nl "*" __ sum_expr 											{% t.binaryOp("times") %}
	| mult_expr __nl "/" __ sum_expr 										{% t.binaryOp("div") %}
	| mult_expr __nl "%" __ sum_expr 										{% t.binaryOp("mod") %}
	| sum_expr

sum_expr ->
	sum_expr __nl "+" __ bit_expr 											{% t.binaryOp("plus") %}
	| sum_expr __nl "-" __ bit_expr 										{% t.binaryOp("minus") %}
	| bit_expr

bit_expr ->
	bit_expr __nl "&" __ unary_expr 										{% t.binaryOp("bitwise_and") %}
	| bit_expr __nl "|" __ unary_expr 										{% t.binaryOp("bitwise_or") %}
	| bit_expr __nl "^" __ unary_expr 										{% t.binaryOp("bitwise_xor") %}
	| "~" bit_expr 															{% t.unaryOp("bitwise_neg") %}
	| unary_expr

unary_expr ->
	"++" fully_qualified_name 												{% t.unaryOp("pre_increment") %}
	| "--" fully_qualified_name 											{% t.unaryOp("pre_decrement") %}
	| fully_qualified_name "++" 											{% t.unaryOpPost("post_increment") %}
	| fully_qualified_name "--" 											{% t.unaryOpPost("post_decrement") %}
	| expr 																	{% id %}

logical_expr ->
	logical_expr __nl "&&" __ expr 											{% t.binaryOp("land") %}
	| logical_expr __nl "||" __ expr  										{% t.binaryOp("lor") %}								
	| logical_expr __nl "==" __ expr 										{% t.binaryOp("eq") %}
	| logical_expr __nl "!=" __ expr 										{% t.binaryOp("neq") %}
	| logical_expr __nl "<" __ expr 										{% t.binaryOp("lt") %}
	| logical_expr __nl ">" __ expr 										{% t.binaryOp("gt") %}
	| logical_expr __nl "<=" __ expr 										{% t.binaryOp("leq") %}
	| logical_expr __nl ">=" __ expr 										{% t.binaryOp("geq") %}
	| "!" logical_expr 														{% t.unaryOp("neg") %}
	| expr																	{% id %}

spe_expr ->
	expr __nl "in" __ expr 													{% t.binaryOp("in") %}
	| expr __nl "??" __ expr 												{% t.binaryOp("null_coalescing") %}