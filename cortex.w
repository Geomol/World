World [
	Title:		"Cortex Preferences"
	Date:		11-Dec-2011
	Version:	0.5.12
	History: [
		0.5.12	[11-12-2011	JN	{Added compile/reset to append}]
		0.5.11	[10-12-2011	JN	{Added sys-utils}]
		0.5.10	[05-12-2011	JN	{Added routine! to help}]
		0.5.9	[02-12-2011	JN	{Added license
								 Removed compile from loop
								 Added min
								 Added reverse
								 Fixed bug in parse
								 Changed does
								 Added has}]
		0.5.8	[28-11-2011	JN	{Added dump-obj
								 Removed call-by-word from head, tail, sort, trim,
									lower- and uppercase}]
		0.5.7	[27-11-2011	JN	{Added time (the same as dt)}]
		0.5.6	[26-11-2011	JN	{Added /lines to trim
								 Changed foreach}]
		0.5.5	[25-11-2011	JN	{Added repeat
								 Added after
								 Added before
								 Added form
								 Added sort}]
		0.5.4	[24-11-2011	JN	{Added support for many datatypes in the rules for string parsing}]
		0.5.3	[23-11-2011	JN	{Made get-token inline in parse}]
		0.5.2	[22-11-2011	JN	{Added tag!
								 Added issue!}]
		0.5.1	[21-11-2011	JN	{Added percent!
								 Added foreach}]
		0.5.0	[18-11-2011	JN	{Added net-utils}]
		0.4.10	[14-11-2011	JN	{Fixed bug in parse}]
		0.4.9	[11-11-2011	JN	{Added result to until}]
		0.4.8	[10-11-2011	JN	{Made back native}]
		0.4.7	[9-11-2011	JN	{Added parse
								 Added max}]
		0.4.6	[7-11-2011	JN	{Added binary! to any-string!}]
		0.4.5	[3-11-2011	JN	{Changed for}]
		0.4.4	[2-11-2011	JN	{Added bitset}]
		0.4.3	[31-10-2011	JN	{Added url!
								 Added port!
								 Added any-object!}]
		0.4.2	[27-10-2011	JN	{Added default help to help}]
		0.4.1	[25-10-2011	JN	{Added integer!, char! and call-by-word to back
								 Added call-by-word to head and tail}]
		0.4.0	[18-10-2011	JN	{Added native
								 Added native-op
								 Added operator}]
		0.3.8	[03-10-2011	JN	{Added special attributes to help}]
		0.3.7	[18-09-2011	JN	{Added time! to number argument in negate}]
		0.3.6	[15-09-2011	JN	{Removed cos, sin and tan, as they're now natives
								 Added arccos, arcsin and arctan}]
		0.3.5	[14-09-2011	JN	{Added [throw] to some functions}]
		0.3.4	[22-08-2011	JN	{Fixed bug in switch}]
		0.3.3	[18-07-2011	JN	{Added on and off}]
		0.3.2	[11-07-2011	JN	{Added vocal test to help
								 Added switch}]
		0.3.1	[04-06-2011	JN	{Added log
								 Made comment native}]
		0.3.0	[30-05-2011	JN	{Added descriptions
								 Moved none, true and false to state.c}]
		0.2.0	[24-05-2011	JN	{Added help}]
		0.1.3	[16-05-2011	JN	{Added math and series functions}]
		0.1.2	[14-04-2010	JN	{Added mold to probe}]
		0.1.1	[06-03-2010	JN	{Removed zero}]
		0.1.0	[03-03-2010	JN	{Added func, does}]
		0.0.7	[01-03-2010	JN	{Added !}]
		0.0.6	[25-02-2010	JN	{Added probe}]
		0.0.5	[22-02-2010	JN	{Added negate}]
		0.0.4	[19-02-2010	JN	{Added sqrt}]
		0.0.3	[18-02-2010	JN	{Removed true?. Added comment}]
		0.0.2	[17-02-2010	JN	{Added none, not, zero, zero?, true?, exp}]
		0.0.1	[16-02-2010	JN	{Created Added false, true, e, pi}]
	]
]

prin "Loading Cortex... "

license: make function! [[
	"Prints the World/Cortex license agreement."
][
	print system/license
]]

off:	make logic!	0
on:		make logic!	1

any-block!:		make typeset! [block! paren! path! set-path! get-path! lit-path!]
any-function!:	make typeset! [operator! function! routine!]
any-object!:	make typeset! [context! error! port!]
any-paren!:		make typeset! [paren!]
any-path!:		make typeset! [path! set-path! get-path! lit-path!]
any-string!:	make typeset! [string! binary! file! url! tag! issue!]
any-type!:		make typeset! [unset! none! logic! integer! real! complex! percent! char! range! time! date! string! binary! file! url! tag! issue! block! paren! path! set-path! get-path! lit-path! datatype! typeset! word! set-word! get-word! lit-word! refinement! operator! function! routine! context! library! error! port! KWATZ!]
any-word!:		make typeset! [word! set-word! get-word! lit-word! refinement!]
number!:		make typeset! [integer! real! complex! percent!]
scalar!:		make typeset! [integer! real! complex! percent! char! range! tuple! time!]
series!:		make typeset! [string! binary! file! url! tag! issue! block! paren! path! set-path! get-path! lit-path!]

comment {
system/schemes: make system/schemes [
	http: make system/standard/socket-scheme [
		title:	"HyperText Transport Protocol v1.1"
	]
	tcp: make system/standard/socket-scheme [
		title:	"TCP Networking"
	]
]
}

e:			2.718281828459045
pi:			3.141592653589793

null:		#"^@"
esc:		#"^["
bs:			#"^H"
cr:			#"^M"
lf:			#"^/"
newline:	#"^/"
newpage:	#"^L"
tab:		#"^-"
slash:		#"/"
backslash:	#"\"

crlf:		"^M^/"

; Comparison
same?: make function! [[
	"True if the values are identical."
	value1
	value2
][
	:value1 =? :value2
]]
equal?: make function! [[
	"True if the values are equal."
	value1
	value2
][
	:value1 = :value2
]]
strict-equal?: make function! [[
	"True if the values are equal and of the same datatype."
	value1
	value2
][
	:value1 == :value2
]]
not-equal?: make function! [[
	"True if the values are not equal."
	value1
	value2
][
	:value1 <> :value2
]]
greater?: make function! [[
	"True if the first value is greater than the second."
	value1
	value2
][
	:value1 > :value2
]]
lesser?: make function! [[
	"True if the first value is less than the second."
	value1
	value2
][
	:value1 < :value2
]]
greater-or-equal?: make function! [[
	"True if the first value is greater than or equal the second."
	value1
	value2
][
	:value1 >= :value2
]]
lesser-or-equal?: make function! [[
	"True if the first value is less than or equal the second."
	value1
	value2
][
	:value1 <= :value2
]]

; Context
context: make function! [[
	"Define a unique, underived context."
	[throw]
	block [block!] "Context variables and values."
][
	make context! block
]]

