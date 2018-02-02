//: [Previous](@previous)
//:
//: ## Chapter 5: Hash tables
//:
//: Using hash tables for lookups:

var phoneBook = [String:Int]()

phoneBook["jenny"] = 8675309
phoneBook["emergency"] = 911

print("Jenny's phone number is \(phoneBook["jenny"]!)")

//: Preventing duplicate entries:

var voted = [String: Bool]()

func checkVoter(_ name: String) {
    if voted[name] != nil {
        print("Kick them out!")
    } else {
        voted[name] = true
        print("Let them vote!")
    }
}

checkVoter("tom")
checkVoter("mike")
checkVoter("mike")

//: Using hash tables as a cache

import Foundation

var cache = [URL: Data]()

func getPage(_ url: URL) -> Data {
    guard let cached = cache[url] else {
        let data = try! Data(contentsOf: url) // get data from server
        cache[url] = data
        return data
    }
    
    return cached
}

// Example URLs

let earthquakesPastDayFeed = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
let earthquakesPastMonthFeed = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson"

let earthquakesPastDayData = getPage(URL(string: earthquakesPastDayFeed)!)
print("URL data cache has \(cache.count) items")

let earthquakesPastMonthData = getPage(URL(string: earthquakesPastMonthFeed)!)
print("URL data cache has \(cache.count) items")

let pastMonthAgainData = getPage(URL(string: earthquakesPastMonthFeed)!)
print("URL data cache has \(cache.count) items")

earthquakesPastMonthData == pastMonthAgainData
earthquakesPastMonthData != earthquakesPastDayData

//: [Next](@next)
