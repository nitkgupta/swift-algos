//
//  Queue.swift
//  Swift-KeyPath-Example
//
//  Created by Nitkarsh Gupta on 13/06/21.
//

import Foundation

struct Queue<T> {
    private var values: [T] = []
    
    var isEmpty: Bool {
        return values.isEmpty
    }
    
    var count: Int {
        return values.count
    }
    
    mutating func enqueue(_ element: T) {
        values.append(element)
    }
    
    mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else  {
            return values.removeFirst()
        }
    }
    
    func peek() -> T? {
        return values.first
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        return values.description
    }
}
