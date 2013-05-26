[
	either system/version/platform = 'macosx [
		if value? 'libc [
			free :libc
		]
		free :tanh
		libc: tanh: none
		libc: load/library %/usr/lib/libc.dylib
		tanh: make routine! [libc "tanh" [[real!] double] double real!]
	][
		either system/version/platform = 'win32 [
			if value? 'msvcrt [
				free :msvcrt
			]
			free :tanh
			msvcrt: tanh: none
			msvcrt: load/library %msvcrt.dll
			tanh: make routine! [msvcrt "tanh" [[real!] double] double real!]
		][
		]
	]
	0.9051482536448664 == tanh 1.5
]
