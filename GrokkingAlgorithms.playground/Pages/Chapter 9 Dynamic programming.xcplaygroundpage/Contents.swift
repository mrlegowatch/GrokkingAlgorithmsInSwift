//: [Previous](@previous)
//: ## Chapter 9: Dynamic programming
//:
//: The Knapsack problem

// Provide a convenient package for the name, value and weight.
struct Item {
    let name: String
    let value: Double
    let weight: Double
}

// For arrays of Item, provide functions to sum their values, and print their names.
extension Array where Element == Item {
    
    func sum() -> Double {
        return self.reduce(0.0) { $0 + $1.value }
    }
    
    func names() -> String {
        return self.reduce("") {
            let separator = ($0.isEmpty ? "" : ", ")
            return $0 + separator + $1.name
        }
    }
}

// Returns the optimal array of items that can be put in a knapsack.
//
// This implementation:
// - encapsulates Item data
// - uses Double for weight and values
// - allows for non-integer step size
// - returns the array of items that fit, instead of the maximum value.
//
// Use sum() on the result to obtain the maximum value.
// Use names() on the result to obtain the names of the items.
//
// Some implementations use an addtional initial row and column full of 0's,
// to avoid the if checks found in this implementation.
func knapsack(size: Double, stepSize: Double, items: [Item]) -> [Item] {
    let rowCount = items.count
    let columnCount = Int(size / stepSize)
    
    // Initialize the grid
    var grid = [[[Item]]]()
    for _ in 0..<rowCount {
        grid.append([[Item]](repeating: [], count: columnCount))
    }
    
    // Set the initial row
    for column in 0..<columnCount {
        let columnWeight = ((Double(column)) * stepSize)
        if items[0].weight <= columnWeight + stepSize {
            grid[0][column] = [items[0]]
        }
    }
    
    // Build the rest of the grid
    for row in 1..<rowCount {
        let rowItem = items[row]
        let rowValue = rowItem.value
        let rowWeight = rowItem.weight
        for column in 0..<columnCount {
            let columnWeight = ((Double(column)) * stepSize)
            let previousItems = grid[row - 1][column]
            if rowWeight <= columnWeight + stepSize {
                let smallerWeight = columnWeight - rowWeight
                let smallerItems = smallerWeight >= 0 ? grid[row - 1][Int(smallerWeight/stepSize)] : [Item]()
                if rowValue + smallerItems.sum() > previousItems.sum() {
                    grid[row][column] = [rowItem] + smallerItems
                } else {
                    grid[row][column] = previousItems
                }
            } else {
                grid[row][column] = previousItems
            }
        }
    }
    
    return grid[rowCount-1][columnCount-1]
}

//: The knapsack problem

do {
    let items = [Item(name: "Guitar", value: 1500, weight: 1.0),
                 Item(name: "Stereo", value: 3000, weight: 4.0),
                 Item(name: "Laptop", value: 2000, weight: 3.0)]
    
    let fittedItems = knapsack(size: 4.0, stepSize: 1.0, items: items)
    
    print()
    print("The knapsack problem with a guitar, stereo and laptop")
    print("Maximum value = \(fittedItems.sum())")
    print("Stolen items = \(fittedItems.names())")
}

//: What happens if you add an item?

do {
    let items = [Item(name: "Guitar", value: 1500, weight: 1.0),
                 Item(name: "Stereo", value: 3000, weight: 4.0),
                 Item(name: "Laptop", value: 2000, weight: 3.0),
                 Item(name: "iPhone", value: 2000, weight: 1.0)]
    
    let fittedItems = knapsack(size: 4.0, stepSize: 1.0, items: items)
    
    print()
    print("What happens if add an iPhone?")
    print("Maximum value = \(fittedItems.sum())")
    print("Stolen items = \(fittedItems.names())")
}

//: ## 9.1 Exercise
//: Suppose you can steal another item: an MP3 player. It weighs 1 lb and is worth $1000. Should you steal it?

do {
    let items = [Item(name: "Guitar", value: 1500, weight: 1.0),
                 Item(name: "Stereo", value: 3000, weight: 4.0),
                 Item(name: "Laptop", value: 2000, weight: 3.0),
                 Item(name: "MP3 Player", value: 1000, weight: 1.0)]
    
    let fittedItems = knapsack(size: 4.0, stepSize: 1.0, items: items)
    
    print("What happens if there is an MP3 Player?")
    print()
    print("Maximum value = \(fittedItems.sum())")
    print("Stolen items = \(fittedItems.names())")
    let containsMP3Player = fittedItems.first(where: { $0.name == "MP3 Player" }) != nil
    print("Steal the MP3 Player = \(containsMP3Player)")
}

//: What happens if you change the order of the rows?

do {
    let items = [Item(name: "Stereo", value: 3000, weight: 4.0),
                 Item(name: "Laptop", value: 2000, weight: 3.0),
                 Item(name: "Guitar", value: 1500, weight: 1.0)]
    
    let fittedItems = knapsack(size: 4.0, stepSize: 1.0, items: items)
    
    print()
    print("What happens if you change the order of the rows?")
    print("Maximum value = \(fittedItems.sum())")
    print("Stolen items = \(fittedItems.names())")
}

//: What happens if you add a smaller item?

do {
    let items = [Item(name: "Guitar", value: 1500, weight: 1.0),
                 Item(name: "Stereo", value: 3000, weight: 4.0),
                 Item(name: "Laptop", value: 2000, weight: 3.0),
                 Item(name: "Necklace", value: 1000, weight: 0.5)]
    
    let fittedItems = knapsack(size: 4.0, stepSize: 0.5, items: items)
    
    print()
    print("What happens if you have a smaller item?")
    print("Maximum value = \(fittedItems.sum())")
    print("Stolen items = \(fittedItems.names())")
}

//: Optimizing your travel itinerary

do {
    let items = [Item(name: "Westminster Abbey", value: 7, weight: 0.5),
                 Item(name: "Globe Theater", value: 6, weight: 0.5),
                 Item(name: "National Gallery", value: 9, weight: 1.0),
                 Item(name: "British Museum", value: 9, weight: 2.0),
                 Item(name: "St. Paul's Cathedral", value: 8, weight: 0.5)]
    
    let fittedItems = knapsack(size: 2.0, stepSize: 0.5, items: items)
    
    print()
    print("Optimizing your travel itinerary")
    print("Itinerary = \(fittedItems.names())")
}

//: ## Excersise 9.2
//: Suppose you're going camping. You have a knapsack that will hold 6 lb, and you can take the following items. Each has a value, and the higher the value, the more important the item is.

do {
    let items = [Item(name: "Water", value: 10, weight: 3.0),
                 Item(name: "Book", value: 3, weight: 1.0),
                 Item(name: "Food", value: 9, weight: 2.0),
                 Item(name: "Jacket", value: 5, weight: 2.0),
                 Item(name: "Camera", value: 6, weight: 1.0)]
    
    let fittedItems = knapsack(size: 6.0, stepSize: 1.0, items: items)
    
    print()
    print("Optimal set of items to take camping = \(fittedItems.names())")
}

//: [Next](@next)
