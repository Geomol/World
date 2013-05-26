World [
	Title:		"REBOL Extension"
	Date:		26-May-2013
	Version:	0.0.24
	History: [
		0.0.24	[26-5-2013	JN	{Changed many function defs to use func and pick
								 Freed tan}]
		0.0.23	[26-5-2013	JN	{Added last}]
		0.0.22	[24-5-2013	JN	{Moved detab to cortex.w
								 Added use}]
		0.0.21	[21-2-2012	JN	{Added append
								 Added insert}]
		0.0.20	[16-2-2012	JN	{Changed detab to use append}]
		0.0.19	[13-2-2012	JN	{Added empty?}]
		0.0.18	[12-1-2012	JN	{Added rebol}]
		0.0.17	[19-12-2011	JN	{Added reform
								 Added detab
								 Added entab}]
		0.0.16	[09-12-2011	JN	{Added as-binary
								 Added as-string}]
		0.0.15	[07-12-2011	JN	{Added with}]
		0.0.14	[02-12-2011	JN	{Added maximum
								 Added minimum
								 Added maximum-of
								 Added minimum-of
								 Removed compile from forever
								 Added function}]
		0.0.13	[01-12-2011	JN	{Added to-hex}]
		0.0.12	[27-11-2011	JN	{Added forever}]
		0.0.11	[16-11-2011	JN	{Added many to- functions}]
		0.0.10	[3-11-2011	JN	{Changed native?}]
		0.0.9	[2-11-2011	JN	{Added charset}]
		0.0.8	[30-10-2011	JN	{Added /radians to cosine, sine and tangent}]
		0.0.7	[27-10-2011	JN	{Added colors}]
		0.0.6	[8-8-2011	JN	{Added new-line? and new-line}]
		0.0.5	[28-5-2011	JN	{Added escape, backspace, ! and object!}]
		0.0.4	[24-5-2011	JN	{Added square-root}]
		0.0.3	[17-5-2011	JN	{Added zero}]
		0.0.2	[16-5-2011	JN	{Added some math functions}]
		0.0.1	[8-5-2011	JN	{Created Added repeat}]
	]
]

prin "Loading REBOL Extension... "

rebol: make function! [[
	block [block!]
][
	if block! <> type? block [
		make error! [syntax header]
	]
]]

zero:		0
escape:		#"^["
backspace:	#"^H"
decimal!:	:real!
object!:	:context!
op!:		:operator!

; Colors
aqua:			40.100.130
bar-color:		100.120.100
base-color:		160.180.160
beige:			255.228.196
black:			0.0.0
blue:			0.0.255
brick:			178.34.34
brown:			139.69.19
button-color:	44.80.132
coal:			64.64.64
coffee:			76.26.0
crimson:		220.20.60
cyan:			0.255.255
forest:			0.48.0
gold:			255.205.40
gray:			128.128.128
green:			0.255.0
ivory:			255.255.240
khaki:			179.179.126
leaf:			0.128.0
linen:			250.240.230
magenta:		255.0.255
main-color:		175.155.120
maroon:			128.0.0
mint:			100.136.116
navy:			0.0.128
oldrab:			72.72.16
olive:			128.128.0
orange:			255.150.10
over-color:		44.80.132
papaya:			255.80.37
pewter:			170.170.170
pink:			255.164.200
purple:			128.0.128
reblue:			38.58.108
rebolor:		142.128.110
red:			255.0.0
sienna:			160.82.45
silver:			192.192.192
sky:			164.200.255
snow:			240.240.240
free :tan
tan:			222.184.135
teal:			0.128.128
violet:			72.0.90
water:			80.108.142
wheat:			245.222.129
white:			255.255.255
yello:			255.240.120
yellow:			255.255.0

; Comparison
maximum-of: make function! [[
	"Finds the largest value in a series"
	series [series!] "Series to search"
	/local ptr result
][
	if false = find series! type? series [
		make error! "maximum-of expected series argument of type: series"
	]
	result: ptr: series
	ptr: next ptr
	while [0 < length? ptr] [
		either (type? ptr/1) = type? result/1 [
			if ptr/1 > result/1 [
				result: ptr
			]
		][
			if (type? ptr/1) > type? result/1 [
				result: ptr
			]
		]
		ptr: next ptr
	]
	result
]]
minimum-of: make function! [[
	"Finds the smallest value in a series"
	series [series!] "Series to search"
	/local ptr result
][
	if false = find series! type? series [
		make error! "minimum-of expected series argument of type: series"
	]
	result: ptr: series
	ptr: next ptr
	while [0 < length? ptr] [
		either (type? ptr/1) = type? result/1 [
			if ptr/1 < result/1 [
				result: ptr
			]
		][
			if (type? ptr/1) < type? result/1 [
				result: ptr
			]
		]
		ptr: next ptr
	]
	result
]]
strict-not-equal?: make function! [[
	"True if the values are not equal and not of the same datatype."
	value1
	value2
][
	:value1 <> :value2 and ((type? :value1) <> type? :value2)
]]

