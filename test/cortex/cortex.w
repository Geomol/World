; Control
[f: func [/local count] [count: "" loop 1 [insert count "0"] count = "0"] f]

; Math
[0.0 = (e - exp 1)]
[-1 = negate 1]
[false = not true]
[true = not false]
[true = not none]
[1.4142135623730951 = sqrt 2]
[true = zero? 0]
[true = zero? 0.0]

; Port, File and IO
[0 = length? load "^@"]
[1 = length? load/all "^@"]

; Series
[[0 0 3] = change copy [1 2 3] [0 0]]

; Strings
["Hello, World!" = to string! debase enbase "Hello, World!"]
