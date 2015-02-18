World [
	Title:	"Complex Mandelbrot"
	Author:	"John Niclasen"
]

if value? 'iterate [
	free :iterate
	free :mandelbrot
]

;BAILOUT: 4.0
;MAX_ITERATIONS: 1000

iterate: func [
	c
	/local z n
][
	z: 0i
	n: 0
	
	;while [MAX_ITERATIONS >= next 'n] [
	while [1000 >= next 'n] [
	;for n 1 1000 1 [
		z: z * z + c
		;if BAILOUT < abs z [
		if 4.0 < abs z [
			return n
		]
	]
]

mandelbrot: func [
	"This is the mandelbrot function"
	/local t
][
	t: now/time/precise
	for y -59 18 1 [
		for x -39 38 1 [
			;prin either iterate x * 1i + y / 40 [" "] ['*]
			prin either iterate x * 1i + y / 40 [#" "] [#"*"]
		]
		prin newline
	]
	print ["Time Elapsed:" now/time/precise - t]
]

mandelbrot
