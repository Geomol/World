World [
	Title:	"map function"
	Author:	"John Niclasen"
]

map: make function! [[
	"Applies function to successive sets of arguments."
	[retain]
	function	[any-function!]
	series	[series!]
	/local series' result spec len todo i
][
	series': copy/shallow series
	result: make type? series' length? series'
	spec: pick :function 1
	len: 0
	while [all [0 < length? spec refinement! <> type? spec/1]] [
		if find [word! lit-word!] type? spec/1 [
			len: len + 1
		]
		next' spec
	]
	todo: insert clear [] 'function
	while [0 < length? series'] [
		either operator! = type? :function [
			insert todo series'/1
			append todo series'/2
			append result do todo
			remove todo
			back' remove next' todo
		][
			i: 1
			while [i <= len] [
				append todo series'/:i
				i: i + 1
			]
			append result do todo
			back' clear next' todo
		]
		skip' series' len
	]
	result
]]