; Control
does: make function! [[
	"Defines a function that has no arguments."
	body [block!] "The body block of the function."
][
	;make function! reduce [[] body]
	make function! back insert/only remove next [[]] body
]]
for: make function! [[
	"Evaluates a block over a range of values."
	[throw]
	'word [word!] "Variable to hold current value"
	start [integer! real! percent! char!] "Starting value"
	end [integer! real! percent! char!] "Ending value"
	bump [integer! real! percent! char!] "Amount to skip each time"
	body [block!] "Block to evaluate each time"
	/local do-body
][
	do-body: make function! reduce [reduce [[throw] word] body]
	start: start - bump
	either bump < 0 [
		while [end <= start: start + bump] [
			do-body start
		]
	][
		while [end >= start: start + bump] [
			do-body start
		]
	]
]]
foreach: make function! [[
	"Evaluates a block for each value(s) in a series."
	[throw]
	'word [word! block!] "Word or block or words to set each time"
	data [series!] "Series to traverse"
	body [block!] "Block to evaluate each time"
	/local do-body spec
][
	if 0 < length? data [
		spec: [[throw] data /local]
		append spec :word
		either block! = type? word [
			insert body reduce [word 'data]
			;insert body 'set/local		; TODO Gives wrong result!
			insert body [set/local]
			do-body: make function! reduce [spec body]
			either (length? word) < length? data [
				do-body data
				while [0 < length? data: skip data length? word] [
					do-body data
				]
			][
				do-body data
			]
		][
			insert body reduce [to set-word! word 'data]
			do-body: make function! reduce [spec body]
			either 1 = length? data [
				do-body data/1
			][
				do-body data/1
				while [0 < length? next 'data] [
					do-body data/1
				]
			]
		]
	]
]]
func: make function! [[
	"Defines a function with given spec and body."
	spec [block!] {"Description" followed by arguments (opt type and string)}
	body [block!] "The body block of the function"
][
	make function! reduce [spec body]
]]
has: make function! [[
	"Defines a function that has local variables but no arguments."
	locals [block!]
	body [block!] "The body block of the function."
][
	;make function! reduce [insert insert clear [] locals /local body]
	make function! insert/only
		insert/only remove/part [] 2 body
			insert insert clear [] locals /local
]]
loop: make function! [[
	"Evaluates a block a specified number of times."
	[throw]
	count [integer!] "Number of repetitions"
	block [block!] "Block to evaluate each time"
][
	;if false = compiled? block [
		;compile/at block 'loop
		;compile/at block block
		;compile block
	;]
	while [0 <= count: count - 1] block
]]
native: make function! [[
	"Defines a native function with given spec and native code."
	spec [block!] {"Description" followed by arguments (opt type and string)}
	nc [integer!] "Native code specifying the native function"
][
	make function! reduce [spec nc]
]]
native-op: make function! [[
	"Defines a native operator with given spec and native code."
	spec [block!] {"Description" followed by exactly two arguments (opt type and string)}
	nc [integer!] "Native code specifying the native operator"
][
	make operator! reduce [spec nc]
]]
operator: make function! [[
	"Defines an operator with given spec and body."
	spec [block!] {"Description" followed by exactly two arguments (opt type and string)}
	body [block!] "The body block of the operator"
][
	make operator! reduce [spec body]
]]
q: :quit
repeat: make function! [[
	"Evaluates a block a number of times."
	[throw]
	'word [word!] "Word to set each time"
	value [integer!] "Maximum number"
	body [block!] "Block to evaluate each time"
	/local do-body start
][
	do-body: make function! reduce [reduce [[throw] word] body]
	start: 0
	while [value > start] [
		start: start + 1
		do-body start
	]
]]
switch: make function! [[
	"Selects a choice and evaluates the block that follows it."
	[throw]
	value "Value to search for"
	cases [block!] "Block of cases to search"
	/default
		case "Default case if no others are found"
	/local to-do
][
	either datatype! = type? value [
		to-do: find cases datatype!
		if to-do [
			to-do: find to-do value
			while [all [none! <> type? to-do value <> to-do/1]] [
				to-do: find next to-do datatype!
				if to-do [to-do: find to-do value]
			]
		]
	][
		to-do: find cases value
	]
	if to-do [
		to-do: find next to-do block!
		while [all [none! <> type? to-do block! <> type? to-do/1]] [
			to-do: find next to-do block!
		]
	]
	either to-do [
		do to-do/1
	][
		if default [do case]
	]
]]
until: make function! [[
	"Evaluates a block until it is true."
	[throw]
	block [block!]
	/local result
][
	while [not result: do block] []
	result
]]

; Datatype
; TODO Doesn't work:
;unset?:			make function! [["True for unset values." value][unset! = type? value]]
none?:			make function! [["True for none values." value][none! = type? :value]]
logic?:			make function! [["True for logic value." value][logic! = type? :value]]
integer?:		make function! [["True for integer values." value][integer! = type? :value]]
real?:			make function! [["True for real values." value][real! = type? :value]]
complex?:		make function! [["True for complex values." value][complex! = type? :value]]
percent?:		make function! [["True for percent values." value][percent! = type? :value]]
char?:			make function! [["True for char values." value][char! = type? :value]]
time?:			make function! [["True for time values." value][time! = type? :value]]
date?:			make function! [["True for date values." value][date! = type? :value]]
binary?:		make function! [["True for binary values." value][binary! = type? :value]]
string?:		make function! [["True for string values." value][string! = type? :value]]
file?:			make function! [["True for file values." value][file! = type? :value]]
url?:			make function! [["True for url values." value][url! = type? :value]]
tag?:			make function! [["True for tag values." value][tag! = type? :value]]
issue?:			make function! [["True for issue values." value][issue! = type? :value]]
block?:			make function! [["True for block values." value][block! = type? :value]]
paren?:			make function! [["True for paren values." value][paren! = type? :value]]
path?:			make function! [["True for path values." value][path! = type? :value]]
set-path?:		make function! [["True for set-path values." value][set-path! = type? :value]]
get-path?:		make function! [["True for get-path values." value][get-path! = type? :value]]
lit-path?:		make function! [["True for lit-path values." value][lit-path! = type? :value]]
datatype?:		make function! [["True for datatype values." value][datatype! = type? :value]]
typeset?:		make function! [["True for typeset values." value][typeset! = type? :value]]
word?:			make function! [["True for word values." value][word! = type? :value]]
set-word?:		make function! [["True for set-word values." value][set-word! = type? :value]]
get-word?:		make function! [["True for get-word values." value][get-word! = type? :value]]
lit-word?:		make function! [["True for lit-word values." value][lit-word! = type? :value]]
refinement?:	make function! [["True for refinement values." value][refinement! = type? :value]]
operator?:		make function! [["True for operator values." value][operator! = type? :value]]
function?:		make function! [["True for function values." value][function! = type? :value]]
routine?:		make function! [["True for routine values." value][routine! = type? :value]]
context?:		make function! [["True for context values." value][context! = type? :value]]
error?:			make function! [["True for error values." value][error! = type? :value]]
port?:			make function! [["True for port values." value][port! = type? :value]]
library?:		make function! [["True for library values." value][library! = type? :value]]
KWATZ?:			make function! [["True for KWATZ values." value][KWATZ! = type? :value]]
any-block?:		make function! [["True for any-block values." value][find any-block! type? :value]]
any-function?:	make function! [["True for any-function values." value][find any-function! type? :value]]
any-object?:	make function! [["True for any-object values." value][find any-object! type? :value]]
any-paren?:		make function! [["True for any-paren values." value][find any-paren! type? :value]]
any-path?:		make function! [["True for any-path values." value][find any-path! type? :value]]
any-string?:	make function! [["True for any-string values." value][find any-string! type? :value]]
any-type?:		make function! [["True for any-type values." value][find any-type! type? :value]]
any-word?:		make function! [["True for any-word values." value][find any-word! type? :value]]
number?:		make function! [["True for number values." value][find number! type? :value]]
scalar?:		make function! [["True for scalar values." value][find scalar! type? :value]]
series?:		make function! [["True for series values." value][find series! type? :value]]

; Help
probe: make function! [[
	"Prints a molded value and returns that same value."
	value
][
	print mold :value :value
]]
dump-obj: make function! [[
	{Returns a block of information about an object or port.}
	obj [context! port!]
	/local clip-str str form-val val form-pad out type
][
	words-of: make function! [[
		value
		/local result w
	][
		result: to block! value
		while [0 < length? result] [
			w: to word! result/1
			insert remove/part result 2 w
			next 'result
		]
		head result
	]]
	clip-str: make function! [[str] [
		trim/lines str
		if (length? str) > 45 [str: append copy/part str 45 "..."]
		str
	]]
	form-val: make function! [[val] [
		if any-block? :val [return form reduce ["length:" length? val]]
		;if image? :val [return form reduce ["size:" val/size]]
		;if datatype? :val [return get in spec-of val 'title]
		if any-function? :val [
			either string! = type? first pick :val 1 [
				return clip-str first pick :val 1
			][
				return clip-str mold pick :val 1
			]
		]
		if context? :val [val: words-of val]
		;if typeset? :val [val: to-block val]
		;if port? :val [val: reduce [val/spec/title val/spec/ref]]
		;if gob? :val [return form reduce ["offset:" val/offset "size:" val/size]]
		clip-str mold :val
	]]
	form-pad: make function! [[val size] [
		val: form val
		insert/dup tail val #" " size - length? val
		val
	]]
	out: copy []
	foreach [word val] to block! obj [
		type: type?/word :val
		;str: either find [function! closure! operator! context!] type [
			;form reduce [word mold spec-of :val words-of :val]
		;] [
			;form word
		;]
		str: form-pad word 15
		append str #" "
		append str form-pad type 10 - ((length? str) - 15)
		append out form reduce [
			"  " str
			;if type <> 'unset! [form-val :val]
			form-val :val
			newline
		]
	]
	out
]]
?: help: make function! [[
	"Prints information about words and values."
	'word
	/local value args item arg-no item2 att
][
	if false = value? 'word [
		print {To use help, supply a word or value as its
argument:

	help copy
	help system
	help system/console

Other useful functions:

	source <function> - view source of a function

Other information:

	license - show user license

More information: http://world-lang.org
}
		exit
	]
	if all [word! <> type? :word path! <> type? :word] [
		prin [mold :word "is "]
		print either find "aeiou" first mold type? :word [
			["an" type? :word]
		][
			["a" type? :word]
		]
		exit
	]
	;value: either path? :word [first reduce reduce [word]] [get :word]
	value: get :word
	if false = find any-function! type? :value [
		prin [mold word "is "]
		prin either find "aeiou" first mold type? :value [
			["an" type? :value "of value: "]
		][
			["a" type? :value "of value: "]
		]
		print either context! = type? :value [print "" dump-obj value] [mold :value]
		;print mold :value
		exit
	]
	args: pick :value 1
	prin "Usage:^/    "
	either operator! = type? :value [
		item: args/1
		while [word! <> type? :item] [
			item: pick next 'args 1
		]
		prin [mold :item mold word ""]
		item: pick next 'args 1
		while [word! <> type? :item] [
			item: pick next 'args 1
		]
		prin mold :item
	][
		prin mold word
		item: args/1
		either function! = type? :value [
			while [item and ((:item <> /local) or (string! = type? args/2))] [
				if (string! <> type? :item) and (block! <> type? :item) [
					prin ["" mold :item]
				]
				item: pick next 'args 1
			]
		][	; routine!
			while [word! <> type? :item] [
				item: pick next 'args 1
			]
			args: skip args 2
			item: pick args 1
			if block! = type? :item [
				arg-no: 1
				while [0 < length? item] [
					either word! = type? pick item 1 [
						prin ["" mold pick item 1]
						next 'item
					][
						prin " arg"
						prin arg-no
					]
					next 'arg-no
					item: skip item 2
					if string! = type? pick item 1 [
						next 'item
					]
				]
			]
		]
	]
	args: skip args (- (index? args) - 1)
	item: args/1
	print "^/^/Description:"
	if string! = type? :item [
		print ["   " item]
		item: pick next 'args 1
	]
	prin ["   " mold word "is "]
	print either find "aeiou" first mold type? :value [
		["an" type? :value]
	][
		["a" type? :value]
	]
	either block! = type? :item [
		att: item
		item: pick next 'args 1
	][
		att: none
	]
	either function! = type? :value [
		if find [word! lit-word!] type?/word :item [
			print "^/Arguments:"
			while [item and (refinement! <> type? :item)] [
				prin ["   " item "-- "]
				item: pick next 'args 1
				either item [
					either string! = type? :item [
						prin [item "["]
						item: pick next 'args 1
						either block! = type? :item [
							prin item
							prin "]"
							item: pick next 'args 1
						][
							prin "any-type!]"
						]
					][
						either block! = type? :item [
							item2: pick next 'args 1
							if string! = type? :item2 [
								prin [item2 ""]
								item2: pick next 'args 1
							]
							prin "["
							prin item
							prin "]"
							item: :item2
						][
							prin "[any-type!]"
						]
					]
				][
					prin "[any-type!]"
				]
				print ""
			]
		]
	][
		if routine! = type? :value [
			args: skip args 2
			item: pick args 1
			if block! = type? :item [
				if 0 < length? item [
					print "^/Arguments:"
					arg-no: 1
					while [0 < length? item] [
						either word! = type? pick item 1 [
							prin ["   " item/1 "-- "]
							next 'item
						][
							prin "    arg"
							prin [arg-no "-- "]
						]
						either string! = type? pick item 3 [
							prin [pick item 3 ""]
							print mold pick item 1
							next 'item
						][
							print mold pick item 1
						]
						next 'arg-no
						item: skip item 2
					]
				]
				next 'args
			]
			item: pick args 1
			if item <> 'void [
				item: pick next 'args 1
				print "^/Returns:"
				either :item == none [
					print "    (unknown)"
				][
					print ["   " mold :item]
				]
			]
		]
	]
	if (refinement! = type? :item) and ((item <> /local) or (string! = type? args/2)) [
		print "^/Refinements:"
		while [item and ((item <> /local) or (string! = type? args/2))] [
			prin ["   " mold :item]
			item: pick next 'args 1
			if string! = type? :item [
				prin [" --" item]
				item: pick next 'args 1
			]
			print ""
			if word! = type? :item [
				while [item and (refinement! <> type? :item)] [
					prin ["       " item "-- "]
					item: pick next 'args 1
					either item [
						either string! = type? :item [
							prin [item "["]
							item: pick next 'args 1
							either block! = type? :item [
								prin item
								prin "]"
								item: pick next 'args 1
							][
								prin "any-type!]"
							]
						][
							either block! = type? :item [
								item2: pick next 'args 1
								if string! = type? :item2 [
									prin [item2 ""]
									item2: pick next 'args 1
								]
								prin "["
								prin item
								prin "]"
								item: :item2
							][
								prin "[any-type!]"
							]
						]
					][
						prin "[any-type!]"
					]
					print ""
				]
			]
		]
	]
	if att [
		print "^/Special attributes:"
		item: att/1
		while [item] [
			print ["   " mold :item]
			item: pick next 'att 1
		]
	]
	prin ""
]]
source: make function! [[
	"Prints the source code for a word."
	'word [word!]
][
	prin word
	print either value? word [
		[":" mold get word]
	][
		" undefined"
	]
	exit
]]

; Logic
and': make function! [[
	"First value ANDed with the second."
	value1
	value2
][
	:value1 and :value2
]]
or': make function! [[
	"First value ORed with the second."
	value1
	value2
][
	:value1 or :value2
]]
xor': make function! [[
	"First value XORed with the second."
	value1
	value2
][
	:value1 xor :value2
]]

