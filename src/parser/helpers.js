const { writeJson } = require("./json");

const isParseError = e => ["offset", "token"].every(key => key in e) && !!e.token;

const hasPosition = token => ["line", "col", "type"].every(key => key in token);

const dumpTable = async (parser, output) => {
	await writeJson(
		parser.table.map(x => Object.keys(x.completed)),
		`${output}.error.json`,
		true
	);
};

module.exports = {
	isParseError,
	hasPosition,
	dumpTable,
};