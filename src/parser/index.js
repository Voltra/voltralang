import { Parser, Grammar } from "nearly"
import grammar from "../grammar"
import yargs from "yargs/yargs"
import { hideBin } from "yargs/helpers"
import fs from "fs-extra"

export const parser = new Parser(Grammar.fromCompiled(grammar));

export const parse = content => {
	parser.feed(content);
	return parser.results;
};

const parseFile = async ({ verbose, file, output }) => {
	const content = await fs.readFile(file, "utf8");
	const ast = parse(content);
	await fs.writeFile(output, ast, "utf8");
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
		});
	}, parseFile)
	.option("verbose", {
		alias: "v",
		type: "boolean",
		description: "Run with verbose logging",
	});
};

if(require.main === module){
	main(process.argv);
}
