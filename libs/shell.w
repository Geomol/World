World [
	Title:	"New Shell based on LIBC"
	Author:	"John Niclasen"
	Purpose: {
		Implement following shell commands:
			cat, cd, co, di, echo, grep, hd, l, ls, more, pwd, run
	}
]


if value? 'shell [exit]


shell: 'world


;
; LIBC routines
;

libc: load-library any [
	if system/version/platform = 'MacOSX [%/usr/lib/libc.dylib]
	if system/version/platform = 'Linux [
		either system/version/variation/3 = 2 [
			%/lib/x86_64-linux-gnu/libc.so.6
		][
			%/lib/i386-linux-gnu/libc.so.6
		]
	]
	if system/version/platform = 'Windows [%msvcrt.dll]
]


either system/version/platform = 'Windows [
getcwd: make routine! [
	'"Get current working directory."
	[typecheck]
	libc "_getcwd" [
		buffer [string!] pointer
		size [integer!] uint64
	]
	pointer string!
]


chdir: make routine! [
	'"Change working directory"
	[typecheck]
	libc "_chdir" [
		filename [string!] pointer
	]
	sint integer!
]
][
getcwd: make routine! [
	'"Get current working directory."
	[typecheck]
	libc "getcwd" [
		buffer [string!] pointer
		size [integer!] uint64
	]
	pointer string!
]


chdir: make routine! [
	'"Change working directory"
	[typecheck]
	libc "chdir" [
		filename [string!] pointer
	]
	sint integer!
]
]


;
; Helper functions
;

dirize: make function! [[
	'"Return a copy of the path turned into a directory."
	path [file! string! url!]
][
	either #"/" <> pick path length? path [append copy path #"/"] [copy path]
]]


; glob still need ** for matching any level of directories
glob: make function! [[
	'"Generate pathnames matching a pattern"
	[retain]
	pattern	[file! path! word! refinement!]
	/local word pathbuf list err glob2 glob3 match
][
glob2: make function! [[
	[retain]
	pathbuf
	pathend
	pattern
	pglob
	/local anymeta p q
][
	anymeta: 0
	; Loop over pattern segments until end of pattern or until
	; segment with meta character found.
	while [true] [
		if pattern = % [	; end of pattern ?
			clear pathend
			if error? try [query pathbuf] [
				return 0
			]
			append pglob copy pathbuf
			return 0
		]
		; Find end of next segment, copy tentatively to pathend.
		if none = p: find pattern "/" [
			p: tail pattern
		]
		append pathend copy/part pattern p
		q: tail pathend
		if any [find pathend #"*" find pathend #"?"] [
			anymeta: 1
		]
		either anymeta = 0 [	; No expansion, do next segment.
			pathend: q
			pattern: p
			while [#"/" = pick pattern 1] [
				;either pathend = % [
					append pathend #"/"
				;][
					;poke pathend 1 #"/"
				;]
				next' pathend
				next' pattern
			]
		][	; Need expansion, recurse.
			return glob3 pathbuf pathend pattern p pglob
		]
	]
	; NOT REACHED
]]


glob3: make function! [[
	[retain]
	pathbuf
	pathend
	pattern
	restpattern
	pglob
	/local dir info err
][
	clear pathend
	either pathbuf = % [
		dir: %./
	][
		dir: pathbuf
	]
	if error? try [info: query dir] [
		return 0
	]
	if info/type <> 'dir [
		return 0
	]
	; Search directory for matching names.
	foreach file read dir [
		if #"/" = last file [remove/last file]
		; Initial DOT must be matched literally.
		if (#"." <> pick file 1) or (#"." = pick pattern 1) [
			append pathend file
			if match copy/shallow pathend copy/shallow pattern copy/shallow restpattern [
				err: glob2 pathbuf tail pathend restpattern pglob
				if err <> 0 [
					return err
				]
			]
			clear pathend
		]
	]
]]


; Pattern matching function for filenames.
; Each occurrence of the * pattern causes a recursion level.
match: make function! [[
	[retain]
	name
	pat
	patend
	/local c
][
	while [(index? pat) < index? patend] [
		c: pick pat 1
		next' pat
		either c = #"*" [
			if (index? pat) = index? patend [
				return true
			]
			if match copy/shallow name copy/shallow pat copy/shallow patend [
				return true
			]
			while [name <> %] [
				next' name
				if match copy/shallow name copy/shallow pat copy/shallow patend [
					return true
				]
			]
			return false
		][
			either c = #"?" [
				if name = % [
					return false
				]
				next' name
			][
				if c <> pick name 1 [
					return false
				]
				next' name
			]
		]
	]
	return name = %
]]


	; The rest of glob
	pattern: any [
		if path! = type? pattern [
			either value? word: pick pattern 1 [
				word: get word
				either (file! = type? word) and (#"/" = pick word length? word) [
					append copy word next pattern
				][
					to file! pattern
				]
			][
				to file! pattern
			]
		]
		if word! = type? pattern [
			to file! either value? pattern [
				get pattern
			][
				pattern
			]
		]
		if refinement! = type? pattern [to file! mold pattern]
		to file! pattern
	]
	list: copy []
	if pattern <> % [
		pathbuf: make file! 1024
		err: glob2 pathbuf pathbuf pattern list
	]
	sort list
]]


