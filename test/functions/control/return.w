[
	f: make function! [[][1 return 0]]
	tasks/tick 1
	a: f
	tasks/tick 200
	a == 0
]
