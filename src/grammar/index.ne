@{%
	const { lexer } = require("../lexer");
	const t = require("./transform");
%}

@lexer lexer



####################################################################################
# Sub parts
####################################################################################
@include "./sub/operations.ne" # operation, unary_operation, binary_operation
@include "./sub/operators.ne" # operator
@include "./sub/calls.ne" # func_call, arg_list, ufc, method_call
@include "./sub/func.ne" # params, lambda, anonymous_func, computed_property, param_list
@include "./sub/controlFlow.ne" # throw_stmt, if_stmt, while_stmt, do_while_stmt
@include "./sub/specialLiterals.ne" # arrayLiteral, objectLiteral
@include "./sub/destructuring.ne" # array_destructuring, object_destructuring
@include "./sub/patternMatching.ne" # match_expr



####################################################################################
# Atom
####################################################################################
program -> _nl:? (expr _nl):*												{% t.mapSecond(t.first) %}



####################################################################################
# Whitespaces
####################################################################################
_ -> %WS:*
__ -> %WS:+

_nl -> (%WS|%NL):*
__nl -> (%WS|%NL):+



####################################################################################
# Simple
####################################################################################
ident -> %ident																{% id %}
numberLiteral -> %numberLiteral												{% id %}
stringLiteral -> %stringLiteral 											{% id %}
booleanLiteral -> ("true"|"false") 											{% id %}
function_prefix -> ("fn"|"function") 										{% id %}




####################################################################################
# Simple composite
####################################################################################
functionLiteral -> anonymous_func | lambda									{% id %}

literal -> numberLiteral													{% id %}
	| booleanLiteral
	| stringLiteral															{% id %}
	| functionLiteral														{% id %}
	| arrayLiteral 															{% id %}
	| objectLiteral 														{% id %}

operator_name -> "operator\"" operator "\""									{% data => ({ type: "operator_name", operator: t.mid(data) }) %}

fully_qualified_name -> ident 												{% id %}
	# | (ident "::"):+ ident													{% data => ({ type: "fqn", path: [...t.first(data).map(id), t.last(data)] }) %}
	| (ident "::"):+ (ident | operator_name) 								{% data => ({ type: "fqn", path: [...t.first(data).map(id), t.last(data)] }) %}
	#TODO: check if there's a need to discern operator



####################################################################################
# Composite
####################################################################################
expr -> literal																{% id %}
	| fully_qualified_name													{% id %}
	| expr_block															{% id %}
	| paren_expr															{% id %}
	| operation																{% id %}
	| ternary																{% id %}
	| func_call																{% id %}
	| ufc																	{% id %}
	| method_call															{% id %}
	| match_expr															{% id %}
	| statement 															{% id %}

statement -> throw_stmt														{% id %}
	| if_stmt																{% id %}
	| while_stmt															{% id %}
	| do_while_stmt															{% id %}


paren_expr -> "(" _nl expr _nl ")"											{% data => ({ type: "paren_expr", expr: t.mid(data) }) %}
expr_block -> "{" _nl expr:* _nl "}"										{% data => ({ type: "expr_block", exprs: t.mid(data) }) %}
expression_body -> __ "=>" _nl expr											{% data => ({ type: "expression_body", body: t.last(data) }) %}
computed_body -> __ "~>" _nl expr											{% data => ({ type: "computed_body", body: t.last(data) }) %}

ternary -> expr _nl "?" _ expr _nl ":" _ expr								{% data => ({ type: "ternary", condition: t.first(data), ifTrue: t.mid(data), ifFalse: t.last(data) }) %}

