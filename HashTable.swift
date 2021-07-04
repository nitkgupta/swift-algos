//
//  HashTable.swift
//  Swift-KeyPath-Example
//
//  Created by Nitkarsh Gupta on 03/07/21.
//

import Foundation

class HashEntry<K, V> {
    let key: K
    var value: V
    var next: HashEntry?
    
    init(key: K, value: V) {
        self.key = key
        self.value = value
    }
}

final class HashTable<K, V> where K: Hashable {
    private let maxValues: Int
    private lazy var entries: [HashEntry<K, V>?] = Array<HashEntry<K, V>?>(repeating: nil, count: maxValues)
    
    init(maxValues: Int = 256, values: [K: V] = [:]) {
        self.maxValues = maxValues
        for value in values {
            put(key: value.key ,value.value)
        }
    }
    
    subscript(_ key: K) -> V? {
        get {
            return getElement(for: key)
        }
        set {
            put(key: key, newValue)
        }
    }
    
    func contains(_ key: K) -> Bool {
        let index = getIndex(key)
        var entry = entries[index]
        while entry != nil {
            if entry?.key == key {
                return true
            }
            entry = entry?.next
        }
        return false
    }
    
    func getIndex(_ key: K) -> Int {
        //manually creating collision
        if key.hashValue == 5.hashValue || key.hashValue == 6.hashValue {
            return abs(1.hashValue % maxValues)
        }
        let initialValue = key.hashValue
        return abs(initialValue % maxValues)
    }
    
    func getElement(for key: K) -> V? {
        let index = getIndex(key)
        var entry = entries[index]
        while entry != nil {
            if entry?.key == key {
                return entry?.value
            }
            entry = entry?.next
        }
        return nil
    }
    
    func put(key: K, _ value: V?) {
        let index = getIndex(key)
        
        guard let value = value else {
            removeElement(key)
            return
        }
        
        if entries[index] == nil {
            entries[index] = HashEntry(key: key, value: value)
        } else {
            if contains(key) {
                var entry = entries[index]
                var elementFound: Bool = false
                while !elementFound && entry != nil {
                    if entry?.key == key {
                        entry?.value = value
                        elementFound = true
                    }
                    entry = entry?.next
                }
            } else {
                var collisionEntry = entries[index]
                while collisionEntry?.next != nil {
                    collisionEntry = collisionEntry?.next
                }
                collisionEntry?.next = HashEntry(key: key, value: value)
            }
        }
    }
    
    func removeElement(_ key: K) {
        guard contains(key) else {
            return
        }
        let index = getIndex(key)
        var entry = entries[index]
        if entry?.key == key {
            entries[index] = entry?.next
        } else {
            while entry?.next != nil {
                if entry?.next?.key == key {
                    entry?.next = entry?.next?.next
                } else {
                    entry = entry?.next
                }
            }
        }
    }
    
    var values: [K: V] {
        var values: [K: V] = [:]
        entries.forEach {
            guard let entry = $0 else {
                return
            }
            values[entry.key] = entry.value
            var otherEntries: HashEntry? = entry
            while otherEntries?.next != nil {
                if let next = otherEntries?.next {
                    values[next.key] = next.value
                }
                otherEntries = otherEntries?.next
            }
        }
        return values
    }
}

extension HashTable: CustomStringConvertible {
    var description: String {
        return values.description
    }
}
