module.exports = {
	// Full transforms
	binaryOp: type => ([lhs, , , rhs]) => ({
		type,
		lhs,
		rhs,
	}),
	unaryOp: type => ([op, expr]) => ({
		type,
		expr,
	}),
	value: x => () => x,

	// Partial transforms
	at: i => arr => arr[i],
	id: arr => arr,
	first: arr => arr[0],
	second: arr => arr[1],
	last: arr => arr[arr.length - 1],
	mid: arr => arr[arr.length / 2],
	beforeMid: arr => arr[arr.length / 2 - 1],
	afterMid: arr => arr[arr.length / 2 + 1],
	beforeLast: arr => arr[arr.length - 2],
};