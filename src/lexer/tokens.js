export const operator = [
	".", // object property
	"<", // less than, lcaret
	">", // greater than, rcaret
	"<=", // leq
	">=", // geq
	"->",
	"=>", // expression body, 
	"~>",
	"||", // logical or
	"|", // bitwise or, pipe
	"&&", // logical and
	"&", // bitwise and
	"!", // logical not
	"~", // bitwise not
	"+", // unary plus, plus
	"-", // unary minus, minus
	"*", // mult
	"/", // div
	"%", // mod
	"==", // logical equivalence
	"!=", // logical inequivalence
	"=", // equal
	"::", // namespace separator
	"@", // unified function call operator, annotation
];

export const keyword = [
	"in",
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
].reduce((acc, kw) => ({ ...acc, [kw]: kw }), {});

export const tokens = {
	ws: {
		match: /\s+/,
		lineBreaks: true,
	},
	ident: {
		match: /[a-zA-Z_$]\w*/,
		type: moo.keywords(keyword),
	},
	operator,
	comment: /(\/\/.*?$|\/\*(?!\*\/)*?\*\/)/m,
	numberLiteral: /(-?\d+(\.\d*)?|-?\d*\.)(e-?\d+)?/,
	stringLiteral: [
		{
			match:  /"(?:\\["\\rn]|[^"\\])*?"/,
			lineBreaks: false,
			value: str => str.slice(1, -1),
		},{
			match: /R"\(.*?\)"/,
			lineBreaks: true,
		},
	],
	lparen: "(",
	rparen: ")",
	lbracket: "[",
	rbracket: "]",
	comma: ",",
	semi: ";",
	colon: ":",
};

export const shouldPass = {
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