//: [Previous](@previous)
//:
//: ## Chapter 2: Selection Sort
//:
//: Following is some code that will sort an array from smallest to largest. Let's write a function to find the smallest element in an array:

func findSmallest<T: Comparable>(_ array: [T]) -> Int {
    // Stores smallest value
    var smallest = array[0]
    // Stores the index of the smallest value
    var smallestIndex = 0
    
    for index in 1..<array.count {
        // BA: This line is why T needs to be a Comparable type
        if array[index] < smallest {
            smallest = array[index]
            smallestIndex = index
        }
    }
    return smallestIndex
}

// Sorts an array
func selectionSort<T: Comparable>(_ array: [T]) -> [T] {
    var oldArray = array
    var newArray = [T]()
    for _ in 0..<oldArray.count {
        let smallest = findSmallest(oldArray)
        newArray.append(oldArray.remove(at: smallest))
    }
    return newArray
}

print(selectionSort([5, 3, 6, 2, 10]))

//: How to do this natively in Swift:

print([5, 3, 6, 2, 10].sorted())

//: Example of sorting artists by play count

let artistPlayCount = ["Radiohead": 156, "Kishore Kumar": 141, "The Black Keys": 35, "Neutral Milk Hotel": 94, "Beck": 88, "The Strokes": 61, "Wilco": 111]

// To sort this, we need a version of selectionSort that accepts a dictionary and sorts by its values

func findSmallest<T: Comparable>(_ dictionary: [String: T]) -> String {
    // Stores smallest value
    let array = Array(dictionary.values)
    let keys = Array(dictionary.keys)
    var smallest = array[0]
    // Stores the index of the smallest value
    var smallestIndex = dictionary.keys.first!
    
    for index in 1..<array.count {
        // BA: This line is why T needs to be a Comparable type
        if array[index] < smallest {
            smallest = array[index]
            smallestIndex = keys[index]
        }
    }
    return smallestIndex
}

func selectionSort<T: Comparable>(_ dictionary: [String: T]) -> [String] {
    var oldDictionary = dictionary
    var newArray = [String]()
    for _ in oldDictionary {
        let smallest = findSmallest(oldDictionary)
        oldDictionary.removeValue(forKey: smallest)
        newArray.append(smallest)
    }
    return newArray
}

// Most played is just smallest reversed
print(Array(selectionSort(artistPlayCount).reversed()))
print(Array(selectionSort(Array(artistPlayCount.values)).reversed()))

//: [Next](@next)
