struct Stack<T> {
    fileprivate var array = [T]()
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    mutating func pop() -> T? {
        return array.popLast()
    }
    
    var top: T? {
        return array.last
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
    
    func performDFS(from vertice: Int) -> [Int] {
        var stack: Stack<Int> = Stack()
        var result: [Int] = []
        
        var visitedNode: [Bool] = Array(repeating: false, count: adjList.count)
        visitedNode[vertice] = true
        stack.push(vertice)
        result.append(vertice)
        
        while !stack.isEmpty {
            guard let number = stack.pop() else {
                continue
            }
            
            for item in adjList[number] {
                if !visitedNode[item] {
                    visitedNode[item] = true
                    stack.push(item)
                    result.append(item)
                }
            }
        }
        return result
    }
}

