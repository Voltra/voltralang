const { Parser, Grammar } = require("nearley");
const grammar = require("../grammar");
const yargs = require("yargs/yargs");
const { hideBin } = require("yargs/helpers");
const fs = require("fs-extra");
const path = require("path");

const parser = new Parser(Grammar.fromCompiled(grammar));

const isParseError = e => ["offset", "token"].every(key => key in e);

const parse = content => {
	parser.feed(content);
	return parser.results[0];
};

const parseFile = async ({ verbose, file, output }) => {
	try{
		const content = await fs.readFile(file, "utf8");
		const ast = parse(content);
		const json = JSON.stringify(ast, null, 4);
		await fs.writeFile(output, json, "utf8");
	}catch(e){
		if(isParseError(e)){
			const { token, offset } = e;
			const { line, col, type } = token;
			console.error(`Error at l${line}:c${col}, unexpected ${type} "${token}"`);
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
