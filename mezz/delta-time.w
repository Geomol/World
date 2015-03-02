World [
	Title:	"Delta-time"
	Author:	"John Niclasen"
]

dt: make function! [[
	"Delta-time -- Time the evaluation of a block."
	;[retain]
	block [any-type!] "Normally a block, function, or routine"
	/local t
][
	t: now/time/precise
	do :block
	now/time/precise - t
]]
