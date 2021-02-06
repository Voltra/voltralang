const AmbiguousGrammar = class extends Error{
	constructor(results){
		super();
		this.results = results;
	}
};

const ParserFailure = class extends Error{};

module.exports = {
	AmbiguousGrammar,
	ParserFailure,
};