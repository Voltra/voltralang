unary_operation -> 
	"!" expr 															{% t.unaryOp("neg") %}
	| "+" expr 															{% t.unaryOp("unary_plus") %}
	| "-" expr 															{% t.unaryOp("unary_minus") %}
	| "~" expr 															{% t.unaryOp("bitwise_neg") %}
	| "!!=" expr 														{% t.unaryOp("unary_neg_eq") %}

binary_operation ->
	ident _ "in" _ expr 												{% t.binaryOp("in") %}
	| ident _ "=" _ expr 												{% t.binaryOp("assign") %}
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
	| expr _ "+=" _ expr 												{% t.binaryOp("plus_eq") %}
	| expr _ "-=" _ expr 												{% t.binaryOp("minus_eq") %}
	| expr _ "*=" _ expr 												{% t.binaryOp("times_eq") %}
	| expr _ "/=" _ expr 												{% t.binaryOp("div_eq") %}
	| expr _ "%=" _ expr 												{% t.binaryOp("mod_eq") %}
	| expr _ "&=" _ expr 												{% t.binaryOp("bitwise_and_eq") %}
	| expr _ "|=" _ expr 												{% t.binaryOp("bitwise_or_eq") %}
	| expr _ "^=" _ expr 												{% t.binaryOp("bitwise_xor_eq") %}
	| expr _ "~=" _ expr 												{% t.binaryOp("bitwise_neg_eq") %}
	| expr _ "&&=" _ expr 												{% t.binaryOp("land_eq") %}
	| expr _ "||=" _ expr 												{% t.binaryOp("lor_eq") %}

operation -> unary_operation {% id %} | binary_operation {% id %}