; Math
arccos: make function! [[
	"Inverse trigonometric cosine in radians."
	value [number!]
	/deg "Returns result in degrees."
][
	either complex! = type? value [
		0.5 * pi + (1i * ln (1i * value + (e ** (0.5 * ln 1 - (value * value)))))
	][
		either deg [
			57.29577951308232 *
				pick 0.5 * pi + (1i * ln (1i * value + (e ** (0.5 * ln 1 - (value * value))))) 1
		][
			pick 0.5 * pi + (1i * ln (1i * value + (e ** (0.5 * ln 1 - (value * value))))) 1
		]
	]
]]
arcsin: make function! [[
	"Inverse trigonometric sine in radians."
	value [number!]
	/deg "Returns result in degrees."
][
	either complex! = type? value [
		-1i * ln (1i * value + (e ** (0.5 * ln 1 - (value * value))))
	][
		either deg [
			57.29577951308232 *
				pick -1i * ln (1i * value + (e ** (0.5 * ln 1 - (value * value)))) 1
		][
			pick -1i * ln (1i * value + (e ** (0.5 * ln 1 - (value * value)))) 1
		]
	]
]]
arctan: make function! [[
	"Inverse trigonometric tangent in radians."
	value [number!]
	/deg "Returns result in degrees."
][
	either complex! = type? value [
		0.5i * ((ln (1 - (1i * value))) - ln 1 + (1i * value))
	][
		either deg [
			57.29577951308232 *
				pick 0.5i * ((ln (1 - (1i * value))) - ln 1 + (1i * value)) 1
		][
			pick 0.5i * ((ln (1 - (1i * value))) - ln 1 + (1i * value)) 1
		]
	]
]]
arg: make function! [[
	"Complex argument"
	z [complex!]
][
	pick ln z 2
]]
cosh: make function! [[
	"Hyperbolic cosine in radians."
	value [number!]
][
	2.718281828459045 ** value + (2.718281828459045 ** - value) / 2.0
]]
exp: make function! [[
	"Raises Euler's number e to the power."
	power [number!]
][
	2.718281828459045 ** power
]]
log: make function! [[
	"Base 10 logarithm."
	value [number!]
][
	(ln value) / ln 10.
]]
max: make function! [[
	"The greater of two values."
	value1
	value2
][
	pick reduce [value1 value2] value1 > value2
]]
min: make function! [[
	"The lesser of two values."
	value1
	value2
][
	pick reduce [value1 value2] value1 < value2
]]
negate: make function! [[
	"Changes the sign of a number."
	number [number! time!]
][
	- number
]]
not: make function! [[
	"Logic complement."
	value "Only false and none return true"
][
	either none = :value or (false = :value) [true][false]
]]
; TODO NB!! random is not final and will most likely become a native function
rseed: 1
random: make function! [[
	"Random value of the same datatype."
	value [integer! real! percent! date!] "Maximum value of result"
	/seed "Restart or randomize"
	/local Y to-do
][
	either seed [
		rseed: to integer! value
	][
		rseed: 16807 * rseed // 2147483647
		Y: rseed - 1 * 2147483646 + (16807 * rseed // 2147483647) / 4611686009837453313
		to-do: find reduce [
			integer! [1 + to integer! Y * value]
			real! [Y * value]
			percent! [Y * value]
		] type? value
		either to-do [
			do to-do/2
		][
			print ["** Error: cannot use random on" type? value "value"]
		]
	]
]]
round: make function! [[
	"Rounds a numeric value. Halves round up (away from zero) by default."
	n [integer! real! percent!] "The value to round"
	/to "Return the nearest multiple of the scale parameter"
	scale [number!] "Must be a non-zero value"
][
	scale: either scale [abs scale][1]
	n: add n scale * pick [-0.5 0.5] n < 0.0
	make type? scale either n < 0.0 [
		n + mod - n scale
	][
		n - mod n scale
	]
]]
sinh: make function! [[
	"Hyperbolic sine in radians."
	value [number!]
][
	2.718281828459045 ** value - (2.718281828459045 ** - value) / 2.0
]]
sqrt: make function! [[
	"Square root of a number."
	value [number!]
][
	value ** .5
]]
tanh: make function! [[
	"Hyperbolic tangent in radians."
	value [number!]
][
	2.718281828459045 ** value - (2.718281828459045 ** - value) /
	(2.718281828459045 ** value + (2.718281828459045 ** - value))
]]
zero?: make function! [[
	"True if a number is zero."
	number [number!]
][
	number = 0	; TODO check type
]]

; Port, File and IO
save: make function! [[
	"Saves to a file"
	where [file!] "Where to save it"
	value "Value to save"
	/local s
][
	either block! = type? value [
		s: clear ""
		while [0 < length? value] [
			insert skip s length? s value/1
			insert skip s length? s #" "
			value: next value
		]
		write where s
	][
		write where mold value
	]
]]
to-world-file: make function! [[
	path [string! file!]
	/local p l
][
	p: to file! path
	if #":" = p/2 [
		poke p 2 p/1
		poke p 1 #"/"
	]
	l: length? p
	while [0 < l] [
		if #"\" = pick p l [
			poke p l #"/"
		]
		l: l - 1
	]
	p
]]

