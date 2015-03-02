World [
	Title:	"Reflect function"
	Author:	"John Niclasen"
]


reflect: make function! [[
	"Returns specific details about a datatype."
	value	[any-function!]
	field	[word! issue!]	"spec, body, args, #args, words, title"
	/local spec blk
][
	switch field [
		spec [copy/shallow pick :value 1]
		body [copy/shallow pick :value 2]
		args [
			blk: make block! 2
			spec: copy/shallow pick :value 1
			while [all [0 < length? spec refinement! <> type? spec/1]] [
				if find [word! lit-word!] type? spec/1 [
					append blk spec/1
				]
				next' spec
			]
			blk
		]
		#args [pick :value 3]
		words [
			blk: make block! 2
			spec: copy/shallow pick :value 1
			while [0 < length? spec] [
				if find [word! lit-word! refinement!] type? spec/1 [
					append blk spec/1
				]
				next' spec
			]
			blk
		]
		title [
			spec: pick :value 1
			if string! = type? spec/1 [copy spec/1]
		]
	]
]]


