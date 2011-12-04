[
	either system/version/platform = "Mac OS X" [
		libc: load/library %/usr/lib/libc.dylib
		tanh: make routine! [libc "tanh" [[real!] double] double real!]
	][
		either system/version/platform = "Win32" [
			msvcrt: load/library %msvcrt.dll
			tanh: make routine! [msvcrt "tanh" [[real!] double] double real!]
		][
		]
	]
	0.9051482536448664 == tanh 1.5
]
