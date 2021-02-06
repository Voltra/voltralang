const fs = require("fs-extra");

function refReplacer() {
	const m = new Map();
	const v = new Map();
	let init = null;

	return function(field, value) {
		const p = m.get(this) + (Array.isArray(this) ? `[${field}]` : '.' + field); 
		const isComplex = value === Object(value)

		if (isComplex)
			m.set(value, p);  

		const pp = v.get(value) || '';
		const path = p.replace(/undefined\.\.?/,'');
		const val = pp ? `#REF:${pp[0]=='[' ? '$':'$.'}${pp}` : value;

		if(!init)
			init = value
		else if(val === init)
			val = "#REF:$"
		// !init ? (init = value) : (val === init ? val="#REF:$" : 0);

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

module.exports = {
	refReplacer,
	writeJson,
};