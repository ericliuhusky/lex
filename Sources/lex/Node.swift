//
//  Node.swift
//  
//
//  Created by lzh on 2022/6/16.
//

fileprivate class StateIDGenerator {
    private var id = 0
    func generateId() -> Int {
        id += 1
        return id
    }
}

class Node {
    private static let idGenerator = StateIDGenerator()
    
    let id = idGenerator.generateId()
    var left: Node?
    var right: Node?
    let char: Character?
    
    init(char: Character? = nil) {
        left = nil
        right = nil
        self.char = char
    }
}