split-path: make function! [[
	'"Splits a file or URL path. Returns a block containing path and target."
	[retain]
	target [file! url!]
	/local dir pos
][
	either find [%/ %. %./ %.. %../] target [
		dir: dirize target
		pos: none
	][
		either pos: find/last target "/" [
			either 1 = length? pos [
				either pos: find/reverse pos "/" [
					next 'pos
				][
					pos: target
				]
			][
				next 'pos
			]
		][
			pos: target
		]
		if 0 = length? dir: copy/part target skip target (index? pos) - index? target [
			dir: %./
		]
		if find [%. %..] pos: to file! pos [
			append pos "/"
		]
		if 0 = length? pos [
			pos: none
		]
	]
	reduce [dir pos]
]]


;
; Shell commands
;

cat: make function! [[
	'"Concatenate and print files"
	'file
	/local list info
][
	if false = value? 'file [
		make error! "cat is missing one or more arguments"
	]
	list: glob file
	\{
	if 1 = length? list [
		if error? try [
			query list/1
		] [
			print ['"cat:" list/1 '"-- no such file"]
			exit
		]
	]
	}
	if 0 = length? list [
		print ['"cat:" file '"-- no such file"]
		exit
	]
	foreach file list [
		info: query file
		either info/type = 'dir [
			print ['"cat:" file '"-- is a directory"]
		][
			prin detab read file
		]
	]
	exit
]]


cd: make function! [[
	'"Change the active directory path."
	'dir '"New directory path"
	/local mark
][
	either value? 'dir [
		dir: dirize to file! either refinement! = type? dir [mold dir] [dir]
		if #"/" <> pick dir 1 [
			;insert dir system/script/path
			insert dir dirize to-world-file getcwd none 0
		]
		mark: find next dir #"/"
		while [mark] [
			either all [#"." = pick mark 2 #"/" = pick mark 3] [
				remove/part mark 2
			][
				either all [#"." = pick mark 2 #"." = pick mark 3 #"/" = pick mark 4] [
					remove/part mark 3
					remove/part dir mark
					skip 'mark (index? dir) - index? mark
					dir: find/reverse dir #"/"
				][
					skip 'dir (index? mark) - index? dir
					mark: find next dir #"/"
				]
			]
		]
		;skip 'dir (- -1 + index? dir)
		head' dir
		;free system/script/path
		;system/script/path: dir
	][
		;free system/script/path
		;system/script/path: copy system/options/path
		dir: copy system/options/path
	]
	;chdir to-local-file system/script/path
	;system/script/path
	if 0 <> chdir to-local-file dir [
		print ['"cd:" to-local-file dir '"-- no such directory"]
		exit
	]
	dir
]]


co: make function! [[
	'"Compile a function, operator or block to executable code."
	'source	[function! operator! block!]
	/at '"Choose a context for compilation"
	context [context! word! block!] '"Reference to the target context"
	/reset '"Reset the compile state"
][
	if word! = type? :source [
		source: get source
	]
	either at [
		either reset [
			compile/at/reset :source context
		][
			compile/at :source context
		]
	][
		either reset [
			compile/reset :source
		][
			compile :source
		]
	]
]]


di: make function! [[
	'"Translate a compiled function, operator or block into assembly language."
	'code	[function! operator! block!]
][
	if word! = type? :code [
		code: get code
	]
	disasm :code
]]


