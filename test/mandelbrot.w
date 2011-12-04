World [
	Title:	"Mandelbrot"
	Author:	"John Niclasen"
]

BAILOUT: 16.0
MAX_ITERATIONS: 1000

iterate: func [
	x y
	/local cr ci zi zr i temp zr2 zi2
][

	cr: y - 0.5
	ci: x
	zi: 0.0
	zr: 0.0
	i: 0
	
	while [MAX_ITERATIONS >= i: i + 1] [
		temp: zr * zi
		zr2: zr * zr
		zi2: zi * zi
		zr: zr2 - zi2 + cr
		zi: temp + temp + ci
		if (zi2 + zr2) > BAILOUT [
			return i
		]
	]
	return 0

]

mandelbrot: func [
	/local t y x
][
	t: now/time/precise
	y: -40
	while [38 >= y: y + 1] [
		x: -40
		while [38 >= x: x + 1] [
			either 0 = iterate x / 40 y / 40 [
				prin "*"
			] [
				prin " "
			]
		]
		prin "^/"
	]
	print ["Time Elapsed " now/time/precise - t]
]

mandelbrot
