[b: [2 4 6] b/2 == 4]
[b: [2 4 6] b/2-3 == [4 6]]
[b: [2 4 6] b/(3) == 6]
[b: [2 4 6] a: 3 b/:a == 6]
[
	c: make context! [
		b: [2 4 6]
		a: 3
		f: make function! [[] [b/:a == 6]]
	]
	all [
		block! == type? c/('b)
		c/f
	]
]
[b: [2 4 6] a: 3 b/(a) == 6]
[b: [a 4 6] b/a == 4]
[b: [5-May-2013] b/1/day == 5]
[b: [2 4 6] f: make function! [[] [1]] b/(f) == 2]
[lit-path! == type? pick ['a/b/c] 1]
[path! == type? 'a/b/c]
