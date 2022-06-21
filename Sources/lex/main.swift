/*
 并运算：[a-z]|[A-Z] "A"
 连接运算：[a-z][A-Z] "aA"
 闭包运算：[a-z]*
 正闭包运算：[a-z]+
 */
// (a|b)*abb
// ab|*a.b.b.



let nfa = NFA(regex: "a|b")
let nfa2 = NFA(regex: "cd")

let nfa3 = nfa.union(nfa2)
nfa3.reset()
for c in "bcd" {
    nfa3.get(char: c) { state in
        if state == nfa.acceptState {
            print("nfa")
            nfa3.reset()
        } else if state == nfa2.acceptState {
            print("nfa2")
            nfa3.reset()
        }
    }
}
