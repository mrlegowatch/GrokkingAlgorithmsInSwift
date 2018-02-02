//: [Previous](@previous)
//:
//: ## Chapter 7: Dijkstra's algorithm
//:
//: To code this example, you'll need three hash tables:
//: * a graph
//: * costs
//: * parents

// Define none (String key) and infinity (Double value) for the purpose of matching sample code in the book
let none = ""
let infinity = Double.infinity

var graph = [String: [String: Double]]()

graph["start"] = ["a": 6, "b": 2]

//: So, `graph["start"]` is a hash table.

do {
    let keys = Array(graph["start"]!.keys)

    graph["start"]!["a"]
    graph["start"]!["b"]

    graph["a"] = ["fin": 1]
    graph["b"] = ["a": 3, "fin": 5]
    graph["fin"] = [:]

    // Here's the code to make the costs table
    var costs = [String:Double]()
    costs["a"] = 6
    costs["b"] = 2
    costs["fin"] = infinity
    
    // (BA) Note that this can be generated from the start of the graph:
    var graphCostsStart = graph["start"]!
    graphCostsStart["fin"] = infinity
    
    costs == graphCostsStart
    
    // Here's the code to make the hash table for the parents:
    var parents = [String: String]()
    parents["a"] = "start"
    parents["b"] = "start"
    parents["fin"] = none
    
    // (BA) Note that this can be generated from the graph as well:
    var graphStartParents = [String:String]()
    for key in keys {
        graphStartParents[key] = "start"
    }
    graphStartParents["fin"] = none
    
    parents == graphStartParents
}


func findLowestCostNode(_ costs: [String: Double], _ processed: Set<String>) -> String {
    var lowestCost = infinity
    var lowestCostNode = none
    for pair in costs {
        let node = pair.key
        let cost = pair.value
        
        // If it's the lowest cost so far and hasn't been processed yet...
        if cost < lowestCost && !processed.contains(node) {
            lowestCost = cost
            lowestCostNode = node
        }
    }
    
    return lowestCostNode
}

// Flattens the hash table of parents into an array ordered from start to finish.
func findShortestPath(in parents: [String: String], from start: String, to finish: String) -> [String] {
    var shortestPath = [String]()
    var next = parents[finish]!
    shortestPath.append(finish)
    while next != start {
        shortestPath.append(next)
        next = parents[next]!
    }
    shortestPath.append(start)
    return shortestPath.reversed()
}

// Given a graph, start and finish, return the net costs and the parents.
func dijkstrasAlgorithm(graph: [String: [String: Double]], from start: String, to finish: String) -> ([String: Double], [String: String]) {
    // Initialize costs to start's nodes and the finish node
    var costs = graph[start]!
    costs[finish] = infinity
    
    // Initialize parents
    let keys = Array(graph[start]!.keys)
    var parents = [String:String]()
    for key in keys {
        parents[key] = start
    }
    parents[finish] = none
    
    // Keep track of what has been processed
    var processed = Set<String>()

    // Find the lowest-cost node that you haven't processed yet.
    var node = findLowestCostNode(costs, processed)
    
    // If you've processed all the nodes, this while loop is done.
    while node != none {
        let cost = costs[node]!
        let neighbors = graph[node]!
        
        // Go through all the neighbors of this node.
        let keys = Array(neighbors.keys)
        for neighbor in keys {
            let newCost = cost + neighbors[neighbor]!
            // If it's cheaper to get to this neighbor
            // by going through this node...
            // TODO: debug why a nil check is required here:
            if costs[neighbor] == nil || costs[neighbor]! > newCost {
                costs[neighbor] = newCost
                parents[neighbor] = node
            }
        }
        
        processed.insert(node)
        node = findLowestCostNode(costs, processed)
    }
    
    return (costs, parents)
}

do {
    var (costs, parents) = dijkstrasAlgorithm(graph: graph, from: "start", to: "fin")

    print("cost to fin: \(costs["fin"]!)")
    print("shortest path from start to fin: \(findShortestPath(in: parents, from: "start", to: "fin"))")
}

//: Exercise A

do {
    var graph = [String: [String: Double]]()

    graph["start"] = ["a": 5, "b": 2]
    graph["a"] = ["c": 4, "d": 2]
    graph["b"] = ["a": 8, "d": 7]
    graph["c"] = ["d": 6, "fin": 3]
    graph["d"] = ["fin": 1]
    graph["fin"] = [:]

    var (costs, parents) = dijkstrasAlgorithm(graph: graph, from: "start", to: "fin")

    print("cost to fin: \(costs["fin"]!)")
    print("shortest path from start to fin: \(findShortestPath(in: parents, from: "start", to: "fin"))")

    // Test for expected answer
    costs["fin"]! == 8.0
}

//: Exercise B


do {
    var graph = [String: [String: Double]]()

    graph["start"] = ["a": 10]
    graph["a"] = ["c": 20]
    graph["b"] = ["a": 1]
    graph["c"] = ["b": 1, "fin": 30]
    graph["fin"] = [:]

    var (costs, parents) = dijkstrasAlgorithm(graph: graph, from: "start", to: "fin")
    
    print("cost to fin: \(costs["fin"]!)")
    print("shortest path from start to fin: \(findShortestPath(in: parents, from: "start", to: "fin"))")

    // Test for expected answer
    costs["fin"]! == 60.0
}

//: Exercise C

// Trick question: there is a cost that is negative.

//: Trading for a piano

do {
    var graph = [String: [String: Double]]()

    graph["book"] = ["rare lp": 5, "poster": 0]
    graph["rare lp"] = ["bass guitar": 15, "drum set": 20]
    graph["poster"] = ["bass guitar": 30, "drum set": 35]
    graph["bass guitar"] = ["piano": 20]
    graph["drum set"] = ["piano": 10]
    graph["piano"] = [:]
    
    var (costs, parents) = dijkstrasAlgorithm(graph: graph, from: "book", to: "piano")
    
    print("cost to piano: \(costs["piano"]!)")
    print("shortest path from book to piano: \(findShortestPath(in: parents, from: "book", to: "piano"))")
}

//: [Next](@next)
