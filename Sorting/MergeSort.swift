class MergeSort {
    func sort(_ array: [Int]) -> [Int] {
        
        guard array.count > 1 else {
            return array
        }
        
        let middleIndex = array.count / 2
        
        let leftArr = sort(Array(array[0..<middleIndex]))
        let rightArr = sort(Array(array[middleIndex..<array.count]))
        
        return mergeValues(left: leftArr, right: rightArr)
    }
    
    private func mergeValues(left: [Int], right: [Int]) -> [Int] {
        var leftIndex: Int = 0
        var rightIndex: Int = 0
        
        var sortedArray: [Int] = []
        
        while leftIndex < left.count && rightIndex < right.count {
            let leftValue = left[leftIndex]
            let rightValue = right[rightIndex]
            
            if leftValue < rightValue {
                sortedArray.append(leftValue)
                leftIndex += 1
            } else if rightValue < leftValue {
                sortedArray.append(rightValue)
                rightIndex += 1
            } else {
                sortedArray.append(leftValue)
                sortedArray.append(rightValue)
                leftIndex += 1
                rightIndex += 1
            }
        }
        
        while leftIndex < left.count {
            sortedArray.append(left[leftIndex])
            leftIndex += 1
        }
        
        while rightIndex < right.count {
            sortedArray.append(right[rightIndex])
            rightIndex += 1
        }
        return sortedArray
    }
}