; Context
use: make function! [[
	"Defines words local to a block."
	[retain]
	words [block!]
	body [block!]
	/local b
][
	b: to block! words
	forall b [
		poke b 1 to set-word! b/1
	]
	append b reduce ['none 'do body]
	make context! b
]]
with: make function! [[		; Not sure where this came from!?
	"Executes a block at a context"
	obj [context!]
	body [block!]
][
	do compile/at body obj
]]

; Control
forever: make function! [[
    "Evaluates a block endlessly." 
    [throw] 
    body [block!] "Block to evaluate each time"
][
	;if false = compiled? body [
		;compile/at body 'forever
	;]
    while [true] body
]]
function: make function! [[
    "Defines a user function with local words." 
    spec [block!] {Optional help info followed by arg words (and optional type and string)} 
    vars [block!] "List of words that are local to the function" 
    body [block!] "The body block of the function"
][
    make function! insert/only
		insert/only clear [] body
			head insert insert tail copy spec vars /local
]]

; Datatype
as-binary: make function! [[
	"Coerces any type of string into a binary! datatype without copying it."
	string [any-string!]
][
	as binary! string
]]
as-string: make function! [[
	"Coerces any type of string into a string! datatype without copying it."
	string [any-string!]
][
	as string! string
]]
decimal?:	func pick :real? 1 pick :real? 2
op?:		func pick :operator? 1 pick :operator? 2
native?: make function! [[
	"True for native function and operator values."
	value
][
	integer! = type? pick :value 2
]]
to-binary: make function! [[value][to binary! :value]]
to-bitset: make function! [[value][to bitset! :value]]
to-block: make function! [[value][to block! :value]]
to-char: make function! [[value][to char! :value]]
;to-closure: make function! [[value][to closure! :value]]
;to-datatype: make function! [[value][to datatype! :value]]
to-date: make function! [[value][to date! :value]]
to-decimal: make function! [[value][to decimal! :value]]
;to-email: make function! [[value][to email! :value]]
;to-error: make function! [[value][to error! :value]]
to-file: make function! [[value][to file! :value]]
to-function: make function! [[value][make function! reduce [pick value 1 pick value 2]]]
to-get-path: make function! [[value][to get-path! :value]]
to-get-word: make function! [[value][to get-word! :value]]
;to-hash: make function! [[value][to hash! :value]]
;to-image: make function! [[value][to image! :value]]
to-integer: make function! [[value][to integer! :value]]
;to-issue: make function! [[value][to issue! :value]]
to-library: make function! [[value][load/library :value]]
;to-list: make function! [[value][to list! :value]]
to-lit-path: make function! [[value][to lit-path! :value]]
to-lit-word: make function! [[value][to lit-word! :value]]
to-logic: make function! [[value][to logic! :value]]
;to-map: make function! [[value][to map! :value]]
;to-money: make function! [[value][to money! :value]]
to-none: make function! [[value][to none! :value]]
;to-pair: make function! [[value][to pair! :value]]
to-paren: make function! [[value][to paren! :value]]
to-path: make function! [[value][to path! :value]]
;to-port: make function! [[value][to port! :value]]
to-refinement: make function! [[value][to refinement! :value]]
to-set-path: make function! [[value][to set-path! :value]]
to-set-word: make function! [[value][to set-word! :value]]
to-string: make function! [[value][to string! :value]]
;to-tag: make function! [[value][to tag! :value]]
to-time: make function! [[value][to time! :value]]
to-tuple: make function! [[value][to tuple! :value]]
to-typeset: make function! [[value][to typeset! :value]]
to-url: make function! [[value][to url! :value]]
to-word: make function! [[value][to word! :value]]

to-hex: make function! [[
	"Converts an integer to a hex issue!."
	value [integer!] "Value to be converted"
	/size "Specify number of hex digits in result"
		length [integer!]
][
	to issue! either size [
		copy/part skip mold to binary! value 18 - length length
	][
		copy/part skip mold to binary! value 2 16
	]
]]

