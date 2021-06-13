//
//  LinkedList.swift
//
//  Created by Nitkarsh Gupta on 13/06/21.
//

import Foundation

final class Node<T> {
    let value: T
    weak var previousNode: Node<T>?
    var nextNode: Node<T>?
    
    init(_ value: T) {
        self.value = value
    }
}

final class DoublyLinkedList<T: Hashable> {
    private var head: Node<T>?
    private var tail: Node<T>?
    
    private var _privateDict: [T: Node<T>] = [:]
    
    init(_ values: [T] = []) {
        for item in values {
            self.insert(item)
        }
    }
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: T? {
        return head?.value
    }
    
    var last: T? {
        return tail?.value
    }
    
    func insert(_ value: T) {
        let newNode = Node(value)
    
        //first element
        guard head != nil else {
            head = newNode
            tail = newNode
            _privateDict[value] = newNode
            return
        }
        
        defer {
            tail?.nextNode = newNode
            newNode.previousNode = tail
            _privateDict[value] = newNode
            tail = newNode
        }
        
        guard let oldNode = _privateDict[value] else {
            return
        }
        
        let previousNode = oldNode.previousNode
        let nextNode = oldNode.nextNode
        
        //if previousNode is nil that means its the first element
        if let previousNode = previousNode {
            if tail?.value == value {
                tail = previousNode
            } else if tail?.previousNode?.value == value {
                tail?.previousNode = previousNode
            }
            previousNode.nextNode = nextNode
        } else {
            head = head?.nextNode == nil ? newNode : nextNode
        }
    }
    
    func peekObject() -> T? {
        guard let element = head?.value else {
            return nil
        }
        let nextNode = head?.nextNode
        head = nextNode
        _privateDict.removeValue(forKey: element)
        if nextNode == nil {
            tail = nil
        }
        return element
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    var description: String {
        var initialWord = "["
        var node = head
        while node != nil {
            initialWord.append("\(node!.value)")
            if node?.nextNode != nil { initialWord.append(", ") }
            node = node?.nextNode
        }
        initialWord.append("]")
        return initialWord
    }
}

