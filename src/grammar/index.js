// Generated automatically by nearley, version 2.20.1
// http://github.com/Hardmath123/nearley
(function () {
function id(x) { return x[0]; }

	const { lexer } = require("../lexer");
	const t = require("./transform");
var grammar = {
    Lexer: lexer,
    ParserRules: [
    {"name": "operation", "symbols": ["assign_expr"], "postprocess": id},
    {"name": "operation", "symbols": ["pow_expr"], "postprocess": id},
    {"name": "operation", "symbols": ["logical_expr"], "postprocess": id},
    {"name": "operation", "symbols": ["spe_expr"], "postprocess": id},
    {"name": "assign_expr", "symbols": ["fully_qualified_name", "__nl", {"literal":"="}, "__", "expr"], "postprocess": t.binaryOp("assign")},
    {"name": "assign_expr$string$1", "symbols": [{"literal":"+"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "assign_expr", "symbols": ["fully_qualified_name", "__nl", "assign_expr$string$1", "__", "expr"], "postprocess": t.binaryOp("plus_eq")},
    {"name": "assign_expr$string$2", "symbols": [{"literal":"-"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "assign_expr", "symbols": ["fully_qualified_name", "__nl", "assign_expr$string$2", "__", "expr"], "postprocess": t.binaryOp("minus_eq")},
    {"name": "assign_expr$string$3", "symbols": [{"literal":"*"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "assign_expr", "symbols": ["fully_qualified_name", "__nl", "assign_expr$string$3", "__", "expr"], "postprocess": t.binaryOp("times_eq")},
    {"name": "assign_expr$string$4", "symbols": [{"literal":"/"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "assign_expr", "symbols": ["fully_qualified_name", "__nl", "assign_expr$string$4", "__", "expr"], "postprocess": t.binaryOp("div_eq")},
    {"name": "assign_expr$string$5", "symbols": [{"literal":"%"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "assign_expr", "symbols": ["fully_qualified_name", "__nl", "assign_expr$string$5", "__", "expr"], "postprocess": t.binaryOp("mod_eq")},
    {"name": "assign_expr$string$6", "symbols": [{"literal":"&"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "assign_expr", "symbols": ["fully_qualified_name", "__nl", "assign_expr$string$6", "__", "expr"], "postprocess": t.binaryOp("bitwise_and_eq")},
    {"name": "assign_expr$string$7", "symbols": [{"literal":"|"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "assign_expr", "symbols": ["fully_qualified_name", "__nl", "assign_expr$string$7", "__", "expr"], "postprocess": t.binaryOp("bitwise_or_eq")},
    {"name": "assign_expr$string$8", "symbols": [{"literal":"^"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "assign_expr", "symbols": ["fully_qualified_name", "__nl", "assign_expr$string$8", "__", "expr"], "postprocess": t.binaryOp("bitwise_xor_eq")},
    {"name": "assign_expr$string$9", "symbols": [{"literal":"~"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "assign_expr", "symbols": ["fully_qualified_name", "__nl", "assign_expr$string$9", "__", "expr"], "postprocess": t.binaryOp("bitwise_neg_eq")},
    {"name": "assign_expr$string$10", "symbols": [{"literal":"&"}, {"literal":"&"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "assign_expr", "symbols": ["fully_qualified_name", "__nl", "assign_expr$string$10", "__", "expr"], "postprocess": t.binaryOp("land_eq")},
    {"name": "assign_expr$string$11", "symbols": [{"literal":"|"}, {"literal":"|"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "assign_expr", "symbols": ["fully_qualified_name", "__nl", "assign_expr$string$11", "__", "expr"], "postprocess": t.binaryOp("lor_eq")},
    {"name": "assign_expr$string$12", "symbols": [{"literal":"!"}, {"literal":"!"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "assign_expr", "symbols": ["assign_expr$string$12", "fully_qualified_name"], "postprocess": t.unaryOp("unary_neg_eq")},
    {"name": "pow_expr$string$1", "symbols": [{"literal":"*"}, {"literal":"*"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "pow_expr", "symbols": ["pow_expr", "__nl", "pow_expr$string$1", "__", "mult_expr"], "postprocess": t.binaryOp("pow")},
    {"name": "pow_expr", "symbols": [{"literal":"-"}, "mult_expr"], "postprocess": t.unaryOp("unary_minus")},
    {"name": "pow_expr", "symbols": [{"literal":"+"}, "mult_expr"], "postprocess": t.unaryOp("unary_plus")},
    {"name": "pow_expr", "symbols": ["mult_expr"]},
    {"name": "mult_expr", "symbols": ["mult_expr", "__nl", {"literal":"*"}, "__", "sum_expr"], "postprocess": t.binaryOp("times")},
    {"name": "mult_expr", "symbols": ["mult_expr", "__nl", {"literal":"/"}, "__", "sum_expr"], "postprocess": t.binaryOp("div")},
    {"name": "mult_expr", "symbols": ["mult_expr", "__nl", {"literal":"%"}, "__", "sum_expr"], "postprocess": t.binaryOp("mod")},
    {"name": "mult_expr", "symbols": ["sum_expr"]},
    {"name": "sum_expr", "symbols": ["sum_expr", "__nl", {"literal":"+"}, "__", "bit_expr"], "postprocess": t.binaryOp("plus")},
    {"name": "sum_expr", "symbols": ["sum_expr", "__nl", {"literal":"-"}, "__", "bit_expr"], "postprocess": t.binaryOp("minus")},
    {"name": "sum_expr", "symbols": ["bit_expr"]},
    {"name": "bit_expr", "symbols": ["bit_expr", "__nl", {"literal":"&"}, "__", "unary_expr"], "postprocess": t.binaryOp("bitwise_and")},
    {"name": "bit_expr", "symbols": ["bit_expr", "__nl", {"literal":"|"}, "__", "unary_expr"], "postprocess": t.binaryOp("bitwise_or")},
    {"name": "bit_expr", "symbols": ["bit_expr", "__nl", {"literal":"^"}, "__", "unary_expr"], "postprocess": t.binaryOp("bitwise_xor")},
    {"name": "bit_expr", "symbols": [{"literal":"~"}, "bit_expr"], "postprocess": t.unaryOp("bitwise_neg")},
    {"name": "bit_expr", "symbols": ["unary_expr"]},
    {"name": "unary_expr$string$1", "symbols": [{"literal":"+"}, {"literal":"+"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "unary_expr", "symbols": ["unary_expr$string$1", "fully_qualified_name"], "postprocess": t.unaryOp("pre_increment")},
    {"name": "unary_expr$string$2", "symbols": [{"literal":"-"}, {"literal":"-"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "unary_expr", "symbols": ["unary_expr$string$2", "fully_qualified_name"], "postprocess": t.unaryOp("pre_decrement")},
    {"name": "unary_expr$string$3", "symbols": [{"literal":"+"}, {"literal":"+"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "unary_expr", "symbols": ["fully_qualified_name", "unary_expr$string$3"], "postprocess": t.unaryOpPost("post_increment")},
    {"name": "unary_expr$string$4", "symbols": [{"literal":"-"}, {"literal":"-"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "unary_expr", "symbols": ["fully_qualified_name", "unary_expr$string$4"], "postprocess": t.unaryOpPost("post_decrement")},
    {"name": "unary_expr", "symbols": ["expr"], "postprocess": id},
    {"name": "logical_expr$string$1", "symbols": [{"literal":"&"}, {"literal":"&"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_expr", "symbols": ["logical_expr", "__nl", "logical_expr$string$1", "__", "expr"], "postprocess": t.binaryOp("land")},
    {"name": "logical_expr$string$2", "symbols": [{"literal":"|"}, {"literal":"|"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_expr", "symbols": ["logical_expr", "__nl", "logical_expr$string$2", "__", "expr"], "postprocess": t.binaryOp("lor")},
    {"name": "logical_expr$string$3", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_expr", "symbols": ["logical_expr", "__nl", "logical_expr$string$3", "__", "expr"], "postprocess": t.binaryOp("eq")},
    {"name": "logical_expr$string$4", "symbols": [{"literal":"!"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_expr", "symbols": ["logical_expr", "__nl", "logical_expr$string$4", "__", "expr"], "postprocess": t.binaryOp("neq")},
    {"name": "logical_expr", "symbols": ["logical_expr", "__nl", {"literal":"<"}, "__", "expr"], "postprocess": t.binaryOp("lt")},
    {"name": "logical_expr", "symbols": ["logical_expr", "__nl", {"literal":">"}, "__", "expr"], "postprocess": t.binaryOp("gt")},
    {"name": "logical_expr$string$5", "symbols": [{"literal":"<"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_expr", "symbols": ["logical_expr", "__nl", "logical_expr$string$5", "__", "expr"], "postprocess": t.binaryOp("leq")},
    {"name": "logical_expr$string$6", "symbols": [{"literal":">"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_expr", "symbols": ["logical_expr", "__nl", "logical_expr$string$6", "__", "expr"], "postprocess": t.binaryOp("geq")},
    {"name": "logical_expr", "symbols": [{"literal":"!"}, "logical_expr"], "postprocess": t.unaryOp("neg")},
    {"name": "logical_expr", "symbols": ["expr"], "postprocess": id},
    {"name": "spe_expr$string$1", "symbols": [{"literal":"i"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "spe_expr", "symbols": ["expr", "__nl", "spe_expr$string$1", "__", "expr"], "postprocess": t.binaryOp("in")},
    {"name": "spe_expr$string$2", "symbols": [{"literal":"?"}, {"literal":"?"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "spe_expr", "symbols": ["expr", "__nl", "spe_expr$string$2", "__", "expr"], "postprocess": t.binaryOp("null_coalescing")},
    {"name": "operator", "symbols": [{"literal":"<"}], "postprocess": id},
    {"name": "operator", "symbols": [{"literal":">"}], "postprocess": id},
    {"name": "operator$string$1", "symbols": [{"literal":"<"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$1"], "postprocess": id},
    {"name": "operator$string$2", "symbols": [{"literal":">"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$2"], "postprocess": id},
    {"name": "operator$string$3", "symbols": [{"literal":"|"}, {"literal":"|"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$3"], "postprocess": id},
    {"name": "operator", "symbols": [{"literal":"|"}], "postprocess": id},
    {"name": "operator$string$4", "symbols": [{"literal":"&"}, {"literal":"&"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$4"], "postprocess": id},
    {"name": "operator", "symbols": [{"literal":"&"}], "postprocess": id},
    {"name": "operator", "symbols": [{"literal":"!"}], "postprocess": id},
    {"name": "operator", "symbols": [{"literal":"~"}], "postprocess": id},
    {"name": "operator", "symbols": [{"literal":"^"}], "postprocess": id},
    {"name": "operator", "symbols": [{"literal":"+"}], "postprocess": id},
    {"name": "operator", "symbols": [{"literal":"-"}], "postprocess": id},
    {"name": "operator", "symbols": [{"literal":"*"}], "postprocess": id},
    {"name": "operator", "symbols": [{"literal":"/"}], "postprocess": id},
    {"name": "operator", "symbols": [{"literal":"%"}], "postprocess": id},
    {"name": "operator$string$5", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$5"], "postprocess": id},
    {"name": "operator$string$6", "symbols": [{"literal":"!"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$6"], "postprocess": id},
    {"name": "operator", "symbols": [{"literal":"="}], "postprocess": id},
    {"name": "operator$string$7", "symbols": [{"literal":"?"}, {"literal":"?"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$7"], "postprocess": id},
    {"name": "operator$string$8", "symbols": [{"literal":"+"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$8"], "postprocess": id},
    {"name": "operator$string$9", "symbols": [{"literal":"-"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$9"], "postprocess": id},
    {"name": "operator$string$10", "symbols": [{"literal":"*"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$10"], "postprocess": id},
    {"name": "operator$string$11", "symbols": [{"literal":"/"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$11"], "postprocess": id},
    {"name": "operator$string$12", "symbols": [{"literal":"%"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$12"], "postprocess": id},
    {"name": "operator$string$13", "symbols": [{"literal":"&"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$13"], "postprocess": id},
    {"name": "operator$string$14", "symbols": [{"literal":"|"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$14"], "postprocess": id},
    {"name": "operator$string$15", "symbols": [{"literal":"^"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$15"], "postprocess": id},
    {"name": "operator$string$16", "symbols": [{"literal":"~"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$16"], "postprocess": id},
    {"name": "operator$string$17", "symbols": [{"literal":"&"}, {"literal":"&"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$17"], "postprocess": id},
    {"name": "operator$string$18", "symbols": [{"literal":"|"}, {"literal":"|"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$18"], "postprocess": id},
    {"name": "operator$string$19", "symbols": [{"literal":"!"}, {"literal":"!"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$19"], "postprocess": id},
    {"name": "operator$string$20", "symbols": [{"literal":"+"}, {"literal":"+"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$20"], "postprocess": id},
    {"name": "operator$string$21", "symbols": [{"literal":"-"}, {"literal":"-"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$21"], "postprocess": id},
    {"name": "operator$string$22", "symbols": [{"literal":"*"}, {"literal":"*"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$22"], "postprocess": id},
    {"name": "operator$string$23", "symbols": [{"literal":"i"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$23"], "postprocess": id},
    {"name": "operator$string$24", "symbols": [{"literal":"("}, {"literal":")"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$24"], "postprocess": id},
    {"name": "operator$string$25", "symbols": [{"literal":"["}, {"literal":"]"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "operator", "symbols": ["operator$string$25"], "postprocess": id},
    {"name": "func_call", "symbols": ["expr", "func_args"], "postprocess": data => ({ type: "func_call", func: t.first(data), args: t.last(data), })},
    {"name": "func_args", "symbols": [{"literal":"("}, "_", "arg_list", "_", {"literal":")"}], "postprocess": t.mid},
    {"name": "arg_list", "symbols": [], "postprocess": () => ({ type: "arg_list", args: [] })},
    {"name": "arg_list$ebnf$1", "symbols": []},
    {"name": "arg_list$ebnf$1$subexpression$1", "symbols": ["_", {"literal":","}, "__nl", "expr"]},
    {"name": "arg_list$ebnf$1", "symbols": ["arg_list$ebnf$1", "arg_list$ebnf$1$subexpression$1"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "arg_list$ebnf$2$subexpression$1", "symbols": ["_", {"literal":","}, "__nl"]},
    {"name": "arg_list$ebnf$2", "symbols": ["arg_list$ebnf$2$subexpression$1"], "postprocess": id},
    {"name": "arg_list$ebnf$2", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "arg_list", "symbols": ["expr", "arg_list$ebnf$1", "arg_list$ebnf$2"], "postprocess": data => ({ type: "arg_list", args: [t.first(data), ...t.second(data).map(t.last)] })},
    {"name": "ufc", "symbols": ["expr", {"literal":"@"}, "func_call"], "postprocess": data => ({ type: "ufc", caller: t.first(data), call: t.last(data) })},
    {"name": "method_call", "symbols": ["expr", {"literal":"."}, "ident", "func_args"], "postprocess": data => ({ type: "method_call", object: t.first(data), method: t.beforeLast(data), args: t.last(data) })},
    {"name": "method_call", "symbols": ["expr", {"literal":"["}, "_nl", "expr", "_nl", {"literal":"]"}, "func_args"], "postprocess": data => ({ type: "method_call", object: t.first(data), method: data[3], args: t.last(data) })},
    {"name": "params", "symbols": [{"literal":"("}, "_nl", "param_list", "_nl", {"literal":")"}], "postprocess": t.mid},
    {"name": "params", "symbols": ["ident"], "postprocess": t.id},
    {"name": "lambda", "symbols": ["params", "expression_body"], "postprocess": data => ({ type: "lambda", params: t.first(data), body: t.last(data) })},
    {"name": "anonymous_func", "symbols": ["function_prefix", "params", "expr_block"], "postprocess": data => ({ type: "anonymous_func", params: t.mid(data), body: t.last(data) })},
    {"name": "computed_property", "symbols": ["ident", "computed_body"], "postprocess": data => ({ type: "computed_property", property: t.first(data), body: t.last(data) })},
    {"name": "param_list", "symbols": [], "postprocess": () => ({ type: "param_list", params: [] })},
    {"name": "param_list$ebnf$1$subexpression$1", "symbols": ["_", {"literal":","}, "_", "ident"]},
    {"name": "param_list$ebnf$1", "symbols": ["param_list$ebnf$1$subexpression$1"]},
    {"name": "param_list$ebnf$1$subexpression$2", "symbols": ["_", {"literal":","}, "_", "ident"]},
    {"name": "param_list$ebnf$1", "symbols": ["param_list$ebnf$1", "param_list$ebnf$1$subexpression$2"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "param_list$ebnf$2$subexpression$1", "symbols": ["_", {"literal":","}, "_"]},
    {"name": "param_list$ebnf$2", "symbols": ["param_list$ebnf$2$subexpression$1"], "postprocess": id},
    {"name": "param_list$ebnf$2", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "param_list", "symbols": ["ident", "param_list$ebnf$1", "param_list$ebnf$2"], "postprocess": data => ({ type: "param_list", params: [t.first(data), ...t.second(data).map(t.last)] })},
    {"name": "throw_stmt$string$1", "symbols": [{"literal":"t"}, {"literal":"h"}, {"literal":"r"}, {"literal":"o"}, {"literal":"w"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "throw_stmt", "symbols": ["throw_stmt$string$1", "__", "expr"], "postprocess": data => ({ type: "throw_stmt", exception: t.last(data) })},
    {"name": "ifBranch$string$1", "symbols": [{"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "ifBranch", "symbols": ["ifBranch$string$1", "_", {"literal":"("}, "_nl", "expr", "_nl", {"literal":")"}, "_nl", "expr"], "postprocess": data => ({ type: "if_branch", condition:t.mid(data), body: t.last(data) })},
    {"name": "elseIfBranch$string$1", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "elseIfBranch", "symbols": ["elseIfBranch$string$1", "__", "ifBranch"], "postprocess": data => ({ ...t.last(data), type: "else_if_branch" })},
    {"name": "elseBranch$string$1", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "elseBranch", "symbols": ["elseBranch$string$1", "_nl", "expr"], "postprocess": data => ({ ...t.last(data), type: "else_branch" })},
    {"name": "whileBlock$string$1", "symbols": [{"literal":"w"}, {"literal":"h"}, {"literal":"i"}, {"literal":"l"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "whileBlock", "symbols": ["whileBlock$string$1", "_", {"literal":"("}, "_nl", "expr", "_nl", {"literal":")"}], "postprocess": t.afterMid},
    {"name": "if_stmt$ebnf$1", "symbols": []},
    {"name": "if_stmt$ebnf$1$subexpression$1", "symbols": ["elseIfBranch"]},
    {"name": "if_stmt$ebnf$1", "symbols": ["if_stmt$ebnf$1", "if_stmt$ebnf$1$subexpression$1"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "if_stmt$ebnf$2$subexpression$1", "symbols": ["elseBranch"]},
    {"name": "if_stmt$ebnf$2", "symbols": ["if_stmt$ebnf$2$subexpression$1"], "postprocess": id},
    {"name": "if_stmt$ebnf$2", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "if_stmt", "symbols": ["ifBranch", "if_stmt$ebnf$1", "if_stmt$ebnf$2"], "postprocess": data => ({ type: "if_stmt", ifBranch: t.first(data), elseIfBranches: t.mid(data).map(id), elseBranch: t.last(data) })},
    {"name": "while_stmt", "symbols": ["whileBlock", "_nl", "expr"], "postprocess": data => ({ type: "while_stmt", condition: t.first(data), body: t.last(data) })},
    {"name": "do_while_stmt$string$1", "symbols": [{"literal":"d"}, {"literal":"o"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "do_while_stmt", "symbols": ["do_while_stmt$string$1", "_nl", "expr", "_nl", "whileBlock"], "postprocess": data => ({ type: "do_while_stmt", condition: t.last(data), body: t.mid(data) })},
    {"name": "arrayLiteral", "symbols": [{"literal":"["}, "_nl", "arg_list", "_nl", {"literal":"]"}], "postprocess": data => ({ type: "arrayLiteral", items: t.mid(data) })},
    {"name": "objectLiteral", "symbols": [{"literal":"{"}, "__nl", {"literal":"}"}], "postprocess": data => ({ type: "objectLiteral", entries: t.mid(data) })},
    {"name": "nullLiteral$string$1", "symbols": [{"literal":"n"}, {"literal":"u"}, {"literal":"l"}, {"literal":"l"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "nullLiteral", "symbols": ["nullLiteral$string$1"]},
    {"name": "destructuring", "symbols": ["array_destructuring"], "postprocess": id},
    {"name": "destructuring", "symbols": ["object_destructuring"], "postprocess": id},
    {"name": "array_destructuring", "symbols": [{"literal":"["}, "_", "destructuring_list", "_", {"literal":"]"}], "postprocess": data => ({ type: "array_destructuring", structure: t.mid(data) })},
    {"name": "object_destructuring", "symbols": [{"literal":"{"}, "_", "destructuring_list", "_", {"literal":"}"}], "postprocess": data => ({ type: "object_destructuring", structure: t.mid(data) })},
    {"name": "destructuring_list$ebnf$1", "symbols": []},
    {"name": "destructuring_list$ebnf$1$subexpression$1", "symbols": ["_", {"literal":","}, "__", "ident"]},
    {"name": "destructuring_list$ebnf$1", "symbols": ["destructuring_list$ebnf$1", "destructuring_list$ebnf$1$subexpression$1"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "destructuring_list$ebnf$2$subexpression$1", "symbols": ["_", {"literal":","}, "__"]},
    {"name": "destructuring_list$ebnf$2", "symbols": ["destructuring_list$ebnf$2$subexpression$1"], "postprocess": id},
    {"name": "destructuring_list$ebnf$2", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "destructuring_list", "symbols": ["ident", "destructuring_list$ebnf$1", "destructuring_list$ebnf$2"], "postprocess": data => ({ type: "destructuring_list", items: [t.first(data), ...t.mid(data).map(t.beforeLast)] })},
    {"name": "match_expr$string$1", "symbols": [{"literal":"m"}, {"literal":"a"}, {"literal":"t"}, {"literal":"c"}, {"literal":"h"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "match_expr", "symbols": ["match_expr$string$1", {"literal":"("}, "_nl", "expr", "_nl", {"literal":")"}, "matchBody"], "postprocess": data => ({ type: "match_stmt", matched: t.mid(data), body: t.last(data) })},
    {"name": "matchBody$ebnf$1", "symbols": ["matchBranch"]},
    {"name": "matchBody$ebnf$1", "symbols": ["matchBody$ebnf$1", "matchBranch"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "matchBody", "symbols": [{"literal":"{"}, "__nl", "matchBody$ebnf$1", "matchDefaultBranch", "__nl", {"literal":"}"}], "postprocess": data => ({ type: "match_body", branches: t.beforeMid(data), defaultBranch: t.afterMid(data) })},
    {"name": "matchDefaultBranch", "symbols": [{"literal":"_"}, "matchBranchBody"], "postprocess": data => ({ type: "match_default_branch", body: t.last(data) })},
    {"name": "matchBranchBody$string$1", "symbols": [{"literal":"-"}, {"literal":">"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "matchBranchBody", "symbols": ["__", "matchBranchBody$string$1", "__", "expr"], "postprocess": t.last},
    {"name": "matchBranch", "symbols": ["matchStructure", "matchBranchBody", "__nl"], "postprocess": data => ({ type: "match_branch", body: t.mid(data), structure: matchStructure })},
    {"name": "matchStructure", "symbols": ["array_destructuring"], "postprocess": data => ({ type: "destructuring_match", structure: t.first(data) })},
    {"name": "matchStructure", "symbols": ["literal"], "postprocess": data => ({ type: "literal_match", structure: t.first(data) })},
    {"name": "matchStructure", "symbols": ["matchOrIntroduceVariable"], "postprocess": id},
    {"name": "matchStructure$ebnf$1$subexpression$1", "symbols": ["_", {"literal":","}, "__", "matchStructure"]},
    {"name": "matchStructure$ebnf$1", "symbols": ["matchStructure$ebnf$1$subexpression$1"]},
    {"name": "matchStructure$ebnf$1$subexpression$2", "symbols": ["_", {"literal":","}, "__", "matchStructure"]},
    {"name": "matchStructure$ebnf$1", "symbols": ["matchStructure$ebnf$1", "matchStructure$ebnf$1$subexpression$2"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "matchStructure$ebnf$2$subexpression$1", "symbols": ["_", {"literal":","}, "__"]},
    {"name": "matchStructure$ebnf$2", "symbols": ["matchStructure$ebnf$2$subexpression$1"], "postprocess": id},
    {"name": "matchStructure$ebnf$2", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "matchStructure", "symbols": ["matchStructure", "matchStructure$ebnf$1", "matchStructure$ebnf$2"], "postprocess": data => ({ type: "choice_match", choices: [t.first(data), ...t.second(data).map(t.last)] })},
    {"name": "matchStructure$ebnf$3$subexpression$1", "symbols": ["_", {"literal":"&"}, "__", "matchStructure"]},
    {"name": "matchStructure$ebnf$3", "symbols": ["matchStructure$ebnf$3$subexpression$1"]},
    {"name": "matchStructure$ebnf$3$subexpression$2", "symbols": ["_", {"literal":"&"}, "__", "matchStructure"]},
    {"name": "matchStructure$ebnf$3", "symbols": ["matchStructure$ebnf$3", "matchStructure$ebnf$3$subexpression$2"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "matchStructure$ebnf$4$subexpression$1", "symbols": ["_", {"literal":"&"}, "__"]},
    {"name": "matchStructure$ebnf$4", "symbols": ["matchStructure$ebnf$4$subexpression$1"], "postprocess": id},
    {"name": "matchStructure$ebnf$4", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "matchStructure", "symbols": ["matchStructure", "matchStructure$ebnf$3", "matchStructure$ebnf$4"], "postprocess": data => ({ type: "multiple_match", criterias: [t.first(data), ...t.second(data).map(t.last)] })},
    {"name": "matchStructure", "symbols": [{"literal":"["}, "_", "matchOrIntroduceVariable", "__", {"literal":"|"}, "__", "matchOrIntroduceVariable", "_", {"literal":"]"}], "postprocess": data => ({ type: "array_match", head: data[2], tail: data[6] })},
    {"name": "matchVariable", "symbols": [{"literal":"<"}, "_", "fully_qualified_name", "_", {"literal":">"}], "postprocess": data => ({ type: "variable_match", ref: t.mid(data) })},
    {"name": "matchOrIntroduceVariable", "symbols": ["matchVariable"], "postprocess": id},
    {"name": "matchOrIntroduceVariable", "symbols": ["ident"], "postprocess": data => ({ type: "introduce_variable_match", variable: t.first(data) })},
    {"name": "program$ebnf$1$subexpression$1", "symbols": ["_nl", "expr"]},
    {"name": "program$ebnf$1", "symbols": ["program$ebnf$1$subexpression$1"]},
    {"name": "program$ebnf$1$subexpression$2", "symbols": ["_nl", "expr"]},
    {"name": "program$ebnf$1", "symbols": ["program$ebnf$1", "program$ebnf$1$subexpression$2"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "program", "symbols": ["program$ebnf$1", "_nl"], "postprocess": t.mapFirst(t.last)},
    {"name": "_$ebnf$1", "symbols": []},
    {"name": "_$ebnf$1", "symbols": ["_$ebnf$1", (lexer.has("WS") ? {type: "WS"} : WS)], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "_", "symbols": ["_$ebnf$1"]},
    {"name": "__$ebnf$1", "symbols": [(lexer.has("WS") ? {type: "WS"} : WS)]},
    {"name": "__$ebnf$1", "symbols": ["__$ebnf$1", (lexer.has("WS") ? {type: "WS"} : WS)], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "__", "symbols": ["__$ebnf$1"]},
    {"name": "_nl$ebnf$1", "symbols": []},
    {"name": "_nl$ebnf$1$subexpression$1", "symbols": [(lexer.has("WS") ? {type: "WS"} : WS)]},
    {"name": "_nl$ebnf$1$subexpression$1", "symbols": [(lexer.has("NL") ? {type: "NL"} : NL)]},
    {"name": "_nl$ebnf$1", "symbols": ["_nl$ebnf$1", "_nl$ebnf$1$subexpression$1"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "_nl", "symbols": ["_nl$ebnf$1"]},
    {"name": "__nl$ebnf$1$subexpression$1", "symbols": [(lexer.has("WS") ? {type: "WS"} : WS)]},
    {"name": "__nl$ebnf$1$subexpression$1", "symbols": [(lexer.has("NL") ? {type: "NL"} : NL)]},
    {"name": "__nl$ebnf$1", "symbols": ["__nl$ebnf$1$subexpression$1"]},
    {"name": "__nl$ebnf$1$subexpression$2", "symbols": [(lexer.has("WS") ? {type: "WS"} : WS)]},
    {"name": "__nl$ebnf$1$subexpression$2", "symbols": [(lexer.has("NL") ? {type: "NL"} : NL)]},
    {"name": "__nl$ebnf$1", "symbols": ["__nl$ebnf$1", "__nl$ebnf$1$subexpression$2"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "__nl", "symbols": ["__nl$ebnf$1"]},
    {"name": "ident", "symbols": [(lexer.has("ident") ? {type: "ident"} : ident)], "postprocess": id},
    {"name": "numberLiteral", "symbols": [(lexer.has("numberLiteral") ? {type: "numberLiteral"} : numberLiteral)], "postprocess": id},
    {"name": "stringLiteral", "symbols": [(lexer.has("stringLiteral") ? {type: "stringLiteral"} : stringLiteral)], "postprocess": id},
    {"name": "booleanLiteral$subexpression$1", "symbols": [{"literal":"true"}]},
    {"name": "booleanLiteral$subexpression$1", "symbols": [{"literal":"false"}]},
    {"name": "booleanLiteral", "symbols": ["booleanLiteral$subexpression$1"], "postprocess": id},
    {"name": "function_prefix$subexpression$1", "symbols": [{"literal":"fn"}]},
    {"name": "function_prefix$subexpression$1", "symbols": [{"literal":"function"}]},
    {"name": "function_prefix", "symbols": ["function_prefix$subexpression$1"], "postprocess": id},
    {"name": "functionLiteral", "symbols": ["anonymous_func"]},
    {"name": "functionLiteral", "symbols": ["lambda"], "postprocess": id},
    {"name": "literal", "symbols": ["numberLiteral"], "postprocess": id},
    {"name": "literal", "symbols": ["booleanLiteral"], "postprocess": id},
    {"name": "literal", "symbols": ["stringLiteral"], "postprocess": id},
    {"name": "literal", "symbols": ["nullLiteral"], "postprocess": id},
    {"name": "literal", "symbols": ["functionLiteral"], "postprocess": id},
    {"name": "literal", "symbols": ["arrayLiteral"], "postprocess": id},
    {"name": "literal", "symbols": ["objectLiteral"], "postprocess": id},
    {"name": "operator_name", "symbols": [{"literal":"operator\""}, "operator", {"literal":"\""}], "postprocess": data => ({ type: "operator_name", operator: t.mid(data) })},
    {"name": "fully_qualified_name$ebnf$1", "symbols": []},
    {"name": "fully_qualified_name$ebnf$1$subexpression$1", "symbols": ["ident", {"literal":"::"}]},
    {"name": "fully_qualified_name$ebnf$1", "symbols": ["fully_qualified_name$ebnf$1", "fully_qualified_name$ebnf$1$subexpression$1"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "fully_qualified_name$subexpression$1", "symbols": ["ident"]},
    {"name": "fully_qualified_name$subexpression$1", "symbols": ["operator_name"]},
    {"name": "fully_qualified_name", "symbols": ["fully_qualified_name$ebnf$1", "fully_qualified_name$subexpression$1"], "postprocess": data => ({ type: "fqn", path: [...t.mapFirst(id)(data), t.last(data)] })},
    {"name": "expr", "symbols": ["literal"], "postprocess": id},
    {"name": "expr", "symbols": ["fully_qualified_name"], "postprocess": id},
    {"name": "expr", "symbols": ["expr_block"], "postprocess": id},
    {"name": "expr", "symbols": ["paren_expr"], "postprocess": id},
    {"name": "expr", "symbols": ["operation"], "postprocess": id},
    {"name": "expr", "symbols": ["ternary"], "postprocess": id},
    {"name": "expr", "symbols": ["func_call"], "postprocess": id},
    {"name": "expr", "symbols": ["ufc"], "postprocess": id},
    {"name": "expr", "symbols": ["method_call"], "postprocess": id},
    {"name": "expr", "symbols": ["match_expr"], "postprocess": id},
    {"name": "expr", "symbols": ["statement"], "postprocess": id},
    {"name": "statement", "symbols": ["throw_stmt"], "postprocess": id},
    {"name": "statement", "symbols": ["if_stmt"], "postprocess": id},
    {"name": "statement", "symbols": ["while_stmt"], "postprocess": id},
    {"name": "statement", "symbols": ["do_while_stmt"], "postprocess": id},
    {"name": "paren_expr", "symbols": [{"literal":"("}, "_nl", "expr", "_nl", {"literal":")"}], "postprocess": data => ({ type: "paren_expr", expr: t.mid(data) })},
    {"name": "expr_block$ebnf$1", "symbols": []},
    {"name": "expr_block$ebnf$1$subexpression$1", "symbols": ["expr", "__nl"]},
    {"name": "expr_block$ebnf$1", "symbols": ["expr_block$ebnf$1", "expr_block$ebnf$1$subexpression$1"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "expr_block", "symbols": [{"literal":"{"}, "_nl", "expr_block$ebnf$1", {"literal":"}"}], "postprocess": data => ({ type: "expr_block", exprs: t.at(2)(data).map(t.first) })},
    {"name": "expression_body", "symbols": ["__", {"literal":"=>"}, "_nl", "expr"], "postprocess": data => ({ type: "expression_body", body: t.last(data) })},
    {"name": "computed_body", "symbols": ["__", {"literal":"~>"}, "_nl", "expr"], "postprocess": data => ({ type: "computed_body", body: t.last(data) })},
    {"name": "ternary", "symbols": ["expr", "__nl", {"literal":"?"}, "__", "expr", "__nl", {"literal":":"}, "__", "expr"], "postprocess": data => ({ type: "ternary", condition: t.first(data), ifTrue: t.mid(data), ifFalse: t.last(data) })}
]
  , ParserStart: "program"
}
if (typeof module !== 'undefined'&& typeof module.exports !== 'undefined') {
   module.exports = grammar;
} else {
   window.grammar = grammar;
}
})();
