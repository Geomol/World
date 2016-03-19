World [
	Title:	"World/cortex TCP client/server test"
	Author:	"John Niclasen"
]

;*** TCP test ***
if value? 'server [
	free :server
	free :client
	free :quit-server
]


server: task [/local cmd p][
	lp: open tcp://:8080
	while [p: read lp] [
		l: to integer! first read/part p 1
		cmd: as string! read/part p l
		print ["server:" l cmd]
		switch cmd [
			"quit" [
				close p
				break
			]
			"time" [
				a: form now/time
				write p to char! length? a
				write p a
			]
		]
		wait 1
		close p
	]
	close lp
]


client: task [][
	p: open tcp://127.0.0.1:8080
	write p to char! 4
	write p "time"
	l: to integer! first read/part p 1
	answer: as string! read/part p l
	print ["client:" l answer]
	wait 1
	close p
]


quit-server: has [p] [
	p: open tcp://127.0.0.1:8080
	write p to char! 4
	write p "quit"
	close p
]


server
wait 1
client
