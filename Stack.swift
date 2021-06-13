//
//  Stack.swift
//
//  Created by Nitkarsh Gupta on 13/06/21.
//

import Foundation

struct Stack<T> {
    private var values: [T] = []
    
    var isEmpty: Bool {
        return values.isEmpty
    }
    
    var count: Int {
        return values.count
    }
    
    mutating func push(_ element: T) {
        values.append(element)
    }
    
    mutating func pop() -> T? {
        return values.popLast()
    }
    
    func peek() -> T? {
        return values.last
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        return values.description
    }
}
