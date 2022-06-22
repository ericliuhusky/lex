//
//  NFA.swift
//  
//
//  Created by lzh on 2022/6/16.
//

class NFA {
    private let from: Node
    private var to: Node
    
    private init(from: Node, to: Node) {
        self.from = from
        self.to = to
    }
    
    init(regex: String) {
        let suffix = regex.regexToSuffix()
        var stack = [NFA]()
        for char in suffix {
            switch char {
            case "|":
                let nfa1 = stack.popLast()!
                let nfa2 = stack.popLast()!
                let n1 = Node()
                let n2 = Node()
                n1.left = nfa1.from
                n1.right = nfa2.from
                nfa1.to.left = n2
                nfa2.to.left = n2
                stack.append(NFA(from: n1, to: n2))
            case ".":
                let nfa2 = stack.popLast()!
                let nfa1 = stack.popLast()!
                nfa1.to.left = nfa2.from
                stack.append(NFA(from: nfa1.from, to: nfa2.to))
            case "*":
                let nfa = stack.popLast()!
                let n1 = Node()
                let n2 = Node()
                n1.left = nfa.from
                nfa.to.left = n2
                n1.right = n2
                nfa.to.right = nfa.from
                stack.append(NFA(from: n1, to: n2))
            case "+":
                let nfa = stack.popLast()!
                nfa.to.right = nfa.from
                stack.append(nfa)
            case "?":
                break
            default:
                let n1 = Node(char: char)
                let n2 = Node()
                n1.left = n2
                stack.append(NFA(from: n1, to: n2))
            }
        }
        let nfa = stack.popLast()!
        assert(stack.isEmpty)
        self.from = nfa.from
        self.to = nfa.to
        reset()
    }
    
    private var current: Node?
    private var stop = false
    private func visit(node: Node?, char: Character, block: (Int?) -> Void) {
        if stop { return }
        guard let node = node else { return }
        current = node
        
        block(node.id)
        
        if node.char == nil {
            visit(node: node.left, char: char, block: block)
            visit(node: node.right, char: char, block: block)
        } else if node.char == char {
            visit(node: node.left, char: char, block: block)
        }
    }
    
    func reset() {
        current = from
        stop = true
    }
    
    func get(char: Character, block: (Int?) -> Void) {
        stop = false
        visit(node: current, char: char, block: block)
    }
    
    var isMatch: Bool {
        current?.id == to.id
    }
    
    var acceptState: Int {
        to.id
    }
    
    func union(_ other: NFA) -> NFA {
        let n1 = Node()
        let n2 = Node()
        n1.left = from
        n1.right = other.from
        to.left = n2
        other.to.left = n2
        return NFA(from: n1, to: n2)
    }
}

extension NFA: CustomStringConvertible {
    var description: String {
        return ""
    }
}
