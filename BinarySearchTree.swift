//
//  BinarySearchTree.swift
//
//  Created by Nitkarsh Gupta on 04/07/21.
//

import Foundation

enum TraversalTechnique {
    case inorder
    case preorder
    case postorder
}

///Element representing a node with left and right child
private class BinarySearchElement<T> {
    init(_ value: T) {
        self.value = value
    }
    
    var value: T
    var left: BinarySearchElement?
    var right: BinarySearchElement?
    
    var minimum: Self {
        if self.left != nil {
            return self.left?.minimum as! Self
        } else {
            return self
        }
    }
}

final class BinarySearchTree<T> where T: Comparable {
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
    
    func delete(_ value: T) {
        root = self.delete(value: value, entry: &root)
    }
    
    func traverse(in technique: TraversalTechnique) {
        switch technique {
        case .inorder:
            inorderTranversal(root)
        case .preorder:
            preorderTranversal(root)
        case .postorder:
            postorderTranversal(root)
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
    
    private func delete(value: T, entry: inout BinarySearchElement<T>?) -> BinarySearchElement<T>? {
        guard let uEntry = entry else { return nil }
        
        if value > uEntry.value {
            entry = self.delete(value: value, entry: &uEntry.right)
        } else if value < uEntry.value {
            entry = self.delete(value: value, entry: &uEntry.left)
        } else {
            
            //Not having any branches
            if uEntry.left == nil, uEntry.right == nil {
                entry = nil
            }
            
            //Having either only left or right branch
            else if uEntry.left != nil {
                entry = uEntry.left
            } else if uEntry.right != nil {
                entry = uEntry.right
            }
            
            /* having 2 branches:
             * In this case we will tranverse and find min of right branch
             * Replace the element found with the element matching
             * delete the min right side node
             */
  
            else {
                let minRight = findMin(entry: uEntry.right!)
                uEntry.value = minRight.value
                uEntry.right = delete(value: minRight.value, entry: &uEntry.right)
            }
        }
        return entry
    }
    
    private func findMin(entry: BinarySearchElement<T>) -> BinarySearchElement<T> {
        return entry.minimum
    }
    
    private func inorderTranversal(_ element: BinarySearchElement<T>?) {
        guard let uElement = element else { return }
        
        inorderTranversal(uElement.left)
        print(uElement.value)
        inorderTranversal(uElement.right)
    }
    
    private func preorderTranversal(_ element: BinarySearchElement<T>?) {
        guard let uElement = element else { return }
        
        print(uElement.value)
        preorderTranversal(uElement.left)
        preorderTranversal(uElement.right)
    }
    
    private func postorderTranversal(_ element: BinarySearchElement<T>?) {
        guard let uElement = element else { return }
        
        postorderTranversal(uElement.left)
        postorderTranversal(uElement.right)
        print(uElement.value)
    }
}
