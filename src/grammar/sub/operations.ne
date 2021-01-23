unary_operation -> 
	"!" expr 															{% t.unaryOp("neg") %}
	| "+" expr 															{% t.unaryOp("unary_plus") %}
	| "-" expr 															{% t.unaryOp("unary_minus") %}
	| "~" expr 															{% t.unaryOp("bitwise_neg") %}
	| "!!=" fully_qualified_name 										{% t.unaryOp("unary_neg_eq") %}
	| "++" fully_qualified_name 										{% t.unaryOp("pre_increment") %}
	| fully_qualified_name "++" 										{% t.unaryOp("post_increment") %}
	| "--" fully_qualified_name 										{% t.unaryOp("pre_decrement") %}
	| fully_qualified_name "--" 										{% t.unaryOp("post_decrement") %}

binary_operation ->
	expr _ "in" _ expr 													{% t.binaryOp("in") %}
	| fully_qualified_name _ "=" _ expr 								{% t.binaryOp("assign") %}
	| expr _ "+" _ expr 												{% t.binaryOp("plus") %}
	| expr _ "*" _ expr 												{% t.binaryOp("times") %}
	| expr _ "-" _ expr 												{% t.binaryOp("minus") %}
	| expr _ "/" _ expr 												{% t.binaryOp("div") %}
	| expr _ "%" _ expr 												{% t.binaryOp("mod") %}
	| expr _ "==" _ expr 												{% t.binaryOp("eq") %}
	| expr _ "!=" _ expr 												{% t.binaryOp("neq") %}
	| expr _ "<" _ expr 												{% t.binaryOp("lt") %}
	| expr _ ">" _ expr 												{% t.binaryOp("gt") %}
	| expr _ "<=" _ expr 												{% t.binaryOp("leq") %}
	| expr _ ">=" _ expr 												{% t.binaryOp("geq") %}
	| expr _ "&&" _ expr 												{% t.binaryOp("land") %}
	| expr _ "||" _ expr 												{% t.binaryOp("lor") %}
	| expr _ "&" _ expr 												{% t.binaryOp("bitwise_and") %}
	| expr _ "|" _ expr 												{% t.binaryOp("bitwise_or") %}
	| expr _ "^" _ expr 												{% t.binaryOp("bitwise_xor") %}
	| expr _ "??" _ expr 												{% t.binaryOp("null_coalescing") %}
	| fully_qualified_name _ "+=" _ expr 								{% t.binaryOp("plus_eq") %}
	| fully_qualified_name _ "-=" _ expr 								{% t.binaryOp("minus_eq") %}
	| fully_qualified_name _ "*=" _ expr 								{% t.binaryOp("times_eq") %}
	| fully_qualified_name _ "/=" _ expr 								{% t.binaryOp("div_eq") %}
	| fully_qualified_name _ "%=" _ expr 								{% t.binaryOp("mod_eq") %}
	| fully_qualified_name _ "&=" _ expr 								{% t.binaryOp("bitwise_and_eq") %}
	| fully_qualified_name _ "|=" _ expr 								{% t.binaryOp("bitwise_or_eq") %}
	| fully_qualified_name _ "^=" _ expr 								{% t.binaryOp("bitwise_xor_eq") %}
	| fully_qualified_name _ "~=" _ expr 								{% t.binaryOp("bitwise_neg_eq") %}
	| fully_qualified_name _ "&&=" _ expr 								{% t.binaryOp("land_eq") %}
	| fully_qualified_name _ "||=" _ expr 								{% t.binaryOp("lor_eq") %}
	| expr _ "**" _ expr 												{% t.binaryOp("pow") %}

operation -> unary_operation {% id %} | binary_operation {% id %}