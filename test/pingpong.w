World [
	Title:	"Ping/Pong task examples"
	Author:	"John Niclasen"
]

ping: task [
	"Ping"
][
	while [true] [
		prin "ping "
		wait 0
	]
]

pong: task [
	"Pong"
][
	while [true] [
		prin "pong "
		wait 0
	]
]

ping
pong

;(
ping: task [
	"Ping"
][
	loop 100 [
		prin "ping "
	]
]

pong: task [
	"Pong"
][
	loop 100 [
		prin "pong "
	]
]

ping
pong
)

comment {
ping: task [
][
	loop 10 [
		wait 'message
		receive
		prin "ping "
		send id2 true
	]
]

pong: task [
][
	loop 10 [
		send id1 true
		wait 'message
		receive
		prin "pong "
	]
]

id1: ping
id2: pong
}