; Series
first: make function! [[
	"First value of a series."
	series [series! complex! function! operator!]
][
	series/1
]]
second: make function! [[
	"Second value of a series."
	series [series! complex! function! operator!]
][
	series/2
]]
third: make function! [[
	"Third value of a series."
	series [series! complex! function! operator!]
][
	series/3
]]
after: make operator! [[
	"The place after a value in a series."
	series [series!]
	value
][
	next find series value
]]
before: make operator! [[
	"The place at a value in a series."
	series [series!]
	value
][
	find series value
]]
from: make operator! [[
	"Finds a value in a series."
	value
	series [series!]
][
	find series value
]]
head: make function! [[
	"The series at its head."
	series [series!]
	/local s
][
	skip series (- (index? series) - 1)
]]
head?: make function! [[
	"True if a series is at its head."
	series [series!]
][
	1 = index? series
]]
join: make function! [[
	"Concatenates values."
	value "Base value"
	rest "Value or block of values"
][
	;value: either series? :value [copy value] [form :value]
	value: either find series! type? :value [copy value] [form :value]
	; head insert tail value reduce :rest
	insert skip value length? value reduce :rest
	value
]]
reverse: make function! [[
	"Reverses a series."
	series [series!]
	/local i j v
][
	i: 1 + to integer! (length? series) / 2
	j: to integer! (length? series) + 3 / 2
	while [0 < i: i - 1] [
		v: pick series i
		poke series i pick series j
		poke series j v
		j: j + 1
	]
	series
]]
;comment [
context [
qsort: make function! [[
	v [series!]
	left [integer!]
	right [integer!]
	/local last i j t u
][
	if left >= right [exit]
	j: to integer! left + right / 2
	t: pick v left
	poke v left pick v j
	poke v j t
	last: left
	i: left + 1
	while [i <= right] [
		t: pick v i
		u: pick v left
		either (type? t) = type? u [
			if t < u [
				next 'last
				u: pick v last
				poke v last t
				poke v i u
			]
		][
			if (type? t) < type? u [
				next 'last
				u: pick v last
				poke v last t
				poke v i u
			]
		]
		next 'i
	]
	t: pick v left
	poke v left pick v last
	poke v last t
	qsort v left last - 1
	qsort v last + 1 right
]]

set 'sort make function! [[
	"Sorts a series."
	series [series!]
][
	qsort series 1 length? series
	series
]]
]	; sort context
;]	; comment
tail: make function! [[
	"The series at the position after the last value."
	series [series!]
	/local s
][
	skip series length? series
]]
empty?: make function! [[
	"True if a series is empty."
	series [series!]
][
	0 = length? skip series (- (index? series) - 1)
]]
tail?: make function! [[
	"True if a series is at its tail."
	series [series!]
][
	0 >= length? series
]]
append: make function! [[
	"Appends a value to the tail of a series."
	series [series!]
	value
	/only "Appends a series as a series"
][
	compile/reset series
	head either only [
		insert/only skip series length? series :value
	][
		insert skip series length? series :value
	]
]]
change: make function! [[
	"Changes a value in a series."
	series [series!] "Series at point to change"
	value "New value"
	/part "Limits the amount to change to a given length or position"
		range [integer! series!]
	/only "Changes a series as a series"
][
	either only [
		insert/only either part [
			remove/part series range
		][
			remove series
		] :value
	][
		insert either part [
			remove/part series range
		][
			remove series
		] :value
	]
]]
clear: make function! [[
	"Removes all values from the current index to the tail."
	series [series! none!]
][
	remove/part series length? series
]]

