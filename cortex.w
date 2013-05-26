World [
	Title:		"Cortex Preferences"
	Date:		26-May-2013
	Version:	0.6.12
	History: [
		0.6.12	[26-05-2013	JN	{Added of
								 Removed /deg from arccos, arcsin and arctan
								 Added to-deg
								 Changed include
								 Remove time (was the same as dt)
								 Added block rules to bitset
								 Changed set/at to set/local/at in parsing}]
		0.6.11	[24-05-2013	JN	{Made head and tail native
								 Made negate, not and clear native
								 Changed detab to not use parse
								 Fixed foreach
								 Changed forall
								 Added deg}]
		0.6.10	[14-05-2013	JN	{Moved last-error to system
								 Added detab}]
		0.6.9	[12-05-2013	JN	{Changed source to also take function argument}]
		0.6.8	[10-05-2013	JN	{Added input}]
		0.6.7	[09-05-2013	JN	{Added retain to many functions
								 Added /free and /retain to change}]
		0.6.6	[04-05-2013	JN	{Added columnize to sys-utils
								 Added tab-completion to sys-utils}]
		0.6.5	[01-05-2013	JN	{Added forall}]
		0.6.4	[29-04-2013	JN	{Changed input' to local in parse}]
		0.6.3	[27-04-2013	JN	{Added free-all}]
		0.6.2	[26-04-2013	JN	{Changed random to return percent!
								 Fixed bug in form}]
		0.6.1	[22-04-2013	JN	{Changed head and tail to support word! *** Doesn't work with contexts! ***
								 Changed help, becuase of new memory management}]
		0.6.0	[09-04-2013	JN	{Changed q, because of new memory management}]
		0.5.24	[21-02-2012	JN	{Added copy-series to sys-utils
								 Improved head
								 Removed /local from head and tail}]
		0.5.23	[20-02-2012	JN	{Added mold-series to sys-utils}]
		0.5.22	[19-02-2012	JN	{Rewrote switch because of datatype! <-> word! coercion}]
		0.5.21	[17-02-2012	JN	{Added none! check to empty?
								 Added more?}]
		0.5.20	[16-02-2012	JN	{Removed append, as it's now native }]
		0.5.19	[22-12-2011	JN	{Added check on system/options/quiet}]
		0.5.18	[22-12-2011	JN	{Removed ?? (binding rules)}]
		0.5.17	[19-12-2011	JN	{Added "No information" to help}]
		0.5.16	[17-12-2011	JN	{Changed print of typeset! argument types in help}]
		0.5.15	[15-12-2011	JN	{Added routine
								 Added ??
								 Fixed bug in foreach}]
		0.5.14	[13-12-2011	JN	{Added struct}]
		0.5.13	[12-12-2011	JN	{Added type check to append}]
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

;comment {	; exclude all
if system/options/quiet = false [
	prin "Loading Cortex... "
]

license: make function! [[
	"Print the World/Cortex license agreement."
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
any-type!:		make typeset! [unset! none! logic! integer! real! complex! percent! char! range! time! date! string! binary! file! url! tag! issue! block! paren! path! set-path! get-path! lit-path! datatype! typeset! word! set-word! get-word! lit-word! refinement! operator! function! routine! context! error! port! handle! struct! library! KWATZ!]
any-word!:		make typeset! [word! set-word! get-word! lit-word! refinement!]
number!:		make typeset! [integer! real! complex! percent!]
scalar!:		make typeset! [integer! real! complex! percent! char! range! tuple! time!]
series!:		make typeset! [string! binary! file! url! tag! issue! block! paren! path! set-path! get-path! lit-path! KWATZ!]

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
	[throw retain]	; TODO Thy is throw here?
	block [block!] "Context variables and values."
][
	make context! block
]]

; Control
does: make function! [[
	"Define a function that has no arguments."
	[retain]
	body [block!] "The body block of the function."
][
	make function! reduce [[] body]
	;make function! back insert/only remove next [[]] body
]]
for: make function! [[
	"Evaluate a block over a range of values."
	[throw retain]
	'word [word!] "Variable to hold current value"
	start [integer! real! percent! char!] "Starting value"
	end [integer! real! percent! char!] "Ending value"
	bump [integer! real! percent! char!] "Amount to skip each time"
	body [block!] "Block to evaluate each time"
	/local do-body
][
	do-body: make function! reduce [reduce [[throw retain] word] body]
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
forall: make function! [[
	"Evaluate a block for every value in a series."
	[throw retain]
	'word [word!] "Word set to each position in series"
	body [block!] "Block to evaluate each time"
	/local l result
][
	word: get/at word body
	l: - length? word
	while [any [0 < length? word (skip' word l false)]] [
		result: do body
		next' word
		result
	]
]]
foreach: make function! [[
	"Evaluate a block for each value(s) in a series."
	[throw retain]
	'word [word! block!] "Word or block or words to set each time"
	data [series!] "Series to traverse"
	body [block!] "Block to evaluate each time"
	/local c l body' data' result
][
	if 0 < length? data [
		c: copy [none]
		either block! = type? word [
			l: length? word
			while [l > 0] [
				insert c to set-word! word/:l
				l: l - 1
			]
			c: make context! bind c body
			body': bind copy body c
			l: length? word
			set/local/at word data c
			do body'
			data': copy/shallow data
			while [0 < length? skip' data' l] [
				set/local/at word data' c
				result: do body'
			]
			set/local/at word none c
		][
			insert c to set-word! word
			c: make context! bind c body
			body': bind copy body c
			set/local/at word data/1 c
			do body'
			data': copy/shallow data
			while [0 < length? next' data'] [
				set/local/at word data'/1 c
				result: do body'
			]
			set/local/at word none c
		]
	]
	result
]]
func: make function! [[
	"Define a function with given spec and body."
	[retain]
	spec [block!] {"Description" followed by arguments (opt type and string)}
	body [block!] "The body block of the function"
][
	make function! reduce [spec body]
]]
has: make function! [[
	"Define a function that has local variables but no arguments."
	[retain]
	locals [block!]
	body [block!] "The body block of the function."
][
	;make function! reduce [insert insert clear [] locals /local body]
	;make function! insert/only
		;insert/only remove/part [] 2 body
			;insert insert clear [] locals /local
	;make function! reduce [insert copy locals /local body]
	make function! insert/only
			insert/only copy [] body
			append copy [/local] locals
]]
loop: make function! [[
	"Evaluate a block a specified number of times."
	[throw retain]
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
	"Define a native function with given spec and native code."
	[retain]
	spec [block!] {"Description" followed by arguments (opt type and string)}
	nc [integer!] "Native code specifying the native function"
][
	make function! reduce [spec nc]
]]
native-op: make function! [[
	"Define a native operator with given spec and native code."
	[retain]
	spec [block!] {"Description" followed by exactly two arguments (opt type and string)}
	nc [integer!] "Native code specifying the native operator"
][
	make operator! reduce [spec nc]
]]
operator: make function! [[
	"Define an operator with given spec and body."
	[retain]
	spec [block!] {"Description" followed by exactly two arguments (opt type and string)}
	body [block!] "The body block of the operator"
][
	make operator! reduce [spec body]
]]
;q: :quit
q: make function! reduce [pick :quit 1 pick :quit 2]
repeat: make function! [[
	"Evaluate a block a number of times."
	[throw retain]
	'word [word!] "Word to set each time"
	value [integer!] "Maximum number"
	body [block!] "Block to evaluate each time"
	/local spec do-body start
][
	spec: [[throw retain]]
	append spec word
	do-body: make function! reduce [spec body]
	remove/last spec
	start: 0
	while [value > start] [
		start: start + 1
		do-body start
	]
]]
routine: make function! [[
	"Define a library routine"
	[retain]
	spec [block!] {"Description" followed by library, routine name, arguments and return type}
][
	make routine! spec
]]
struct: make function! [[
	"Define a structure."
	[retain]
	spec [block!] {"Description" followed by datatypes and arguments (opt string)}
	values [block! none! word!] "Initial values"
][
	make struct! reduce [spec values]
]]
switch: make function! [[
	"Select a choice and evaluate the block that follows it."
	[throw retain]
	value "Value to search for"
	cases [block!] "Block of cases to search"
	/default
		case "Default case if no others are found"
	/local to-do
][
	to-do: find cases either datatype! = type? :value [
		to word! value
	][
		:value
	]
	if to-do [
		to-do: find next to-do block!
		while [all [none! <> type? to-do block! <> type? pick to-do 1]] [
			to-do: find next to-do block!
		]
	]
	either to-do [
		do pick to-do 1
	][
		if default [do case]
	]
]]
until: make function! [[
	"Evaluate a block until it is true."
	[throw retain]
	block [block!]
	/local result
][
	while [not result: do block] []
	result
]]

; Datatype
unset?:			make function! [["True for unset values." value][unset! = type? value]]
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
	"Print a molded value and return that same value."
	[retain]
	value
][
	print mold :value :value
]]
dump-obj: make function! [[
	"Return a block of information about an object or port."
	obj [context! error! port!]
	/local words-of clip-str str form-val val form-pad out type
][
	words-of: make function! [[
		[retain]
		value
		/local result w
	][
		result: to block! value
		while [0 < length? result] [
			w: as word! result/1
			insert remove/part result 2 w
			next' result
		]
		head result
	]]
	clip-str: make function! [[[retain] str] [
		trim/lines str
		if (length? str) > 45 [str: append copy/part str 45 "..."]
		str
	]]
	form-val: make function! [[[retain] val] [
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
		if any-object? :val [val: words-of val]
		;if typeset? :val [val: to-block val]
		if port? :val [val: reduce [val/scheme val/ref]]
		;if gob? :val [return form reduce ["offset:" val/offset "size:" val/size]]
		clip-str mold :val
	]]
	form-pad: make function! [[[retain] val size] [
		val: form val
		append/dup val #" " size - length? val
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
help: make function! [[
	"Print information about words and values."
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

More information: http://www.world-lang.org
}
		exit
	]
    if all [word? :word false = value? :word] [
        print ["No information on" mold :word]
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
		print either any-object? :value [print "" dump-obj value] [mold :value]
		exit
	]
	args: pick :value 1
	prin "Usage:^/    "
	either operator! = type? :value [
		item: args/1
		while [word! <> type? :item] [
			item: pick next' args 1
		]
		prin [mold :item mold word ""]
		item: pick next' args 1
		while [word! <> type? :item] [
			item: pick next' args 1
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
				item: pick next' args 1
			]
		][	; routine!
			while [word! <> type? :item] [
				item: pick next' args 1
			]
			skip' args 2
			item: args/1
			if block! = type? :item [
				arg-no: 1
				while [0 < length? item] [
					either word! = type? item/1 [
						prin ["" mold item/1]
						next' item
					][
						prin " arg"
						prin arg-no
					]
					next 'arg-no
					skip' item 2
					if string! = type? item/1 [
						next' item
					]
				]
			]
		]
	]
	head' args
	item: args/1
	print "^/^/Description:"
	if string! = type? :item [
		print ["   " item]
		item: pick next' args 1
	]
	prin ["   " mold word "is "]
	print either find "aeiou" first mold type? :value [
		["an" type? :value]
	][
		["a" type? :value]
	]
	either block! = type? :item [
		att: copy/shallow item
		item: pick next' args 1
	][
		att: none
	]
	either find [operator! function!] type?/word :value [
		if find [word! lit-word!] type?/word :item [
			print "^/Arguments:"
			while [item and (refinement! <> type? :item)] [
				prin ["   " item "-- "]
				item: pick next' args 1
				either item [
					either string! = type? :item [
						prin [item "["]
						item: pick next' args 1
						either block! = type? :item [
							prin form item
							prin "]"
							item: pick next' args 1
						][
							prin "any-type!]"
						]
					][
						either block! = type? :item [
							item2: pick next' args 1
							if string! = type? :item2 [
								prin [item2 ""]
								item2: pick next' args 1
							]
							prin "["
							prin form item
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
			skip' args 2
			item: args/1
			if block! = type? :item [
				if 0 < length? item [
					print "^/Arguments:"
					arg-no: 1
					while [0 < length? item] [
						either word! = type? item/1 [
							prin ["   " item/1 "-- "]
							next' item
						][
							prin "    arg"
							prin [arg-no "-- "]
						]
						either string! = type? item/3 [
							prin [item/3 ""]
							print mold item/1
							next' item
						][
							print mold item/1
						]
						next' arg-no
						skip' item 2
					]
				]
				next' args
			]
			item: args/1
			if item <> 'void [
				item: pick next' args 1
				print "^/Return:"
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
			item: pick next' args 1
			if string! = type? :item [
				prin [" --" item]
				item: pick next' args 1
			]
			print ""
			if word! = type? :item [
				while [item and (refinement! <> type? :item)] [
					prin ["       " item "-- "]
					item: pick next' args 1
					either item [
						either string! = type? :item [
							prin [item "["]
							item: pick next' args 1
							either block! = type? :item [
								prin form item
								prin "]"
								item: pick next' args 1
							][
								prin "any-type!]"
							]
						][
							either block! = type? :item [
								item2: pick next' args 1
								if string! = type? :item2 [
									prin [item2 ""]
									item2: pick next' args 1
								]
								prin "["
								prin form item
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
			item: pick next' att 1
		]
	]
	head' args
	prin ""
]]
?: make function! reduce [pick :help 1 pick :help 2]
comment {
??: make function! [[
    "Print a variable name followed by its molded value. (debugging)"
    'name
	/local s
][
    print either word! = type? :name [
		s: form name
		append s reduce [": " mold name: get :name]	; TODO Why get-word! (?? loop) ?
		s
	][
		mold :name
	] 
    :name
]]
}
source: make function! [[
	"Print the source code for a word."
	'word [word!]
][
	prin :word
	print either value? :word [
		either find [operator! function! routine!] type?/word :word [
			[":" mold :word]
		][
			[":" mold get word]
		]
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
<<: make operator! [[
	"Bitwise shift left."
	data [integer!]
	bits [integer!] "Number of bits to shift"
][
	shift data bits
]]
>>: make operator! [[
	"Bitwise shift right."
	data [integer!]
	bits [integer!] "Number of bits to shift"
][
	shift data (- bits)
]]
arccos: make function! [[
	"Inverse trigonometric cosine in radians."
	value [number!]
][
	either complex! = type? value [
		0.5 * pi + (1i * ln (1i * value + (e ** (0.5 * ln 1 - (value * value)))))
	][
		pick 0.5 * pi + (1i * ln (1i * value + (e ** (0.5 * ln 1 - (value * value))))) 1
	]
]]
arcsin: make function! [[
	"Inverse trigonometric sine in radians."
	value [number!]
][
	either complex! = type? value [
		-1i * ln (1i * value + (e ** (0.5 * ln 1 - (value * value))))
	][
		pick -1i * ln (1i * value + (e ** (0.5 * ln 1 - (value * value)))) 1
	]
]]
arctan: make function! [[
	"Inverse trigonometric tangent in radians."
	value [number!]
][
	either complex! = type? value [
		0.5i * ((ln (1 - (1i * value))) - ln 1 + (1i * value))
	][
		pick 0.5i * ((ln (1 - (1i * value))) - ln 1 + (1i * value)) 1
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
deg: make function! [[
	"Convert degrees to radians."
	value [number!]
][
	value * 0.017453292519943296	; pi / 180
]]
exp: make function! [[
	"Raise Euler's number e to the power."
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
	;pick reduce [value1 value2] value1 > value2
	if :value1 > :value2 [return :value1] :value2
]]
min: make function! [[
	"The lesser of two values."
	value1
	value2
][
	;pick reduce [value1 value2] value1 < value2
	if :value1 < :value2 [return :value1] :value2
]]
; TODO NB!! random is not final and will most likely become a native function
rseed: 1
random: make function! [[
	"Random value of the same datatype."
	[retain]
	value [integer! real! percent! date!] "Maximum value of result"
	/seed "Restart or randomize"
	/local Y to-do
][
	either seed [
		rseed: to integer! value
	][
		rseed: 16807 * rseed // 2147483647
		Y: rseed - 1 * 2147483646 + (16807 * rseed // 2147483647) / 4611686009837453313
		to-do: find [
			integer! [1 + to integer! Y * value]
			real! [value * Y]
			percent! [value * Y]
		] type?/word value
		either to-do [
			do to-do/2
		][
			print ["** Error: cannot use random on" type? value "value"]
		]
	]
]]
round: make function! [[
	"Round a numeric value. Halves round up (away from zero) by default."
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
to-deg: make function! [[
	"Convert radians to degrees."
	value [number!]
][
	value * 57.29577951308232	; 180 / pi
]]
zero?: make function! [[
	"True if a number is zero."
	number [number!]
][
	:number = 0	; TODO check type ?
]]

; Port, File and IO
input: make function! [[
	"Inputs a string from the console."
	[retain]
	/prompt string [string!]
	/local s line
][
	s: copy system/console/prompt
	clear system/console/prompt
	if prompt [
		prin insert system/console/prompt string
	]
	line: trim/lines as string! read system/ports/input
	insert clear system/console/prompt s
	line
]]
save: make function! [[
	"Save to a file"
	[retain]
	where [file!] "Where to save it"
	value "Value to save"
	/local s
][
	either block! = type? :value [
		value: copy/shallow value
		s: clear ""
		while [0 < length? value] [
			append s value/1
			append s #" "
			next' value
		]
		write where s
	][
		write where mold :value
	]
]]
to-world-file: make function! [[
	path [string! file!]
	/local p l
][
	p: as file! path
	if #":" = pick p 2 [
		poke p 2 pick p 1
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
	series [series! complex! operator! function! routine!]
][
	pick :series 1
]]
second: make function! [[
	"Second value of a series."
	series [series! complex! operator! function!]
][
	pick :series 2
]]
third: make function! [[
	"Third value of a series."
	series [series!]
][
	pick :series 3
]]
after: make operator! [[
	"The place after a value in a series."
	series [series!]
	value
][
	next find series :value
]]
before: make operator! [[
	"The place at a value in a series."
	series [series!]
	value
][
	find series :value
]]
from: make operator! [[
	"Find a value in a series."
	value
	series [series!]
][
	find series :value
]]
head?: make function! [[
	"True if a series is at its head."
	series [series!]
][
	1 = index? series
]]
join: make function! [[
	"Concatenate values."
	[retain]
	value "Base value"
	rest "Value or block of values"
][
	;value: either series? :value [copy value] [form :value]
	value: either find series! type? :value [copy value] [form :value]
	; head insert tail value reduce :rest
	append value reduce :rest
	;value
]]
of: make operator! [[
	"Value at the specified position in a component or series."
	index "Index offset, symbol, or other value to use as index"
	aggregate [series! complex! time! date! bitset! tuple! any-function! context! port! struct!]
][
	pick :aggregate index
]]
reverse: make function! [[
	"Reverse a series."
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
sort: make function! [[
	"Sort a series."
	series [series!]
][
	sys-utils/qsort series 1 length? series
	series
]]
empty?: make function! [[
	"True if a series is empty."
	[retain]
	series [series! none!]
][
	if none! = type? series [return true]
	0 = length? head series
]]
more?: make function! [[
	"True if a series isn't at its tail."
	series [series! none!]
][
	if none! = type? series [return false]
	0 < length? series
]]
tail?: make function! [[
	"True if a series is at its tail."
	series [series!]
][
	0 >= length? series
]]
change: make function! [[
	"Change a value in a series."
	[retain]
	series [series!] "Series at point to change"
	value "New value"
	/part "Limit the amount to change to a given length or position"
		range [integer! series!]
	/only "Change a series as a series"
	/free "Free the old value"
	/retain "Retain the new value"
][
	either only [
		either retain [
			insert/only/retain either part [
				either free [
					remove/part/free series range
				][
					remove/part series range
				]
			][
				either free [
					remove/free series
				][
					remove series
				]
			] :value
		][
			insert/only either part [
				either free [
					remove/part/free series range
				][
					remove/part series range
				]
			][
				either free [
					remove/free series
				][
					remove series
				]
			] :value
		]
	][
		either retain [
			insert/retain either part [
				either free [
					remove/part/free series range
				][
					remove/part series range
				]
			][
				either free [
					remove/free series
				][
					remove series
				]
			] :value
		][
			insert either part [
				either free [
					remove/part/free series range
				][
					remove/part series range
				]
			][
				either free [
					remove/free series
				][
					remove series
				]
			] :value
		]
	]
]]

parse-utils: make context! [
istack: []
level: 0

bparse: make function! [[
	"Parse a block according to rules."
	input [block!] "Input block to parse"
	rules [block!] "Rules to parse by"
	/case "Use case-sensitive comparison"
	/local keyword-rules type-rules ;get-token
	i j n keyword token var value dest status mark rules'
][
	rules':	copy/shallow rules
	keyword-rules: [
		any [
			until [
				not switch/default type?/word :token type-rules [	; default
					either (case and (token == input/1))
							or ((not case) and (token = input/1)) [
						next' input
						true
					][
						false
					]
				]
			]
			true
		]
		end [tail? input]
		into [
			either block! = type? input/1 [
				either block! = type? :token [
					insert/only istack input
					insert istack level
					level: 0
					insert/only istack input/1
					status: bparse input/1 token
					level: istack/1
					remove istack
					if status [
						input: istack/1
						next' input
					]
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
				if (case and (token == input/1))
						or ((not case) and (token = input/1)) [
					next' input
				]
			]
			true
		]
		skip [
			either tail? input [
				false
			][
				next' input
				true
			]
		]
		some [
			if status: switch/default type?/word :token type-rules [	; default
				either (case and (token == input/1))
						or ((not case) and (token = input/1)) [
					next' input
					true
				][
					false
				]
			] [
				until [
					not switch/default type?/word :token type-rules [	; default
						either (case and (token == input/1))
								or ((not case) and (token = input/1)) [
							next' input
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
				either none = dest: find/only input token [
					false
				][
					;input next dest
					skip' input 1 + (index? dest) - index? input
					true
				]
			]
		]
		to [
			either token = 'end [
				tail' input
				true
			][
				either none = dest: find/only input token [
					false
				][
					;input: dest
					skip' input (index? dest) - index? input
					true
				]
			]
		]
		| [
			rules': none
			true
		]
	]

	type-rules: [
		none! [
			true
		]
		block! [
			insert/only istack input
			either bparse copy/shallow input token [
				input: istack/1
				remove istack
				true
			][
				false
			]
		]
		paren! [
			do token
			true
		]
		datatype! [
			either all [
				find to typeset! token type? input/1
				not tail? input
			] [
				next' input
				true
			][
				false
			]
		]
	]

	;input: skip input 0
	;insert/only istack skip input 0
	;insert/only istack copy/shallow input

	level: level + 1
	mark: none

	status: true
	while [all [rules' not tail? rules']] [
		i: j: keyword: none
		;get-token
		token: rules'/1
		next' rules'
		if word! = type? :token [
			if not find [any copy end into opt set skip some thru to |] token [
				token: get/at token rules
			]
		]	; get-token end
		switch type?/word :token [
			integer! [
				i: max 0 token
				;get-token
				token: rules'/1
				next' rules'
				if word! = type? :token [
					if not find [any copy end into opt set skip some thru to |] token [
						token: get/at token rules
					]
				]	; get-token end
				switch type?/word :token [
					none! [
						make error! join "PARSE - unexpected end of rule after: " i
					]
					integer! [
						j: token
						;get-token
						token: rules'/1
						next' rules'
						if word! = type? :token [
							if not find [any copy end into opt set skip some thru to |] token [
								token: get/at token rules
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
										token: rules'/1
										next' rules'
										if word! = type? :token [
											if not find [any copy end into opt set skip some thru to |]
													token [
												token: get/at token rules
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
								token: rules'/1
								next' rules'
								if word! = type? :token [
									if not find [any copy end into opt set skip some thru to |] token [
										token: get/at token rules
									]
								]	; get-token end
							]
						]
					]
				]
			]
			get-word! [
				input: get/at token rules
			]
			set-word! [
				set/local/at token input rules
			]
			word! [
				switch token [
					any into opt some thru to [
						keyword: token
						;get-token
						token: rules'/1
						next' rules'
						if word! = type? :token [
							if not find [any copy end into opt set skip some thru to |] token [
								token: get/at token rules
							]
						]	; get-token end
					]
					end skip | [keyword: token]
					copy [
						keyword: token
						var: rules'/1
						next' rules'
						if word! <> type? :var [
							make error! join "PARSE - invalid argument: " :var
						]
					]
					set [
						keyword: token
						var: rules'/1
						next' rules'
						if word! <> type? :var [
							make error! join "PARSE - invalid argument: " :var
						]
						;get-token
						token: rules'/1
						next' rules'
						if word! = type? :token [
							if not find [any copy end into opt set skip some thru to |] token [
								token: get/at token rules
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
							either (case and (token == input/1))
									or ((not case) and (token = input/1)) [
								next' input
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
								either (case and (token == input/1))
										or ((not case) and (token = input/1)) [
									next' input
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
							either (case and (token == input/1))
									or ((not case) and (token = input/1)) [
								next' input
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
						mark: copy/shallow input
						status: true
					]
					set [
						value: copy/shallow input/1
						status: switch/default type?/word :token type-rules [	; default
							either (case and (token == input/1))
									or ((not case) and (token = input/1)) [
								next' input
								true
							][
								false
							]
						]
						if status [set/local/at var value rules]
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
						;if mark <> input
						if mark =? input = false [
							set/local/at var copy/part mark input rules
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
						either (case and (token == input/1))
								or ((not case) and (token = input/1)) [
							next' input
							true
						][
							false
						]
					]
				]
				if mark [
					;if mark <> input
					if mark =? input = false [
						set/local/at var copy/part mark input rules
					]
					mark: none
				]
			]
		]
		if not status [
			input: copy/shallow istack/1
			if all [rules' rules': find rules' '|] [
				if tail? next' rules' [
					status: true
				]
			]
		]
	]
	level: level - 1
	either level > 0 [
		either status [
			dest: istack/1
			skip' dest (index? input) - index? dest
		][
			remove istack
		]
		return status
	][
		remove istack
		either status and tail? input [
			return true
		][
			return false
		]
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
	;result: clear []
	result: copy []
	while [all [0 < length? string find split-by string/1]] [
		append result copy ""
		next' string
	]
	while [0 < length? string] [
		mark: copy/shallow string
		while [all [0 < length? string none = find split-by string/1]] [next' string]
		append result copy/part mark string
		next' string
		while [all [0 < length? string find split-by string/1]] [
			append result copy ""
			next' string
		]
	]
	if find split-by string/-1 [
		append result copy ""
	]
	result
]]

sparse: make function! [[
	"Parse a string according to rules."
	[retain]
	input [string!] "Input string to parse"
	rules [block! string! none!] "Rules to parse by"
	/all "Parse all chars including spaces"
	/case "Use case-sensitive comparison"
	/local keyword-rules type-rules ;get-token
	i j n keyword token var dest status mark
	sp rules'
][
	rules': either none! = type? rules [
		none
	][
		copy/shallow rules
	]
	switch type?/word rules' [
		none! [
			remove istack
			split-string input make bitset! either all ["^/"] ["^-^/ ,;"]
		]
		string! [
			remove istack
			split-string input make bitset! insert either all ["^/"] ["^-^/ ,;"] rules'
		]
		block! [
			sp: make bitset! "^-^/ ,;"
			keyword-rules: [
				any [
					until [
						not switch/default type?/word :token type-rules [	; default
							; Skip white space
							if not all [
								while [if not tail? input [if find sp input/1 [true]]] [next' input]
							]
							either (case and (token == copy/part input length? token))
									or ((not case) and (token = copy/part input length? token)) [
								skip' input length? token
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
						while [if not tail? input [if find sp input/1 [true]]] [next' input]
					]
					tail? input
				]
				opt [
					switch/default type?/word :token type-rules [	; default
						; Skip white space
						if not all [
							while [if not tail? input [if find sp input/1 [true]]] [next' input]
						]
						if (case and (token == copy/part input length? token))
								or ((not case) and (token = copy/part input length? token)) [
							skip' input length? token
						]
					]
					true
				]
				skip [
					either tail? input [
						false
					][
						next' input
						true
					]
				]
				some [
					if status: switch/default type?/word :token type-rules [	; default
						; Skip white space
						if not all [
							while [if not tail? input [if find sp input/1 [true]]] [next' input]
						]
						either (case and (token == copy/part input length? token))
								or ((not case) and (token = copy/part input length? token)) [
							skip' input length? token
							true
						][
							false
						]
					] [
						until [
							not switch/default type?/word :token type-rules [	; default
								; Skip white space
								if not all [
									while [if not tail? input [if find sp input/1 [true]]] [
										next' input
									]
								]
								either (case and (token == copy/part input length? token))
										or ((not case) and (token = copy/part input length? token)) [
									skip' input length? token
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
						either none = dest: find input token [
							false
						][
							;input: skip dest length? token
							skip' input (index? dest) - (index? input) + length? token
							true
						]
					]
				]
				to [
					either token = 'end [
						tail' input
						true
					][
						either none = dest: find input token [
							false
						][
							skip' input (index? dest) - index? input
							true
						]
					]
				]
				| [
					rules': none
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
						while [if not tail? input [if find sp input/1 [true]]] [next' input]
					]
					either token = input/1 [
						next' input
						true
					][
						false
					]
				]
				bitset! [
					; Skip white space
					if not all [
						while [if not tail? input [if find sp input/1 [true]]] [next' input]
					]
					either tail? input [
						false
					][
						either find token input/1 [
							next' input
							true
						][
							false
						]
					]
				]
				block! [
					insert istack input
					either all [
						either case [
							either sparse/all/case copy/shallow input token [
								input: istack/1
								remove istack
								true
							][
								false
							]
						][
							either sparse/all copy/shallow input token [
								input: istack/1
								remove istack
								true
							][
								false
							]
						]
					][
						either case [
							either sparse/case copy/shallow input token [
								input: istack/1
								remove istack
								true
							][
								false
							]
						][
							either sparse copy/shallow input token [
								input: istack/1
								remove istack
								true
							][
								false
							]
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

			;input: skip input 0
			;insert/only istack skip input 0
			;insert istack input
			;probe istack

			level: level + 1
			mark: none

			status: true
			while [if rules' [if not tail? rules' [true]]] [
				i: j: keyword: none
				;get-token
				token: rules'/1
				next' rules'
				if word! = type? :token [
					if not find [any copy end opt skip some thru to |] token [
						token: get/at token rules
					]
				]	; get-token end
				switch/default type?/word :token [
					none! char! bitset! block! paren! datatype! []
					integer! [
						i: max 0 token
						;get-token
						token: rules'/1
						next' rules'
						if word! = type? :token [
							if not find [any copy end opt skip some thru to |] token [
								token: get/at token rules
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
								token: rules'/1
								next' rules'
								if word! = type? :token [
									if not find [any copy end opt skip some thru to |] token [
										token: get/at token rules
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
												token: rules'/1
												next' rules'
												if word! = type? :token [
													if not find [any copy end opt
															skip some thru to |] token [
														token: get/at token rules
													]
												]	; get-token end
												switch/default type?/word :token [
													none! char! bitset! block! paren! datatype! []
												] [
													;mold token
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
										token: rules'/1
										next' rules'
										if word! = type? :token [
											if not find [any copy end opt skip some thru to |] token [
												token: get/at token rules
											]
										]	; get-token end
										switch/default type?/word :token [
											none! char! bitset! block! paren! datatype! []
										] [
											;mold token
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
								token: rules'/1
								next' rules'
								if word! = type? :token [
									if not find [any copy end opt skip some thru to |] token [
										token: get/at token rules
									]
								]	; get-token end
								switch/default type?/word :token [
									none! char! bitset! block! paren! datatype! []
								] [
									;mold token
								]
							]
							end skip | [keyword: token]
							copy [
								keyword: token
								var: rules'/1
								next' rules'
								if word! <> type? :var [
									make error! join "PARSE - invalid argument: " :var
								]
							]
						]
					]
					set-word! [
						set/local/at token input rules
					]
					get-word! [
						input: get/at token rules
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
										while [if not tail? input [if find sp input/1 [true]]] [
											next' input
										]
									]
									either (case and (token == copy/part input length? token))
											or ((not case)
											and (token = copy/part input length? token)) [
										skip' input length? token
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
											while [if not tail? input [if find sp input/1 [true]]] [
												next' input
											]
										]
										either (case and (token == copy/part input length? token))
												or ((not case)
												and (token = copy/part input length? token)) [
											skip' input length? token
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
										while [if not tail? input [if find sp input/1 [true]]] [
											next' input
										]
									]
									either (case and (token == copy/part input length? token))
											or ((not case)
											and (token = copy/part input length? token)) [
										skip' input length? token
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
									while [if not tail? input [if find sp input/1 [true]]] [
										next' input
									]
								]
								mark: copy/shallow input
								;mark: retain copy/shallow input
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
								;if mark <> input
								;if not same? mark input
								if mark =? input = false [
									set/local/at var copy/part mark input rules
								]
								;free mark
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
									while [if not tail? input [if find sp input/1 [true]]] [
										next' input
									]
								]
								either (case and (token == copy/part input length? token))
										or ((not case) and (token = copy/part input length? token)) [
									skip' input length? token
									true
								][
									false
								]
							]
						]
						if mark [
							;if mark <> input
							if mark =? input = false [
								set/local/at var copy/part mark input rules
							]
							;free mark
							mark: none
						]
					]
				]
				if not status [
					input: copy/shallow istack/1
					if rules' [
						if rules': find rules' '| [
							if tail? next' rules' [
								status: true
							]
						]
					]
				]
			]
			; Skip white space
			if not all [
				while [if not tail? input [if find sp input/1 [true]]] [next' input]
			]
			;remove istack
			level: level - 1
			either level > 0 [
				either status [
					;insert/only istack copy/shallow input
					dest: istack/1
					skip' dest (index? input) - index? dest
				][
					remove istack
				]
				return status
			][
				remove istack
				either status and tail? input [
					return true
				][
					return false
				]
			]
		]
	]
]]

set 'parse make function! [[
	"Parse a series according to rules."
	[retain]
	input [series!] "Input series to parse"
	rules [block! string! none!] "Rules to parse by"
	/all "Parse all chars including spaces"
	/case "Use case-sensitive comparison"
][
	clear istack
	level: 0

	switch/default type?/word input [
		block! paren! path! [
			insert/only istack copy/shallow input
			either case [
				bparse/case copy/shallow input rules
			][
				bparse copy/shallow input rules
			]
		]
		string! binary! file! url! tag! issue! KWATZ! [
			insert istack to string! input
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

; Sets
bitset: make function! [[
	"Define a bitset of characters."
	[retain]
	chars [string! block!]
	/local result s c1 c2 mark
][
	make bitset! either block! = type? chars [
		result: make string! 32
		parse chars [
			any [
				set s string! (append result s)
				| set c1 char! '- set c2 char! (
					if c1 > c2 [make error! "invalid character range"]
					for c c1 c2 1 [append result c]
				)
				| set c1 char! (append result c1)
			]
			mark: (
				if 0 < length? mark [
					make error! join "invalid argument: " first mark
				]
			)
		]
		result
	][
		chars
	]
]]

; Strings
detab: make function! [[
	"Converts tabs in a string to spaces. (tab size 4)"
	[retain]
	string [any-string!]
	/size "Specify number of spaces per tab"
		number [integer!]
	/local out mark
][
	if none! = type? size [number: 4]
	out: clear ""
	mark: find string "^-"
	while [mark] [
		append out copy/part string mark
		append/dup out " " number
		string: next mark
		mark: find string "^-"
	]
	if string [
		append out string
	]
	out
]]
form: make function! [[
	"Convert a value to a string."
	[retain]
	value "The value to form"
	/local result
][
	switch/default type?/word :value [
		string! [
			;copy/shallow value
			value
		]
		block! paren! [
			result: make string! 8
			if 0 < length? value [
				value: copy/shallow value
				insert result form value/1
				next' value
				while [0 < length? value] [
					tail' result
					insert result " "
					next' result
					insert result form value/1
					next' value
				]
			]
			head' result
		]
		binary! tag! path! set-path! get-path! lit-path! [
			mold value
		]
		datatype! [
			result: to string! value
			if #"!" = pick result length? result [
				remove/last result
			]
			result
		]
	] [
		to string! :value
	]
]]
lowercase: make function! [[
	"Convert string of characters to lowercase."
	string [any-string! char!]
	/local l
][
	either char! = type? string [
		either string >= #"A" and (string <= #"Z") [
			string + 32
		][
			string
		]
	][
		l: - length? string
		while [0 < length? string] [
			if (pick string 1) >= #"A" and ((pick string 1) <= #"Z") [
				poke string 1 32 + pick string 1
			]
			next' string
		]
		skip' string l
	]
]]
trim: make function! [[
	"Remove whitespace from a string. Default removes from head and tail."
	[retain]
	string [any-string!]
	/head "Remove only from the head"
	/tail "Remove only from the tail"
	/lines "Remove all line breaks and extra spaces"
	/local ptr stop
][
	ptr: copy/shallow string
	if tail = none or head [
		while [all [0 < length? ptr find [#" " #"^-" #"^/"] pick ptr 1]] [
			remove ptr
		]
	]
	if head = none or tail and (0 < length? ptr) [
		skip' ptr -1 + length? ptr
		while [all [(index? ptr) >= index? string 0 < length? ptr find [#" " #"^-" #"^/"] pick ptr 1]] [
			remove ptr
			back' ptr
		]
	]
	if lines [
		ptr: copy/shallow string
		while [all [0 < length? ptr find [#" " #"^-" #"^/"] pick ptr 1]] [
			next' ptr
		]
		stop: skip string -1 + length? string
		while [all [(index? stop) >= index? ptr find [#" " #"^-" #"^/"] pick stop 1]] [
			back' stop
		]
		while [all [(index? ptr) < index? stop 0 < length? ptr]] [
			either find [#" " #"^-" #"^/"] pick ptr 1 [
				poke ptr 1 #" "
				next' ptr
				while [all [0 < length? ptr find [#" " #"^-" #"^/"] pick ptr 1]] [
					remove ptr
				]
			][
				next' ptr
			]
		]
	]
	string
]]
uppercase: make function! [[
	"Convert string of characters to uppercase."
	string [any-string! char!]
	/local l
][
	either char! = type? string [
		either string >= #"a" and (string <= #"z") [
			string - 32
		][
			string
		]
	][
		l: - length? string
		while [0 < length? string] [
			if (pick string 1) >= #"a" and ((pick string 1) <= #"z") [
				poke string 1 -32 + pick string 1
			]
			next' string
		]
		skip' string l
	]
]]

; System
.: make function! [[][print "Hello, World!"]]
free-all: make function! [[
	"Free a list of World resources."
	[retain]
	values	[block!] "Block of words"
][
	foreach v values [
		free get/at v values
	]
]]
retain-all: make function! [[
	"Retain a list of World resources."
	[retain]
	values	[block!] "Block of words"
][
	foreach v values [
		retain get/at v values
	]
]]
include: make function! [[
	file [file!]
	/local do-file
][
	do-file: copy system/options/path
	append do-file %libs/
	do append do-file file
]]
;comment [
sys-utils: make context! [

columnize: make function! [[
	[retain]
	data
	/local l ld cols col rows ptr
][
	l: 0
	foreach o data [
		if l < length? o [l: length? o]
	]
	l: l + 8 - (l // 8)
	cols: clear []
	col: to integer! 80 / l
	ld: length? data
	rows: to integer! ld / col
	if ld // col > 0 [
		rows: rows + 1
	]
	while [col - 1 * rows >= ld] [
		col: col - 1
		rows: to integer! ld / col
		if ld // col > 0 [
			rows: rows + 1
		]
	]
	repeat i rows [
		either col - 1 * rows + i > ld [
			append cols col - 1
		][
			append cols col
		]
	]
	ptr: copy/shallow data
	repeat i rows [
		loop pick cols i [
			prin pick data 1
			loop 1 + to integer! l - (1 + length? pick data 1) / 8 [prin #"^-"]
			skip' data rows
		]
		prin #"^/"
		next' ptr
		skip' data (index? ptr) - index? data
	]
]]

copied: []

copy-series: make function! [[
	value [block! paren!]
	/local new match
][
	value: copy/shallow value
	new: make either block! = type? value [block!] [paren!] 4
	insert copied reduce [value new]
	while [0 < length? value] [
		switch/default type?/word pick value 1 [
			block! paren! [
				match: find/only copied pick value 1
				either any [match = none false = same? pick match 1 pick value 1] [
					append/only new copy-series pick value 1
				][
					;append/only new pick value 1
					append/only new pick match 2
				]
			]
		][
			append new pick value 1
		]
		next' value
	]
	remove/part copied 2
	new
]]

molded: []
output: none

mold-block: make function! [[
	block [block!]
	level [integer!]
	/local match
][
	block: copy/shallow block
	insert/only molded block
	append output "["
	either 64 < length? block [
		if newline? block [
			append output "^/"
			loop level + 1 [append output "    "]
		]
		loop 64 [
			switch/default type?/word pick block 1 [
				block! [
					match: find/only molded block/1
					either any [match = none false = same? match/1 block/1] [
						mold-block block/1 level + 1
					][
						append output "[...]"
					]
				]
				paren! [
					match: find/only molded block/1
					either any [match = none false = same? match/1 block/1] [
						mold-paren block/1 level + 1
					][
						append output "(...)"
					]
				]
			][
				append output mold pick block 1
			]
			next' block
			either newline? block [
				append output "^/"
				loop level + 1 [append output "    "]
			][
				append output " "
			]
		]
		append output "..."
	][
		if 0 < length? block [
			if newline? block [
				append output "^/"
				loop level + 1 [append output "    "]
			]
			switch/default type?/word pick block 1 [
				block! [
					match: find/only molded block/1
					either any [match = none false = same? match/1 block/1] [
						mold-block block/1 level + 1
					][
						append output "[...]"
					]
				]
				paren! [
					match: find/only molded block/1
					either any [match = none false = same? match/1 block/1] [
						mold-paren block/1 level + 1
					][
						append output "(...)"
					]
				]
			][
				append output mold pick block 1
			]
			next' block
			while [0 < length? block] [
				either newline? block [
					append output "^/"
					loop level + 1 [append output "    "]
				][
					append output " "
				]
				switch/default type?/word pick block 1 [
					block! [
						match: find/only molded block/1
						either any [match = none false = same? match/1 block/1] [
							mold-block block/1 level + 1
						][
							append output "[...]"
						]
					]
					paren! [
						match: find/only molded block/1
						either any [match = none false = same? match/1 block/1] [
							mold-paren block/1 level + 1
						][
							append output "(...)"
						]
					]
				][
					append output mold pick block 1
				]
				next' block
			]
		]
		if newline? block [
			append output "^/"
			loop level [append output "    "]
		]
		append output "]"
	]
	remove molded
]]

mold-paren: make function! [[
	paren [paren!]
	level [integer!]
	/local match
][
	paren: copy/shallow paren
	insert/only molded paren
	append output "("
	either 64 < length? paren [
		loop 64 [
			switch/default type?/word pick paren 1 [
				block! [
					match: find/only molded paren/1
					either any [match = none false = same? match/1 paren/1] [
						mold-block paren/1 level + 1
					][
						append output "[...]"
					]
				]
				paren! [
					match: find/only molded paren/1
					either any [match = none false = same? match/1 paren/1] [
						mold-paren paren/1 level + 1
					][
						append output "(...)"
					]
				]
			][
				append output mold pick paren 1
			]
			next' paren
			append output " "
		]
		append output "..."
	][
		if 0 < length? paren [
			switch/default type?/word pick paren 1 [
				block! [
					match: find/only molded paren/1
					either any [match = none false = same? match/1 paren/1] [
						mold-block paren/1 level + 1
					][
						append output "[...]"
					]
				]
				paren! [
					match: find/only molded paren/1
					either any [match = none false = same? match/1 paren/1] [
						mold-paren paren/1 level + 1
					][
						append output "(...)"
					]
				]
			][
				append output mold pick paren 1
			]
			next' paren
			while [0 < length? paren] [
				append output " "
				switch/default type?/word pick paren 1 [
					block! [
						match: find/only molded paren/1
						either any [match = none false = same? match/1 paren/1] [
							mold-block paren/1 level + 1
						][
							append output "[...]"
						]
					]
					paren! [
						match: find/only molded paren/1
						either any [match = none false = same? match/1 paren/1] [
							mold-paren paren/1 level + 1
						][
							append output "(...)"
						]
					]
				][
					append output mold pick paren 1
				]
				next' paren
			]
		]
		append output ")"
	]
	remove molded
]]

mold-series: make function! [[
	value [block! paren!]
][
	clear molded
	free output
	output: make string! 2
	switch type?/word value [
		block!	[mold-block value 0]
		paren!	[mold-paren value 0]
	]
	output
]]

print-last-error: make function! [[
	/local err id
][
	err: select system/errors system/last-error/type
	prin "** "
	prin err/type
	prin ": "
	id: select err system/last-error/id
	print either block! = type? id [
		compile/at id system/last-error
	][
		id
	]
	prin "** Near: "
	print system/last-error/near
]]

qsort: make function! [[
	[retain]
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

strncmp: make function! [[
	[retain]
	cs	[any-string!]
	ct	[any-string!]
	n	[integer!]
][
	repeat i n [
		if (pick cs i) <> pick ct i [
			return (to integer! pick cs i) - pick ct i
		]
	]
	return 0
]]

strspn: make function! [[
	[retain]
	cs	[any-string!]
	ct	[any-string!]
][
	repeat i length? cs [
		if (pick cs i) <> pick ct i [
			return i - 1
		]
	]
	return length? cs
]]

tab-completion: make function! [[
	"Console <tab> completion."
	[retain]	; TODO really?
	line	[string!]
	attempt	[integer!]
	/local result values selected end-chars l min-l s loaded	; CANNOT change # of locals (see lex.c)
][
	values: make block! 4
	selected: make block! 4
	end-chars: make bitset! "^@^-^/^M ^"();[]{}"
	l: length? line
	while [all [l > 0 none = find end-chars line/:l]] [
		back 'l
	]
	skip' line l
	loaded: pick load line 1
	either file! = type? loaded [
		either s: find/last loaded #"/" [
			next' s
			values: read copy/part loaded s
		][
			s: loaded
			values: read %./
		]
	][
		either path! = type? loaded [
			s: find/last line #"/"
			values: get pick load copy/part line s 1
			either context! = type? values [
				values: to block! values
				while [0 < length? values] [
					poke values 1 to string! values/1
					next' values
					remove values
				]
				head' values
			][
				values: read %./
				foreach [word val] to block! system/words [
					append values to string! word
				]
			]
			next' s
		][
			s: line
			values: read %./
			foreach [word val] to block! system/words [
				append values to string! word
			]
		]
	]
	l: length? s
	forall values [
		if l <= length? pick values 1 [
			if 0 = strncmp s pick values 1 l [
				append selected pick values 1
			]
		]
	]
	either 0 = length? selected [
		result: ""
	][
		either 1 = length? selected [
			result: skip pick selected 1 l
			append result #" "
		][
			either attempt = 1 [
				min-l: strspn pick selected 1 pick selected 2
				s: pick selected 1
				next' selected
				forall selected [
					min-l: min min-l strspn s pick selected 1
				]
				result: skip copy/part s min-l l
			][
				prin #"^/"
				forall selected [
					if file! = type? pick selected 1 [
						;change selected mold pick selected 1
						poke selected 1 mold pick selected 1
					]
				]
				selected: sort selected
				sys-utils/columnize selected
				head' line
				prin system/console/prompt
				prin line
				result: ""
			]
		]
	]
	return result
]]

]; sys-utils
;]	; comment

; Additional functionality
net-utils: make context! [

URL-Parser: make context! [

scheme: user: pass: host: port-id: path: target: tag: none

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
	;| (free user free pass user: pass: none) copy user uchars [#":" pass-part | none] #"@"
	;| none (free user free pass user: pass: none)
	| copy user uchars [#":" pass-part | none] #"@"
	| none
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
	free-all [scheme user pass host port-id path target tag]
	scheme: user: pass: host: port-id: path: target: tag: none

	if parse/all url url-rules [
		retain-all [scheme user pass host port-id path target tag]
		if user [set/at 'user copy user port]				;port/user: user
		if pass [set/at 'pass copy pass port]				;port/pass: pass
		if host [set/at 'host copy host port]				;port/host: host
		if port-id [set/at 'port-id copy port-id port]		;port/port-id: to integer! port-id
		if path [set/at 'path copy path port]				;port/path: path
		if target [set/at 'target copy target port]			;port/target: target
		;if all [set-scheme scheme] [port/scheme: to-word scheme]
		if scheme [set/at 'scheme first load scheme port]	;port/scheme: to word! scheme
		port
	]
]]

]	; URL-Parser

]	; net-utils

m: make function! [[][do %test/cmandelbrot.w]]
test: make function! [[][do %test/test.w]]
dt: make function! [[
	"Time the execution of a block"
	block [block! function! routine!]
	/local t
][
	t: now/time/precise
	do :block
	now/time/precise - t
]]
do %user.w

if system/options/quiet = false [
	print "Done"
]

;}	; comment
