World [
	Title:	"is operator"
	Author:	"John Niclasen"
]

is: make operator! [[
	"Check if value is series"
	value
	series [datatype! typeset! series!]
][
	either datatype? series [
		series = type? :value
	][
		either typeset? series [
			find series type? :value
		][
			either series? series [
				find series :value
			][
				:value = :series
			]
		]
	]
]]
