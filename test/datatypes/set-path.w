[b: [2 4 6] b/2: 3 b/2 == 3]
[b: [2 4 [6 8]] b/(3)/1: 3 b/3/1 == 3]
[b: [2 4 6] a: 3 b/:a: 3 b/3 == 3]
[b: [2 4 6] a: 3 b/(a): 3 b/3 == 3]
[b: next' "abc" b/-1: #"d" "dbc" == head b]
[b: [2 4 [6 8]] a: 3 b/(a)/1: 3 b/3/1 == 3]
[b: [a 4 6] b/a == 4]
[b: [5-May-2013] b/1/day == 5]
[b: [a 2 3] f: does [1] b/(f) == 'a]
[
if value? 'c [	; c is used as extern context in e.g. %datatypes/path.w
	free c
	c: none
]
	c: make context! [
		b: [2 4 6]
		a: 0
		f: make function! [[] [b/:a == 6]]
	]
	all [
		block! == type? c/b
		block! == type? c/('b)
		3 == c/a: 3
		c/f
	]
]
