const asInt = x => Math.floor(x);

const itemAt = (arr, i) => arr[asInt(i)];


module.exports = {
	// Full transforms
	binaryOp: type => ([lhs, , op, , rhs]) => ({
		type,
		op,
		lhs,
		rhs,
	}),
	unaryOp: type => ([op, expr]) => ({
		type,
		op,
		expr,
	}),
	value: x => () => x,
	mapFirst: fn => arr => itemAt(arr, 0).map(fn),
	mapSecond: fn => arr => itemAt(arr, 1).map(fn),

	// Partial transforms
	at: i => arr => itemAt(arr, i),
	id: arr => arr,
	first: arr => itemAt(arr, 0),
	second: arr => itemAt(arr, 1),
	last: arr => itemAt(arr, arr.length - 1),
	mid: arr => itemAt(arr, arr.length / 2),
	beforeMid: arr => itemAt(arr, arr.length / 2 - 1),
	afterMid: arr => itemAt(arr, arr.length / 2 + 1),
	beforeLast: arr => itemAt(arr, arr.length - 2),
};
