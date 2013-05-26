[a: open tcp://:8080 close a port! == type? a]
[
	a: make port! %datatypes/dummy-script.w
	open a
	b: as string! copy/part a 5
	close a
	b == "World"
]
