@{%
	// const { lexer } = require("../lexer");
	const t = require("./transform");

	const nm = require("nearley-moo");
	const { tokens } = require("../lexer/tokens");

	nm(tokens);

	/*const keys = Array.from(Reflect.ownKeys(global))
					.filter(x => typeof x === "string");

	console.log(keys);*/
%}

# @lexer lexer


####################################################################################
# Sub parts
####################################################################################
@include "./sub/calls.ne" # func_call, arg_list, ufc, method_call
@include "./sub/operations.ne" # operation
@include "./sub/operators.ne" # operator, operator_name
@include "./sub/func.ne" # params, lambda, anonymous_func, computed_property, param_list
@include "./sub/controlFlow.ne" # throw_stmt, if_stmt, while_stmt, do_while_stmt
@include "./sub/specialLiterals.ne" # arrayLiteral, objectLiteral, nullLiteral
@include "./sub/destructuring.ne" # array_destructuring, object_destructuring
@include "./sub/patternMatching.ne" # match_expr



####################################################################################
# Atom
####################################################################################
file -> (_nl expr):+ _nl													{% t.mapFirst(t.last) %}



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
booleanLiteral -> (%kWtrue|%kWfalse) 										{% id %}
function_prefix -> (%kWfn|%kWfunction) 										{% id %}




####################################################################################
# Simple composite
####################################################################################
functionLiteral -> anonymous_func | lambda									{% id %}

literal -> numberLiteral													{% id %}
	| booleanLiteral														{% id %}
	| stringLiteral															{% id %}
	| nullLiteral															{% id %}
	| functionLiteral														{% id %}
	| arrayLiteral 															{% id %}
	| objectLiteral 														{% id %}



fully_qualified_name -> (ident %ns):*
	(ident {% id %} | operator_name {% id %}) 								{% data => ({ type: "fqn", path: [...t.mapFirst(t.first)(data), t.last(data)] }) %}



####################################################################################
# Composite
####################################################################################
expr -> value_expr (_ %semi):? 												{% id %}
	| no_value_expr (_ %semi):? 											{% id %}

value_expr -> operation														{% id %}
	# | simple_value															{% id %}
	| expr_statement														{% id %}

simple_value -> atomic_value 												{% id %}
	| paren_expr															{% id %}

atomic_value -> literal 													{% id %}
	| fully_qualified_name													{% id %}
	| func_call																{% id %}
	| ufc																	{% id %}
	| method_call															{% id %}



no_value_expr -> expr_block													{% id %}
	| statement 															{% id %}


expr_statement -> throw_stmt												{% id %}
	| return_stmt 															{% id %}

statement -> if_stmt														{% id %}
	| while_stmt															{% id %}
	| do_while_stmt															{% id %}


paren_expr -> %lparen _nl value_expr _nl %rparen							{% data => ({ type: "paren_expr", expr: t.mid(data) }) %}
expr_block -> %lcurly _nl (expr __nl):* %rcurly								{% data => ({ type: "expr_block", exprs: t.beforeLast(data).map(t.first) }) %}
mini_func_body -> value_expr 												{% id %}
	| expr_block 															{% id %}

expression_body -> __ %fat_arrow __nl mini_func_body						{% data => ({ type: "expression_body", body: t.last(data) }) %}
computed_body -> __ %wavy_arrow __nl mini_func_body							{% data => ({ type: "computed_body", body: t.last(data) }) %}

