//: [Previous](@previous)
//:
//: ## Chapter 4: Quicksort
//:
//: Here's the code for quicksort:

func quickSort<T: Comparable>(_ array: [T]) -> [T] {
    // Base case: arrays with 0 or 1 element are already "sorted"
    guard array.count >= 2 else { return array }
    
    // Recursive case
    let pivot = array[0]
    // Pop first
    let array = array[1...]
    // Sub-array of all the elements less than the pivot
    let less = array.filter { $0 <= pivot }
    // Sub-array of all the elements greater than the pivot
    let greater = array.filter { $0 > pivot }

    // TODO: Swift generates an error "ambiguous reference to member '+'" if I use consecutive + ... + ...
    var result = quickSort(less) + [pivot]
    result += quickSort(greater)
    return result
}

print(quickSort([10, 5, 2, 3]))

//: **4.1** Write out the code for the `sum` function.

func sum(_ array: [Int]) -> Int {
    guard array.count > 0 else { return 0 }
   
    let first = array.first!
    let array = [Int](array[1...])
    return first + sum(array)
}

print(sum([2, 4, 6]))

//: How to do this natively in Swift

print([2, 4, 6].reduce(0, +))


//: [Next](@next)
