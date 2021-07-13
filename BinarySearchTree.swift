//
//  BinarySearchTree.swift
//
//  Created by Nitkarsh Gupta on 04/07/21.
//

import Foundation

///Element representing a node with left and right child
private class BinarySearchElement<T> {
    init(_ value: T) {
        self.value = value
    }
    
    var value: T
    var left: BinarySearchElement?
    var right: BinarySearchElement?
}

class BinarySearchTree<T> where T: Comparable {
    private var root: BinarySearchElement<T>?
    
    var min: T? {
        return lastNode(fromLeft: true)?.value
    }
    
    var max: T? {
        return lastNode(fromLeft: false)?.value
    }
    
    func insert(_ value: T) {
        let newElement = BinarySearchElement(value)
        if root == nil {
            root = newElement
        } else {
            guard let entry = findRootNode(element: value) else {
                return
            }
            ///Note: not handling value for equal for now. Assuming node cant be broken and then reattached
            if value < entry.value {
                entry.left = newElement
            } else if value > entry.value {
                entry.right = newElement
            }
        }
    }
}

//MARK: - Private Methods
extension BinarySearchTree {
    private func findRootNode(element: T) -> BinarySearchElement<T>? {
        guard let entry = root else {
            return nil
        }
        return findNode(element: element, initial: entry)
    }

    private func findNode(element: T, initial: BinarySearchElement<T>) -> BinarySearchElement<T> {
        guard initial.left != nil || initial.right != nil else {
            return initial
        }
        if initial.value == element {
            return initial
        } else if let right = initial.right, element > initial.value {
            return findNode(element: element, initial: right)
        } else if let left = initial.left, element < initial.value {
            return findNode(element: element, initial: left)
        } else {
            return initial
        }
    }
    
    private func lastNode(fromLeft: Bool) -> BinarySearchElement<T>? {
        var entry = root
        if fromLeft {
            while entry?.left != nil {
                entry = entry?.left
            }
        } else {
            while entry?.right != nil {
                entry = entry?.right
            }
        }
        return entry
    }
}
