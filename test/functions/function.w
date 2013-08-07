[
	f: func [v /local a /ref b] [a: 2 reduce [v local a ref b]]
	(reduce [1 none 2 true 3]) = f/ref 1 3
]

[
	f: func ['v] [v]
	'word = f word
]

[
	f: does [all [true false true]]
	none = f
]

[
	f: does [tail? []]
	true = f
]
;[
	;f: func [v] [f v + 1]
	;error? try [f 0]
;]
