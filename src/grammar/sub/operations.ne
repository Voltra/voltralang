operation -> unary_operation 												{% id %}
	| binary_operation 														{% id %}

unary_operation -> 
	"!" expr 																{% t.unaryOp("neg") %}
	| "+" expr 																{% t.unaryOp("unary_plus") %}
	| "-" expr 																{% t.unaryOp("unary_minus") %}
	| "~" expr 																{% t.unaryOp("bitwise_neg") %}
	| "!!=" fully_qualified_name 											{% t.unaryOp("unary_neg_eq") %}
	| "++" fully_qualified_name 											{% t.unaryOp("pre_increment") %}
	| fully_qualified_name "++" 											{% t.unaryOpPost("post_increment") %}
	| "--" fully_qualified_name 											{% t.unaryOp("pre_decrement") %}
	| fully_qualified_name "--" 											{% t.unaryOpPost("post_decrement") %}

binary_operation ->
	expr __ "in" __ expr 													{% t.binaryOp("in") %}
	| fully_qualified_name __ "=" __ expr 									{% t.binaryOp("assign") %}
	| expr __nl "+" __ expr 												{% t.binaryOp("plus") %}
	| expr __nl "*" __ expr 												{% t.binaryOp("times") %}
	| expr __nl "-" __ expr 												{% t.binaryOp("minus") %}
	| expr __nl "/" __ expr 												{% t.binaryOp("div") %}
	| expr __nl "%" __ expr 												{% t.binaryOp("mod") %}
	| expr __nl "==" __ expr 												{% t.binaryOp("eq") %}
	| expr __nl "!=" __ expr 												{% t.binaryOp("neq") %}
	| expr __nl "<" __ expr 												{% t.binaryOp("lt") %}
	| expr __nl ">" __ expr 												{% t.binaryOp("gt") %}
	| expr __nl "<=" __ expr 												{% t.binaryOp("leq") %}
	| expr __nl ">=" __ expr 												{% t.binaryOp("geq") %}
	| expr __nl "&&" __ expr 												{% t.binaryOp("land") %}
	| expr __nl "||" __ expr 												{% t.binaryOp("lor") %}
	| expr __nl "&" __ expr 												{% t.binaryOp("bitwise_and") %}
	| expr __nl "|" __ expr 												{% t.binaryOp("bitwise_or") %}
	| expr __nl "^" __ expr 												{% t.binaryOp("bitwise_xor") %}
	| expr __nl "??" __ expr 												{% t.binaryOp("null_coalescing") %}
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
	| expr __nl "**" __ expr 												{% t.binaryOp("pow") %}
