const { Parser, Grammar } = require("nearley");
const grammar = require("../grammar");
const yargs = require("yargs/yargs");
const { hideBin } = require("yargs/helpers");
const fs = require("fs-extra");
const path = require("path");

const { writeJson } = require("./json");
const { dumpTable, isParseError, hasPosition } = require("./helpers");
const { AmbiguousGrammar, ParserFailure } = require("./errors");

const parser = new Parser(
	Grammar.fromCompiled(grammar),
	{ keepHistory: true, },
);

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
			await dumpTable(parser, output);

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