echo: make function! [[
	'"Write arguments to the standard output"
	'string
	/local list
][
	print either value? 'string [
		list: glob string
		either 0 = length? list [
			string
		][
			list
		]
	][
		'""
	]
]]


grep: make function! [[
	'"Print lines matching a pattern."
	'pattern
	'file
	/case '"Characters are case-sensitive"
	/l '"List files"
	/local list info name? buf line start end
][
	if (false = value? 'pattern) or (false = value? 'file) [
		make error! "grep is missing one or more arguments"
	]
	pattern: to string! pattern
	list: glob file
	either l [
		foreach file list [
			info: query file
			either info/type = 'dir [
				print ['"grep:" file '"-- is a directory"]
			][
				if either case [find/case read file pattern] [find read file pattern] [
					print file
				]
			]
		]
	][
		name?: 1 < length? list
		foreach file list [
			info: query file
			either info/type = 'dir [
				print ['"grep:" file '"-- is a directory"]
			][
				buf: read file
				while [line: either case [find/case buf pattern] [find buf pattern]] [
					start: find/reverse line #"^/"
					either start = none [
						start: buf
					][
						next 'start
					]
					end: find line #"^/"
					if end = none [end: tail line]
					if name? [prin file prin '":"]
					print detab copy/part start end
					buf: end
				]
			]
		]
	]
	exit
]]


