const moo = require("moo");
const { tokens } = require("./tokens");

const lexer = moo.compile(tokens);

module.exports = {
	lexer,
};