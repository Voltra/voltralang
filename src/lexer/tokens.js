const moo = require("moo");

const operators = {
	eq: "==", // logical equivalence
	neq: "!=", // logical inequivalence
	ns: "::", // namespace separator
	ufc: "@", // unified function call operator, annotation
	null_coal: "??", // null coalescing
	plus_eq: "+=",
	minus_eq: "-=",
	times_eq: "*=",
	div_eq: "/=",
	mod_eq: "%=",
	bitwise_and_eq: "&=",
	bitwise_or_eq: "|=",
	bitwise_xor_eq: "^=",
	// "~=",
	land_eq: "&&=",
	lor_eq: "||=",
	unary_neg_eq: "!!=", // unary boolean negate
	incr: "++", // unary pre/post increment
	decr: "--", // unary pre/post decrement
	pow: "**", // pow
	leq: "<=", // leq
	geq: ">=", // geq
	
	dot: ".", // object property
	lt: "<", // less than, lcaret
	gt: ">", // greater than, rcaret
	arrow: "->",
	fat_arrow: "=>", // expression body, 
	wavy_arrow: "~>",
	lor: "||", // logical or
	bitwise_or: "|", // bitwise or, pipe
	land: "&&", // logical and
	bitwise_and: "&", // bitwise and
	neg: "!", // logical not
	bitwise_neg: "~", // bitwise not
	bitwise_xor: "^", // xor
	plus: "+", // unary plus, plus
	minus: "-", // unary minus, minus
	times: "*", // mult
	div: "/", // div
	mod: "%", // mod
	assign: "=", // equal
	question: "?", // for ternary and optional chaining,
	colon: ":", // for ternary
};



const keywordArr = [
	"operator", // for operator declaration
	"in", // pseudo operator : for key in obj, item in array
	"if",
	"while",
	"else",
	"for",
	"do",
	"match",
	"async",
	"await",
	"import",
	"export",
	"from",
	"const",
	"let",
	"final",
	"class",
	"public",
	"private",
	"protected",
	"class",
	"interface",
	"type",
	"extends",
	"implements",
	"fn",
	"function",
	"throw",
	"return",

	"true",
	"false",
	"null",
	"_",
	"this",
];

const keyword = keywordArr.reduce((acc, kw) => ({ ...acc, [`kW${kw}`]: kw }), {});

const tokens = {
	WS: /[ \t]/,
	NL: {
		match: /\r?\n/,
		lineBreaks: true,
	},
	ident: {
		match: /[a-zA-Z_$]\w*/,
		type: moo.keywords(keyword),
	},
	...keyword,
	...operators,
	comment: /\/\/.*?$/,
	// comment: /(?:\/\/.*?$|\/\*(?!\*\/)*?\*\/)/,
	numberLiteral: /(?:-?\d+(?:\.\d*?)?|-?\d*?\.)(?:e-?\d+)?/,
	stringLiteral: [
		{
			match:  /"(?:\\["rn]|[^"\\])*?"/,
			lineBreaks: false,
			value: str => str.slice(1, -1),
		},
	],
	lparen: "(",
	rparen: ")",
	lbracket: "[",
	rbracket: "]",
	lcurly: "{",
	rcurly: "}",
	comma: ",",
	semi: ";",
};

const shouldPass = {
	comment: [
		"// je suis un // commentaire",
		"//TODO: aze",
		"/* aze */",
		"/**/",
		"/***/",
		"/***\\  \\***/",
	],
	number: [
		"1",
		".1",
		".0",
		"0",
		"0.",
		"-1.",
		".15",
		"0.15",
		"123.50",
		"-.5",
		"-0.5",
		"1e5",
		"-1e5",
		"-1e-5",
	],
};


module.exports = {
	operators,
	keyword,
	tokens,
	shouldPass,
};