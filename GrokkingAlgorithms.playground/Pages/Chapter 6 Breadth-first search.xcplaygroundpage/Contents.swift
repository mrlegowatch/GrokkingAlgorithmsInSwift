//: [Previous](@previous)
//:
//: ## Chapter 6: Breadth-first search
//:
//: Implementing the graph

var graph = [String: [String]]()
graph["you"] = ["alice", "bob", "claire"]
graph["bob"] = ["anuj", "peggy"]
graph["alice"] = ["peggy"]
graph["claire"] = ["thom", "jonny"]
graph["anuj"] = []
graph["peggy"] = []
graph["thom"] = []
graph["jonny"] = []

// Swift lacks a native deque class, so use an array instead in this example
func search(_ graph: [String: [String]], from you: String, forSuffix seller: Character) -> Bool {
    var found = false
    var searchQueue = [String]()
    searchQueue += graph[you]!
    var searched = [String]()
    while !searchQueue.isEmpty {
        let person = searchQueue.removeFirst()
        if !searched.contains(person) {
            if personIsSeller(person, seller) {
                print("\(person) is a mango seller!")
                found = true
                break
            } else {
                searchQueue += graph[person]!
                searched.append(person)
            }
        }
    }
    return found
}

func personIsSeller(_ name: String, _ seller: Character) -> Bool {
    return name.last == seller
}

search(graph, from: "you", forSuffix: "m") // thom is a mango seller

search(graph, from: "you", forSuffix: "e") // alice is a mango seller

search(graph, from: "you", forSuffix: "k") // there is no mango seller with suffix "k"

//: [Next](@next)
