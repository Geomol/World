[b: [2 4 6] b/2 == 4]
[b: [2 4 6] b/2-3 == [4 6]]
[b: [2 4 6] b/(4) == 6]
[b: [2 4 6] a: 3 b/:a == 6]
[
	c: make context! [
		b: [2 4 6]
		a: 3
		f: does [b/:a == 6]
	]
	all [
		block! == type? c/('b)
		c/f
	]
]
[b: [2 4 6] a: 4 b/(a) == 6]
[b: [a 4 6] b/a == 4]
[b: [5-May-2013] b/1/day == 5]
[b: [1 2 3] f: does [1] b/(f) == 2]
[lit-path! == type? pick ['a/b/c] 1]
[path! == type? 'a/b/c]
