World [
	Title:	"World/cortex tests"
	Author:	"John Niclasen"
]

do-tests: make function! [[
	file [file! string!]
	/local tests a b f
][
	tests: load file
	while [0 < length? tests] [
		if true <> do tests/1 [
			print ["Failed:" mold tests/1]
		]
		next 'tests
	]
]]

do-tests %datatypes/unset.w
do-tests %datatypes/none.w
do-tests %datatypes/logic.w
do-tests %datatypes/integer.w
do-tests %datatypes/binary.w
do-tests %datatypes/tag.w
do-tests %datatypes/routine.w
do-tests %datatypes/port.w

do-tests %math/unary-minus.w
do-tests %math/paren.w

do-tests %functions/function.w
do-tests %functions/control/all.w
do-tests %functions/control/try.w
do-tests %functions/datatype/to.w
do-tests %functions/math/round.w
do-tests %functions/series/copy.w
do-tests %functions/series/parse.w
do-tests %functions/series/remove.w
do-tests %functions/series/trim.w
do-tests %functions/system/compile.w

do-tests %cortex/cortex.w

true
