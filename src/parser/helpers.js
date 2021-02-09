const { writeJson } = require("./json");

const isParseError = e => ["offset", "token"].every(key => key in e) && !!e.token;

const hasPosition = token => ["line", "col", "type"].every(key => key in token);

const dumpTable = async (parser, output) => {
	const table = parser.table || (parser.parser && parser.parser.table);
	await writeJson(
		table.map(x => Object.keys(x.completed)),
		`${output}.error.json`,
		true
	);
};

module.exports = {
	isParseError,
	hasPosition,
	dumpTable,
};