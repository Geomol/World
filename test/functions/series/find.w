["cd" == find "abcd" "c"]
[a: skip "abcd" 2 "cd" == find/any a "?"]
["cd" == find/match "abcd" "ab"]
[[2] == find/match [1 2] 1]
[[2] == find/match [1 2] [1]]
[[2] == find/match [1 2] integer!]
["cd" == find/last "abcdabcd" "c"]
[a: skip "abcd" 4 "cd" == find/reverse a "c"]
["cd" == find/any/last "abcdabcd" "c?"]
[a: skip "abcd" 4 "cd" == find/any/reverse a "?d"]
[[2 3 4] = find [1 2 3 4] [2 3]]
[none == find [1 [2 3] 4] [2 3]]
[[[2 3] 4] == find/only [1 [2 3] 4] [2 3]]
[(reduce [datatype!]) == find/last reduce [datatype!] datatype!]

["cd" == find'/match "abcd" "ab"]

[
	a: make bitset! "0123456789"
	b: "1e12M_Sun"
	find'/last b a
	next' b
	"M_Sun" == b
]