hd: make function! [[
	'"Hexadecimal dump"
	'file
	/local hd' hd-file list info buf i str
][
	if false = value? 'file [
		make error! "hd is missing one or more arguments"
	]
	hd': does [
		if 0 < length? buf [
			i: 0
			while [not do [
				clear str
				append str #"|"
				prin [copy/part skip mold to binary! i 10 8 '""]
				while [not do [
					prin ["" copy/part skip mold to binary! buf/1 2 2]
					append str either buf/1 >= 32 and (buf/1 <= 126) [buf/1] [#"."]
					next' buf
					i: i + 1
					(0 = length? buf) or (i // 8 = 0)
				]] []
				if 0 < length? buf [
					prin '" "
					while [not do [
						prin ["" copy/part skip mold to binary! buf/1 2 2]
						append str either buf/1 >= 32 and (buf/1 <= 126) [buf/1] [#"."]
						next' buf
						i: i + 1
						(0 = length? buf) or (i // 8 = 0)
					]] []
				]
				either i // 16 = 0 [
					prin '"  "
				][
					loop 16 - (i // 16) [
						prin '"   "
					]
					if (i // 16) < 9 [prin '" "]
					prin '"  "
				]
				append str #"|"
				print str
				0 = length? buf
			]] []
			print [copy/part skip mold to binary! i 10 8 '" "]
		]
		true
	]
	hd-file: does [
		list: glob file
		\{
		if 1 = length? list [
			if error? try [
				query list/1
			] [
				print ['"hd:" list/1 '"-- no such file"]
				exit
			]
		]
		}
		if 0 = length? list [
			print ['"hd:" file '"-- no such file"]
			exit
		]
		foreach file list [
			info: query file
			either info/type = 'dir [
				print ['"hd:" file '"-- is a directory"]
			][
				buf: read file
				hd'
			]
		]
		true
	]
	str: make string! 18
	any [
		if word! = type? :file [
			either value? file [
				;buf: to string! get file
				buf: get file
				buf: to string! either find any-context! type? :buf [
					dump-obj buf
				][
					:buf
				]
				hd'
			][
				hd-file
			]
		]
		if find [file! refinement!] type? :file [
			hd-file
		]
		do [
			buf: to string! :file
			hd'
		]
	]
	exit
]]


l: make function! [[
	'"List directory contents in long format."
	'dir-word [any-type!]
	/a	'"List all entries except for . and .."
	/d	'"Directories are listed as plain files (not searched recursively)"
	/local print-file list dirs info max-name s
][
	print-file: make function! [[
		filename
	][
		append/dup s " " max-name - ((length? s) // max-name)
		info: query filename
		either info/type = 'dir [
			append s "           "
		][
			loop 11 - length? to string! info/size [append s " "]
			append s info/size
		]
		append s " "
		if info/date/day < 10 [append s " "]
		append s info/date/day
		append s "-"
		append s copy/part pick system/locale/months info/date/month 3
		append s " "
		either now/date - info/date >= 365 [
			append s " "
			append s info/date/year
		][
			if info/date/time/hour < 10 [append s " "]
			append s info/date/time/hour
			append s ":"
			if info/date/time/minute < 10 [append s "0"]
			append s info/date/time/minute
		]
		print s
		clear s
	]]
	;dir: throw-on-error
	either value? 'dir-word [
		list: glob dir-word
		if 0 = length? list [
			print ['"l:" dir-word '"-- no such file or directory"]
			exit
		]
	][
		list: copy [%./]
	]
	dirs: copy []
	while [0 < length? list] [
		info: query list/1
		either info/type = 'dir [
			either d [
				change list dirize list/1
				next' list
			][
				append dirs dirize list/1
				remove list
			]
		][
			next' list
		]
	]
	;skip 'list (- -1 + index? list)
	head' list
	s: make string! 0
	either (0 = length? list) and (1 = length? dirs) [
		list: sort read dirs/1
		if not a [
			while [all [list/1 #"." = pick list/1 1]] [
				next' list
			]
		]
		max-name: 0
		foreach file list [
			if max-name < length? file [max-name: length? file]
		]
		max-name: max-name + 2
		foreach file list [
			append s file
			print-file append copy dirs/1 file
		]
	][
		max-name: 0
		foreach file list [
			if max-name < length? file [max-name: length? file]
		]
		max-name: max-name + 2
		foreach file list [
			append s file
			print-file file
		]
		foreach dir dirs [
			print [newline dir]
			list: sort read dir
			if not a [
				while [all [list/1 #"." = pick list/1 1]] [
					next' list
				]
			]
			max-name: 0
			foreach file list [
				if max-name < length? file [max-name: length? file]
			]
			max-name: max-name + 2
			foreach file list [
				append s file
				print-file append copy dir file
			]
		]
	]
	exit
]]


ls: make function! [[
	'"List directory contents."
	'dir-word [any-type!]
	/a	'"List all entries except for . and .."
	/d	'"Directories are listed as plain files (not searched recursively)"
	/local list dirs info
][
	;dir: throw-on-error
	either value? 'dir-word [
		list: glob dir-word
		if 0 = length? list [
			print ['"ls:" dir-word '"-- no such file or directory"]
			exit
		]
	][
		list: copy [%./]
	]
	dirs: copy []
	while [0 < length? list] [
		info: query list/1
		either info/type = 'dir [
			either d [
				change list dirize list/1
				next' list
			][
				append dirs dirize list/1
				remove list
			]
		][
			next 'list
		]
	]
	;skip 'list (- -1 + index? list)
	head' list
	either (0 = length? list) and (1 = length? dirs) [
		list: sort read dirs/1
		if not a [
			while [all [list/1 #"." = pick list/1 1]] [
				next 'list
			]
		]
		sys-utils/columnize list
	][
		sys-utils/columnize list
		foreach dir dirs [
			print [newline dir]
			list: sort read dir
			if not a [
				while [all [list/1 #"." = pick list/1 1]] [
					next 'list
				]
			]
			sys-utils/columnize list
		]
	]
	exit
]]


more: make function! [[
	'"Opposite of less."
	'file
	/local list lines a
][
	if false = value? 'file [
		make error! "more is missing one or more arguments"
	]
	list: glob file
	\{
	if 1 = length? list [
		if error? try [
			query list/1
		] [
			print ['"more:" list/1 '"-- no such file"]
			exit
		]
	]
	}
	if 0 = length? list [
		print ['"more:" file '"-- no such file"]
		exit
	]
	foreach file list [
		info: query file
		either info/type = 'dir [
			print ['"more:" file '"-- is a directory"]
		][
			lines: parse-utils/split-string read file make bitset! "^/"
			repeat i min 24 length? lines [
				print detab lines/:i
			]
			skip' lines 24
			if 0 < length? lines [
				a: input/prompt file
				while [a/1 <> #"q" and (0 < length? lines)] [
					repeat i min 24 length? lines [
						print detab lines/:i
					]
					skip' lines 24
					a: input/prompt ":"
				]
			]
		]
	]
	exit
]]


pwd: make function! [[
	'"Return working directory name."
][
	;copy system/script/path
	dirize to-world-file getcwd none 0
]]


run: make function! [[
	'"Run a World script at its location."
	value
	/local d f r
][
	either file! = type? :value [
		d: getcwd none 0
		f: split-path value
		chdir to-local-file f/1
		r: do f/2
		chdir d
		r
	][
		do :value
	]
]]
