const { Parser, Grammar } = require("nearley");
const grammar = require("../grammar");
const yargs = require("yargs/yargs");
const { hideBin } = require("yargs/helpers");
const fs = require("fs-extra");
const path = require("path");

const parser = new Parser(
	Grammar.fromCompiled(grammar),
	{ keepHistory: true, },
);

const isParseError = e => ["offset", "token"].every(key => key in e) && !!e.token;
const hasPosition = token => ["line", "col", "type"].every(key => key in token);

const AmbiguousGrammar = class extends Error{
	constructor(results){
		super();
		this.results = results;
	}
};
const ParserFailure = class extends Error{};


const parse = content => {
	parser.feed(content);

	if(parser.results.length === 1){
		return parser.results[0];
	}else if(parser.results.length > 1){
		console.warn("Grammar is ambiguous");
		throw new AmbiguousGrammar(parser.results);
	}else{
		throw new ParserFailure();
	}
};

function refReplacer() {
	let m = new Map(), v= new Map(), init = null;

	return function(field, value) {
		let p= m.get(this) + (Array.isArray(this) ? `[${field}]` : '.' + field); 
		let isComplex = value===Object(value)

		if (isComplex) m.set(value, p);  

		let pp = v.get(value)||'';
		let path = p.replace(/undefined\.\.?/,'');
		let val = pp ? `#REF:${pp[0]=='[' ? '$':'$.'}${pp}` : value;

		!init ? (init=value) : (val===init ? val="#REF:$" : 0);
		if(!pp && isComplex)
			v.set(value, path);

		return val;
	}
}

const writeJson = async (jsonable, output, circular = false) => {
	const repl = circular ? refReplacer() : null;
	const json = JSON.stringify(jsonable, repl, 4);
	await fs.writeFile(output, json, "utf8");
};

const dumpTable = async output => {
	await writeJson(
		parser.table.map(x => Object.keys(x.completed)),
		`${output}.error.json`,
		true
	);
};

const parseFile = async ({ verbose, file, output }) => {
	try{
		const content = await fs.readFile(file, "utf8");
		const ast = parse(content);
		await writeJson(ast, output);
	}catch(e){
		if(isParseError(e)){
			const { token } = e;

			if(hasPosition(token)){
				const { line, col, type } = token;
				console.error(`Unexpected ${type} "${token}" at l${line}:c${col}`);
			}else
				console.error(token);
		}else if(e instanceof AmbiguousGrammar){
			await dumpTable(output);

			e.results.forEach(async (ast, i) => {
				await writeJson(ast, `${output}.${i}.error.json`);
			});
		}else
			console.error(e);
	}
};

const main = argv => {
	return yargs(hideBin(argv))
	.command("parse [file] [output]", "parse a file", yargs => {
		return yargs
		.positional("file", {
			describe: "the file to parse",
			default: "index.voltra",
		}).positional("output", {
			describe: "the output file",
			default: "voltra.ast",
		}).coerce(["file", "output"], path.resolve);
	}, parseFile)
	.strictCommands()
	.demandCommand(1, "You need at least one command to execute")
	.option("verbose", {
		alias: "v",
		type: "boolean",
		description: "Run with verbose logging",
	})
	.help()
	.argv;
};

if(require.main === module){
	main(process.argv);
}

module.exports = {
	parser,
	parse,
};