;comment {
context [
input': none
istack: []
level: 0

bparse: make function! [[
	"Parses a block according to rules."
	input [block!] "Input block to parse"
	rules [block!] "Rules to parse by"
	/case "Uses case-sensitive comparison"
	/local keyword-rules type-rules ;get-token
	i j n keyword token var value dest status mark rules'
][
	rules': rules
	keyword-rules: [
		any [
			until [
				not switch/default type?/word :token type-rules [	; default
					either (case and (token == input'/1))
							or ((not case) and (token = input'/1)) [
						input': next input'
						true
					][
						false
					]
				]
			]
			true
		]
		end [tail? input']
		into [
			either block! = type? input'/1 [
				either block! = type? :token [
					insert/only istack input'
					insert istack level
					level: 0
					status: bparse input'/1 token
					level: istack/1
					remove istack
					input': next istack/1
					remove istack
					status
				][
					make error! join "PARSE - invalid argument: " :token
				]
			][
				false
			]
		]
		opt [
			switch/default type?/word :token type-rules [	; default
				if (case and (token == input'/1))
						or ((not case) and (token = input'/1)) [
					input': next input'
				]
			]
			true
		]
		skip [
			either tail? input' [
				false
			][
				input': next input'
				true
			]
		]
		some [
			if status: switch/default type?/word :token type-rules [	; default
				either (case and (token == input'/1))
						or ((not case) and (token = input'/1)) [
					input': next input'
					true
				][
					false
				]
			] [
				until [
					not switch/default type?/word :token type-rules [	; default
						either (case and (token == input'/1))
								or ((not case) and (token = input'/1)) [
							input': next input'
							true
						][
							false
						]
					]
				]
				status: true
			]
			status
		]
		thru [
			either token = 'end [
				false
			][
				either none = dest: find/only input' token [
					false
				][
					input': next dest
					true
				]
			]
		]
		to [
			either token = 'end [
				input': tail input'
				true
			][
				either none = dest: find/only input' token [
					false
				][
					input': dest
					true
				]
			]
		]
		| [
			rules: none
			true
		]
	]

	type-rules: [
		none! [
			true
		]
		block! [
			bparse input' token
		]
		paren! [
			do token
			true
		]
		datatype! [
			either all [
				find to typeset! token type? input'/1
				not tail? input'
			] [
				input': next input'
				true
			][
				false
			]
		]
	]

	insert/only istack input
	input': input

	level: level + 1
	mark: none

	status: true
	while [all [rules not tail? rules]] [
		i: j: keyword: none
		;get-token
		token: rules/1
		next 'rules
		if word! = type? :token [
			if not find [any copy end into opt set skip some thru to |] token [
				token: get/at token rules'
			]
		]	; get-token end
		switch type?/word :token [
			integer! [
				i: max 0 token
				;get-token
				token: rules/1
				next 'rules
				if word! = type? :token [
					if not find [any copy end into opt set skip some thru to |] token [
						token: get/at token rules'
					]
				]	; get-token end
				switch type?/word :token [
					none! [
						make error! join "PARSE - unexpected end of rule after: " i
					]
					integer! [
						j: token
						;get-token
						token: rules/1
						next 'rules
						if word! = type? :token [
							if not find [any copy end into opt set skip some thru to |] token [
								token: get/at token rules'
							]
						]	; get-token end
						switch type?/word :token [
							none! [
								make error! join "PARSE - unexpected end of rule after: " j
							]
							word! [
								either find [end skip |] token [
									keyword: token
								][
									if find [any into opt some thru to] token [
										keyword: token
										;get-token
										token: rules/1
										next 'rules
										if word! = type? :token [
											if not find [any copy end into opt set skip some thru to |]
													token [
												token: get/at token rules'
											]
										]	; get-token end
									]
								]
							]
						]
					]
					word! [
						either find [end skip |] token [
							keyword: token
						][
							if find [any into opt some thru to] token [
								keyword: token
								;get-token
								token: rules/1
								next 'rules
								if word! = type? :token [
									if not find [any copy end into opt set skip some thru to |] token [
										token: get/at token rules'
									]
								]	; get-token end
							]
						]
					]
				]
			]
			get-word! [
				input': get/at token rules'
			]
			set-word! [
				set/at token input' rules'
			]
			word! [
				switch token [
					any into opt some thru to [
						keyword: token
						;get-token
						token: rules/1
						next 'rules
						if word! = type? :token [
							if not find [any copy end into opt set skip some thru to |] token [
								token: get/at token rules'
							]
						]	; get-token end
					]
					end skip | [keyword: token]
					copy [
						keyword: token
						var: rules/1
						rules: next rules
						if word! <> type? :var [
							make error! join "PARSE - invalid argument: " :var
						]
					]
					set [
						keyword: token
						var: rules/1
						rules: next rules
						if word! <> type? :var [
							make error! join "PARSE - invalid argument: " :var
						]
						;get-token
						token: rules/1
						next 'rules
						if word! = type? :token [
							if not find [any copy end into opt set skip some thru to |] token [
								token: get/at token rules'
							]
						]	; get-token end
					]
				]
			]
		]
		either i [
			either j [
				status: true
				n: i
				while [all [status n > 0]] [
					either keyword [
						status: switch keyword keyword-rules
					][
						status: switch/default type?/word :token type-rules [	; default
							either (case and (token == input'/1))
									or ((not case) and (token = input'/1)) [
								input': next input'
								true
							][
								false
							]
						]
					]
					n: n - 1
				]
				if status [
					n: j - i
					while [all [status n > 0]] [
						either keyword [
							status: switch keyword keyword-rules
						][
							status: switch/default type?/word :token type-rules [	; default
								either (case and (token == input'/1))
										or ((not case) and (token = input'/1)) [
									input': next input'
									true
								][
									false
								]
							]
						]
						n: n - 1
					]
					status: true
				]
			][
				status: true
				while [all [status i > 0]] [
					either keyword [
						status: switch keyword keyword-rules
					][
						status: switch/default type?/word :token type-rules [	; default
							either (case and (token == input'/1))
									or ((not case) and (token = input'/1)) [
								input': next input'
								true
							][
								false
							]
						]
					]
					i: i - 1
				]
			]
		][
			either keyword [
				switch/default keyword [
					copy [
						mark: input'
						status: true
					]
					set [
						value: input'/1
						status: switch/default type?/word :token type-rules [	; default
							either (case and (token == input'/1))
									or ((not case) and (token = input'/1)) [
								input': next input'
								true
							][
								false
							]
						]
						if status [set/at var value rules']
					]
				][
					if any [
						all [
							not find [end skip |] keyword
							word! = type? :token
							find [any copy into opt set some thru to |] :token
						]
						all [
							not find [end thru to] keyword
							:token == 'end
						]
					] [
						make error! join "PARSE - invalid argument: " :token
					]
					status: switch keyword keyword-rules
					if mark [
						if mark <> input' [
							set/at var copy/part mark input' rules'
						]
						mark: none
					]
				]
			][
				either all [
						datatype! <> type? :token
						find [get-word! set-word!] type?/word :token
				] [
					status: true
				][
					status: switch/default type?/word :token type-rules [	; default
						either (case and (token == input'/1))
								or ((not case) and (token = input'/1)) [
							input': next input'
							true
						][
							false
						]
					]
				]
				if mark [
					if mark <> input' [
						set/at var copy/part mark input' rules'
					]
					mark: none
				]
			]
		]
		if not status [
			input': istack/1
			if all [rules rules: find rules '|] [
				if tail? rules: next rules [
					status: true
				]
			]
		]
	]
	remove istack
	level: level - 1
	return either level > 0 [
		status
	][
		status and tail? input'
	]
]]

;
;*** String parsing ***
;
split-string: make function! [[
	string [string!]
	split-by [bitset!]
	/local result mark
][
	result: clear []
	while [all [0 < length? string find split-by string/1]] [next 'string]
	while [0 < length? string] [
		mark: string
		while [all [0 < length? string none = find split-by string/1]] [next 'string]
		insert skip result length? result copy/part mark string
		while [all [0 < length? string find split-by string/1]] [next 'string]
	]
	result
]]

sparse: func [
	"Parses a string according to rules."
	input [string!] "Input string to parse"
	rules [block! none!] "Rules to parse by"
	/all "Parses all chars including spaces"
	/case "Uses case-sensitive comparison"
	/local keyword-rules type-rules ;get-token
	i j n keyword token var dest status mark
	sp rules'
][
	rules': rules
	switch type?/word rules [
		none! [
			split-string input make bitset! "^-^/ ,;"
		]
		string! [
			split-string input make bitset! insert "^-^/ ,;" rules
		]
		block! [
			sp: make bitset! "^-^/ ,;"
			keyword-rules: [
				any [
					until [
						not switch/default type?/word :token type-rules [	; default
							; Skip white space
							if not all [
								while [if not tail? input' [if find sp input'/1 [true]]] [next 'input']
							]
							either (case and (token == copy/part input' length? token))
									or ((not case) and (token = copy/part input' length? token)) [
								input': skip input' length? token
								true
							][
								false
							]
						]
					]
					true
				]
				end [
					; Skip white space
					if not all [
						while [if not tail? input' [if find sp input'/1 [true]]] [next 'input']
					]
					tail? input'
				]
				opt [
					switch/default type?/word :token type-rules [	; default
						; Skip white space
						if not all [
							while [if not tail? input' [if find sp input'/1 [true]]] [next 'input']
						]
						if (case and (token == copy/part input' length? token))
								or ((not case) and (token = copy/part input' length? token)) [
							input': skip input' length? token
						]
					]
					true
				]
				skip [
					either tail? input' [
						false
					][
						next 'input'
						true
					]
				]
				some [
					if status: switch/default type?/word :token type-rules [	; default
						; Skip white space
						if not all [
							while [if not tail? input' [if find sp input'/1 [true]]] [next 'input']
						]
						either (case and (token == copy/part input' length? token))
								or ((not case) and (token = copy/part input' length? token)) [
							input': skip input' length? token
							true
						][
							false
						]
					] [
						until [
							not switch/default type?/word :token type-rules [	; default
								; Skip white space
								if not all [
									while [if not tail? input' [if find sp input'/1 [true]]] [
										next 'input'
									]
								]
								either (case and (token == copy/part input' length? token))
										or ((not case) and (token = copy/part input' length? token)) [
									input': skip input' length? token
									true
								][
									false
								]
							]
						]
						status: true
					]
					status
				]
				thru [
					either token = 'end [
						false
					][
						either none = dest: find input' token [
							false
						][
							input': skip dest length? token
							true
						]
					]
				]
				to [
					either token = 'end [
						input': tail input'
						true
					][
						either none = dest: find input' token [
							false
						][
							input': dest
							true
						]
					]
				]
				| [
					rules: none
					true
				]
			]

			type-rules: [
				none! [
					true
				]
				char! [
					; Skip white space
					if not all [
						while [if not tail? input' [if find sp input'/1 [true]]] [next 'input']
					]
					either token = input'/1 [
						next 'input'
						true
					][
						false
					]
				]
				bitset! [
					; Skip white space
					if not all [
						while [if not tail? input' [if find sp input'/1 [true]]] [next 'input']
					]
					either tail? input' [
						false
					][
						either find token input'/1 [
							next 'input'
							true
						][
							false
						]
					]
				]
				block! [
					either all [
						either case [
							sparse/all/case input' token
						][
							sparse/all input' token
						]
					][
						either case [
							sparse/case input' token
						][
							sparse input' token
						]
					]
				]
				paren! [
					do token
					true
				]
				datatype! [
					make error! join "PARSE - invalid rule: " token
				]
			]

			insert/only istack input
			input': input

			level: level + 1
			mark: none

			status: true
			while [if rules [if not tail? rules [true]]] [
				i: j: keyword: none
				;get-token
				token: rules/1
				next 'rules
				if word! = type? :token [
					if not find [any copy end opt skip some thru to |] token [
						token: get/at token rules'
					]
				]	; get-token end
				switch/default type?/word :token [
					none! char! bitset! block! paren! datatype! []
					integer! [
						i: max 0 token
						;get-token
						token: rules/1
						next 'rules
						if word! = type? :token [
							if not find [any copy end opt skip some thru to |] token [
								token: get/at token rules'
							]
						]	; get-token end
						switch/default type?/word :token [
							none! [
								make error! join "PARSE - unexpected end of rule after: " i
							]
							char! bitset! block! paren! datatype! []
							integer! [
								j: token
								;get-token
								token: rules/1
								next 'rules
								if word! = type? :token [
									if not find [any copy end opt skip some thru to |] token [
										token: get/at token rules'
									]
								]	; get-token end
								switch/default type?/word :token [
									none! [
										make error! join "PARSE - unexpected end of rule after: " j
									]
									char! bitset! block! paren! datatype! []
									word! [
										either find [end skip |] token [
											keyword: token
										][
											if find [any opt some thru to] token [
												keyword: token
												;get-token
												token: rules/1
												next 'rules
												if word! = type? :token [
													if not find [any copy end opt
															skip some thru to |] token [
														token: get/at token rules'
													]
												]	; get-token end
												switch/default type?/word :token [
													none! char! bitset! block! paren! datatype! []
												] [
													mold token
												]
											]
										]
									]
								] [	; default
									token: form :token
								]
							]
							word! [
								either find [end skip |] token [
									keyword: token
								][
									if find [any opt some thru to] token [
										keyword: token
										;get-token
										token: rules/1
										next 'rules
										if word! = type? :token [
											if not find [any copy end opt skip some thru to |] token [
												token: get/at token rules'
											]
										]	; get-token end
										switch/default type?/word :token [
											none! char! bitset! block! paren! datatype! []
										] [
											mold token
										]
									]
								]
							]
						] [	; default
							token: form :token
						]
					]
					word! [
						switch token [
							any opt some thru to [
								keyword: token
								;get-token
								token: rules/1
								next 'rules
								if word! = type? :token [
									if not find [any copy end opt skip some thru to |] token [
										token: get/at token rules'
									]
								]	; get-token end
								switch/default type?/word :token [
									none! char! bitset! block! paren! datatype! []
								] [
									mold token
								]
							]
							end skip | [keyword: token]
							copy [
								keyword: token
								var: rules/1
								next 'rules
								if word! <> type? :var [
									make error! join "PARSE - invalid argument: " :var
								]
							]
						]
					]
					set-word! [
						set/at token input' rules'
					]
					get-word! [
						input': get/at token rules'
					]
				] [	; default
					token: form :token
				]
				either i [
					either j [
						status: true
						n: i
						while [n > 0 and status] [
							either keyword [
								status: switch keyword keyword-rules
							][
								status: switch/default type?/word :token type-rules [	; default
									; Skip white space
									if not all [
										while [if not tail? input' [if find sp input'/1 [true]]] [
											next 'input'
										]
									]
									either (case and (token == copy/part input' length? token))
											or ((not case)
											and (token = copy/part input' length? token)) [
										input': skip input' length? token
										true
									][
										false
									]
								]
							]
							n: n - 1
						]
						if status [
							n: j - i
							while [n > 0 and status] [
								either keyword [
									status: switch keyword keyword-rules
								][
									status: switch/default type?/word :token type-rules [	; default
										; Skip white space
										if not all [
											while [if not tail? input' [if find sp input'/1 [true]]] [
												next 'input'
											]
										]
										either (case and (token == copy/part input' length? token))
												or ((not case)
												and (token = copy/part input' length? token)) [
											input': skip input' length? token
											true
										][
											false
										]
									]
								]
								n: n - 1
							]
							status: true
						]
					][
						status: true
						while [i > 0 and status] [
							either keyword [
								status: switch keyword keyword-rules
							][
								status: switch/default type?/word :token type-rules [	; default
									; Skip white space
									if not all [
										while [if not tail? input' [if find sp input'/1 [true]]] [
											next 'input'
										]
									]
									either (case and (token == copy/part input' length? token))
											or ((not case)
											and (token = copy/part input' length? token)) [
										input': skip input' length? token
										true
									][
										false
									]
								]
							]
							i: i - 1
						]
					]
				][
					either keyword [
						switch/default keyword [
							copy [
								; Skip white space
								if not all [
									while [if not tail? input' [if find sp input'/1 [true]]] [
										next 'input'
									]
								]
								mark: input'
								status: true
							]
						][
							if any [
								if not find [end skip |] keyword [
									if word! = type? :token [
										if find [any copy opt some thru to |] :token [
											true
										]
									]
								]
								if not find [end thru to] keyword [
									if :token == 'end [
										true
									]
								]
							] [
								make error! join "PARSE - invalid argument: " :token
							]
							status: switch keyword keyword-rules
							if mark [
								if mark <> input' [
									set/at var copy/part mark input' rules'
								]
								mark: none
							]
						]
					][
						either (datatype! <> type? :token)
								and find [get-word! set-word!] type?/word :token [
							status: true
						][
							status: switch/default type?/word :token type-rules [	; default
								; Skip white space
								if not all [
									while [if not tail? input' [if find sp input'/1 [true]]] [
										next 'input'
									]
								]
								either (case and (token == copy/part input' length? token))
										or ((not case) and (token = copy/part input' length? token)) [
									input': skip input' length? token
									true
								][
									false
								]
							]
						]
						if mark [
							if mark <> input' [
								set/at var copy/part mark input' rules'
							]
							mark: none
						]
					]
				]
				if not status [
					input': istack/1
					if rules [
						if rules: find rules '| [
							if tail? next 'rules [
								status: true
							]
						]
					]
				]
			]
			; Skip white space
			if not all [
				while [if not tail? input' [if find sp input'/1 [true]]] [next 'input']
			]
			remove istack
			level: level - 1
			return either level > 0 [
				status
			][
				status and tail? input'
			]
		]
	]
]

set 'parse make function! [[
	"Parses a series according to rules."
	input [series!] "Input series to parse"
	rules [block!] "Rules to parse by"
	/all "Parses all chars including spaces"
	/case "Uses case-sensitive comparison"
][
	clear istack
	level: 0

	switch/default type?/word input [
		block! paren! path! [
			either case [
				bparse/case input rules
			][
				bparse input rules
			]
		]
		string! binary! file! url! tag! issue! KWATZ! [
			either all [
				either case [
					sparse/all/case to string! input rules
				][
					sparse/all to string! input rules
				]
			][
				either case [
					sparse/case to string! input rules
				][
					sparse to string! input rules
				]
			]
		]
	] [
		make error! "parse expected input argument of type: series!"
	]
]]
]	; context
;}	; comment

; Sets
bitset: make function! [[
	"Defines a bitset of characters."
	chars [string! block!]
][
	make bitset! chars
]]

; Strings
form: make function! [[
	"Converts a value to a string."
	value "The value to form"
	/local result
][
	switch/default type?/word :value [
		string! [
			value
		]
		block! paren! [
			result: make string! 8
			if 0 < length? value [
				insert result form value/1
				next 'value
				while [0 < length? value] [
					result: skip result length? result	; result: tail result
					insert result " "
					next 'result
					insert result form value/1
					next 'value
				]
			]
			skip result (- (index? result) - 1)		; head result
		]
		binary! tag! path! set-path! get-path! lit-path! [
			mold value
		]
		datatype! [
			result: to string! value
			if #"!" = pick result length? result [
				remove skip result (length? result) - 1
			]
			result
		]
	] [
		to string! value
	]
]]
lowercase: make function! [[
	"Converts string of characters to lowercase."
	string [any-string! char!]
][
	either char! = type? string [
		either string >= #"A" and (string <= #"Z") [
			string + 32
		][
			string
		]
	][
		while [0 < length? string] [
			if string/1 >= #"A" and (string/1 <= #"Z") [
				string/1: string/1 + 32
			]
			string: next string
		]
		head string
	]
]]
trim: make function! [[
	"Removes whitespace from a string. Default removes from head and tail."
	string [any-string!]
	/head "Removes only from the head"
	/tail "Removes only from the tail"
	/lines "Removes all line breaks and extra spaces"
	/local ptr stop
][
	ptr: string
	if tail = none or head [
		while [all [0 < length? ptr find [#" " #"^-" #"^/"] ptr/1]] [
			remove ptr
		]
	]
	if head = none or tail and (0 < length? ptr) [
		ptr: skip ptr -1 + length? ptr
		while [all [(index? ptr) >= index? string 0 < length? ptr find [#" " #"^-" #"^/"] ptr/1]] [
			remove ptr
			back 'ptr
		]
	]
	if lines [
		ptr: string
		while [all [0 < length? ptr find [#" " #"^-" #"^/"] ptr/1]] [
			next 'ptr
		]
		stop: skip string -1 + length? string
		while [all [(index? stop) >= index? ptr find [#" " #"^-" #"^/"] stop/1]] [
			back 'stop
		]
		while [all [(index? ptr) < index? stop 0 < length? ptr]] [
			either find [#" " #"^-" #"^/"] ptr/1 [
				ptr/1: #" "
				next 'ptr
				while [all [0 < length? ptr find [#" " #"^-" #"^/"] ptr/1]] [
					remove ptr
				]
			][
				next 'ptr
			]
		]
	]
	string
]]
uppercase: make function! [[
	"Converts string of characters to uppercase."
	string [any-string! char!]
][
	either char! = type? string [
		either string >= #"a" and (string <= #"z") [
			string - 32
		][
			string
		]
	][
		while [0 < length? string] [
			if string/1 >= #"a" and (string/1 <= #"z") [
				string/1: string/1 - 32
			]
			string: next string
		]
		head string
	]
]]

; System
.: make function! [[][print "Hello, World!"]]
include: make function! [[
	file [file!]
	/local do-file
][
	do-file: copy system/options/path
	insert skip do-file length? do-file %libs/
	insert skip do-file length? do-file file
	do do-file
]]
;comment [
sys-utils: make context! [
	print-last-error: make function! [[
		/local err id
	][
		err: select system/standard/errors system/state/last-error/type
		prin "** "
		prin err/type
		prin ": "
		id: select err system/state/last-error/id
		print either block! = type? id [
			compile/at id system/state/last-error
		][
			id
		]
		prin "** Near: "
		print system/state/last-error/near
	]]
]
;]	; comment

; Additional functionality
;comment [
net-utils: make context! [

URL-Parser: make context! [

scheme: none
user: none
pass: none
host: none
port-id: none
path: none
target: none
tag: none

digit: make bitset! "0123456789"
alpha-num: make bitset! "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
scheme-char: make bitset! "+-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
path-char: make bitset!
	"!$%&'()*+,-.0123456789;=@ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz~"
user-char: make bitset!
	"!$%&'()*+,-.0123456789;=ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz~"

mark: none

url-rules: [scheme-part user-part host-part path-part file-part tag-part]
scheme-part: [copy scheme some scheme-char #":" ["//" | none]]
user-part: [
	copy user [uchars #"@" uchars] [#":" pass-part | none] #"@"
	| copy user uchars [#":" pass-part | none] #"@"
	| none (user: pass: none)
]
pass-part: [copy pass to #"@"]
host-part: [copy host uchars [#":" copy port-id digits | none]]
path-part: [slash copy path path-node | none]
path-node: [pchars slash path-node | none]
file-part: [copy target pchars | none]
tag-part: [#"#" copy tag pchars | none]
uchars: [some user-char | none]
pchars: [some path-char | none]
digits: [1 5 digit]

parse-url: make function! [[
	"Create URL dataset."
	port [port!]
	url [url!]
][
	scheme: none
	user: none
	pass: none
	host: none
	port-id: none
	path: none
	target: none
	tag: none

	if parse/all url url-rules [
		if user [set/at 'user user port]	;port/user: user
		if pass [set/at 'pass pass port]	;port/pass: pass
		if host [set/at 'host host port]	;port/host: host
		if port-id [set/at 'port-id port-id port]	;port/port-id: to integer! port-id
		if path [set/at 'path path port]	;port/path: path
		if target [set/at 'target target port]	;port/target: target
		;if all [set-scheme scheme] [port/scheme: to-word scheme]
		if scheme [set/at 'scheme first load scheme port]	;port/scheme: to word! scheme
		port
	]
]]

]	; URL-Parser

]	; net-utils
;]	; comment

; TODO World doesn't like the next line!? Making some strange mem problems.
;c: make function! [[][do %cortex.w]]
m: make function! [[][do %test/cmandelbrot.w]]
test: make function! [[][do %test/test.w]]
dt: time: make function! [[
	"Time the execution of a block"
	block [block!]
	/local t
][
	t: now/time/precise
	do block
	now/time/precise - t
]]

print "Done"	; To avoid return value