; Logic
and~: make function! [[
	"First value ANDed with the second."
	value1
	value2
][
	:value1 and :value2
]]
or~: make function! [[
	"First value ORed with the second."
	value1
	value2
][
	:value1 or :value2
]]
xor~: make function! [[
	"First value XORed with the second."
	value1
	value2
][
	:value1 xor :value2
]]

; Math
!:			func pick :not 1 pick :not 2
absolute:	func pick :abs 1 pick :abs 2
cosine:		make function! [[value /radians][
	if and~ radians find [integer! real!] type?/word value [
		value: value * 57.29577951308232
	]
	pick
	(2.718281828459045 ** (value * 0.0174532925199433 * 1i))
	+ (2.718281828459045 ** (value * 0.0174532925199433 * -1i))
	/ 2 1]]
log-10:		make function! [[value][(ln value) / ln 10.]]
log-2:		make function! [[value][(ln value) / ln 2.]]
log-e:		func pick :ln 1 pick :ln 2
maximum:	func pick :max 1 pick :max 2
minimum:	func pick :min 1 pick :min 2
sine:		make function! [[value /radians][
	if and~ radians find [integer! real!] type?/word value [
		value: value * 57.29577951308232
	]
	pick
	(2.718281828459045 ** (value * 0.0174532925199433 * 1i))
	- (2.718281828459045 ** (value * 0.0174532925199433 * -1i))
	/ 2i 1]]
square-root:	func pick :sqrt 1 pick :sqrt 2
tangent:		make function! [[value][
	if and~ radians find [integer! real!] type?/word value [
		value: value * 57.29577951308232
	]
	pick
	(2.718281828459045 ** (value * 0.0174532925199433 * 2i) - 1.)
	/ (2.718281828459045 ** (value * 0.0174532925199433 * 2i) + 1.)
	* -1i 1]]
true?:		make function! [[value][either none = :value or (false = :value) [false][true]]]

; Port, File and IO
comment {
load: make function! [[
	"Loads a file or string."
	source [file! string!]
	/library "Force file to be a dynamic library"
	/all "Also load potential header and KWATZ!"
	/local result
][
	result: either library [
		system/words/load/library source
	][
		either all [
			system/words/load/all source
		][
			system/words/load source
		]
	]
	either 1 = length? result [
		pick result 1
	][
		result
	]
]]
}

; Series
comment {
world_append: :append
append: make function! [[
	"Appends a value to the tail of a series and returns the series head."
	series [series!]
	value
	/only "Appends a series as a series"
][
	skip either only [
		world_append/only series :value
	][
		world_append series :value
	] (- -1 + index? series)
]]
}
free :empty?
empty?:	func pick :tail? 1 pick :tail? 2
world_insert: :insert
insert: make function! [[
	"Inserts a value into a series and returns the series after the insert."
	series [series!]
	value
	/only "Appends a series as a series"
	/dup "Duplicates the insert a specified number of times"
		count [integer!]
	/local n
][
	either dup [
		n: count
		either only [
			while [0 <= count: count - 1] [
				world_insert/only series :value
			]
			skip series n
		][
			while [0 <= count: count - 1] [
				world_insert series :value
			]
			either find series! type? :value [
				skip series n * length? :value
			][
				skip series n
			]
		]
	][
		either only [
			world_insert/only series :value
			next series
		][
			world_insert series :value
			either find series! type? :value [
				skip series length? :value
			][
				next series
			]
		]
	]
]]
last: make function! [[
	"Last value of a series."
	[retain]
	value [series!]
][
	pick tail value -1
]]
new-line?:	func pick :newline? 1 pick :newline? 2
new-line:	func pick :set-newline 1 pick :set-newline 2

; Sets
charset:	func pick :bitset 1 pick :bitset 2

; Strings
entab: make function! [[
	"Converts spaces in a string to tabs. (tab size 4)"
	string [any-string!]
	/size "Specify number of spaces per tab"
		number [integer!]
	/local sp ;mark n
][
	comment {
	mark: find string complement make bitset! " "
	either none! = type? mark [
		while [string/1 = #" "] [remove string]
	][
		n: to integer! (index? mark) - (index? string) / number
		remove/part string mark
		insert/dup string "^-" n
	]
	string
	}
	if none! = type? size [number: 4]
	sp: insert/dup clear "" " " number
	while [sp = copy/part string number] [
		remove/part string number
		insert string "^-"
		string: next string
	]
	while [string/1 = #" "] [remove string]
	;skip string (- -1 + index? string)
	head string
]]
reform: make function! [[
    "Forms a reduced block."
    value "Value to reduce and form"
][
    form reduce :value
]]

print "Done"	; To avoid return value
