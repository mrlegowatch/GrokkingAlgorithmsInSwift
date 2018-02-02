//: [Previous](@previous)
//: ## Chapter 8: Greedy algorithms
//:
//: When you have two sets, you can do fun things with them.

let fruits = Set(["avocado", "tomato", "banana"])
let vegetables = Set(["beets", "carrots", "tomato"])

//: A set union means "combine both sets." The | operator:
func |(lhs: Set<String>, rhs: Set<String>) -> Set<String> {
    return lhs.union(rhs)
}
fruits | vegetables

//: A set intersection means "find the items that show up in both sets" (in this case just the tomato). The & operator:
func &(lhs: Set<String>, rhs: Set<String>) -> Set<String> {
    return lhs.intersection(rhs)
}
fruits & vegetables

//: A set difference means "subtract the items in one set from the items in the other set." The - operator:
func -(lhs: Set<String>, rhs: Set<String>) -> Set<String> {
    return lhs.subtracting(rhs)
}
fruits - vegetables

//:
var statesNeeded = Set(["mt", "wa", "or", "id", "nv", "ut", "ca", "az"])

let stations = [
    "kone": Set(["id", "nv", "ut"]),
    "ktwo": Set(["wa", "id", "mt"]),
    "kthree": Set(["or", "nv", "va"]),
    "kfour": Set(["nv", "ut"]),
    "kfive": Set(["ca", "az"])
]

var finalStations = Set<String>()

let none: String? = nil

while !statesNeeded.isEmpty {
    var bestStation: String? = none
    var statesCovered = Set<String>()
    for (station, statesForStation) in stations {
        let covered = statesNeeded & statesForStation
        if covered.count > statesCovered.count {
            bestStation = station
            statesCovered = covered
        }
    }
    
    statesNeeded = statesNeeded - statesCovered
    if let bestStation = bestStation {
        finalStations.insert(bestStation)
    }
}

print(finalStations)

//: [Next](@next)
