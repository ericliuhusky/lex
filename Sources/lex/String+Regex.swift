//
//  String+Regex.swift
//  
//
//  Created by lzh on 2022/6/21.
//

extension String {
    func regexToSuffix() -> String {
        var suffix = ""
        var verticalBar = 0
        var normalChar = 0
        var parentheses = [(verticalBar: Int, normalChar: Int)]()
        for c in self {
            switch c {
            case "|":
                verticalBar += 1
                normalChar = 0
            case "(":
                parentheses.append((verticalBar, normalChar))
                verticalBar = 0
                normalChar = 0
            case ")":
                (verticalBar, normalChar) = parentheses.popLast()!
                normalChar += 1
            case "*", "+", "?":
                suffix.append(c)
            default:
                suffix.append(c)
                if verticalBar > 0 {
                    verticalBar -= 1
                    suffix.append("|")
                }
                if normalChar > 0 {
                    normalChar -= 1
                    suffix.append(".")
                }
                normalChar += 1
            }
        }
        
        while verticalBar > 0 {
            verticalBar -= 1
            suffix.append("|")
        }
        while normalChar > 1 {
            normalChar -= 1
            suffix.append(".")
        }
        return suffix
    }
}
