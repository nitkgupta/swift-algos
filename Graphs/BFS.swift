struct Queue<T> {
    private var array: [T]
    
    init() {
        array = []
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func add(_ element: T) {
        array.append(element)
    }
    
    mutating func add(contentsOf elements: [T]) {
        array.append(contentsOf: elements)
    }
    
    mutating func remove() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    func peek() -> T? {
        return array.first
    }
}

class Graph {
    let numberOfVertices: Int
    var adjList: [[Int]]
    
    init(_ numberOfVertices: Int) {
        self.numberOfVertices = numberOfVertices
        self.adjList = Array(Array(repeating: [], count: numberOfVertices))
    }
    
    func addEdge(vertice: Int, edge: Int) {
        adjList[vertice].append(edge)
    }
    
    func performBFS(from vertice: Int) -> [Int] {
        var queue: Queue<Int> = Queue()
        var result: [Int] = []
        
        var visitedNode: [Bool] = Array(repeating: false, count: adjList.count)
        visitedNode[vertice] = true
        queue.add(vertice)
        result.append(vertice)
        
        while !queue.isEmpty {
            guard let number = queue.remove() else {
                continue
            }
            
            for item in adjList[number] {
                if !visitedNode[item] {
                    visitedNode[item] = true
                    queue.add(item)
                    result.append(item)
                }
            }
        }
        return result
    }
}

