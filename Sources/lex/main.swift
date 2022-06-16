/*
 并运算：[a-z]|[A-Z] "A"
 连接运算：[a-z][A-Z] "aA"
 闭包运算：[a-z]*
 正闭包运算：[a-z]+
 */
// (a|b)*abb
// ab|*a.b.b.



let nfa = NFA(suffix: "ab|")
nfa.get(char: "a")
nfa.get(char: "c")
print(nfa.isMatch)
