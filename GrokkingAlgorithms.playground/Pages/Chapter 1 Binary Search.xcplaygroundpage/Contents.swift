//:
//: # Grokking Algorithms
//: ### An illustrated guide for programmers and other curious people
//:
//: *By Aditya Y. Bhargava, Manning Publications, May 2016, ISBN 9781617292231, 256 pages printed in black & white*
//:
//:
//: ## Chapter 1: Binary Search
//:
//: This implements a binary search on a list of sorted items with an item to find, and returns the index of the found item. Returns nil if the string is not in the list.

func binarySearch<T: Comparable>(list: [T], item: T) -> Int? {
    var index: Int?
    
    // low and high keep track of which part of the list you'll search in.
    var low = 0
    var high = list.count - 1
    
    // While you haven't narrowed it down to one element...
    while low <= high {
        // ...check the middle element.
        let mid = (low + high) / 2
        let guess = list[mid]
        if guess == item {
            // Found the item.
            index = mid
            break
        }
        if guess > item {
            // The guess was too high.
            high = mid - 1
        } else {
            // The guess was too low.
            low = mid + 1
        }
    }
    
    return index
}

//: Let's test it!

let myList = [1, 3, 5, 7, 9]

binarySearch(list: myList, item: 3) // Returns 1
binarySearch(list: myList, item: -1) // Returns nil

//: How you might do this natively in Swift:

myList.index(of: 3)
myList.index(of: -1)

//: Unfortunately, index(of:) uses linear search. So, we settle for a more Swift-like way to implement a sorted array:

extension Array where Element: Comparable {
    
    func sortedIndex(of item: Element) -> Int? {
        var index: Int? // The item initially doesn't exist.
        
        // low and high keep track of which part of the list you'll search in.
        var low = 0
        var high = self.count - 1
        
        // While you haven't narrowed it down to one element...
        while low <= high {
            // ...check the middle element.
            let mid = (low + high) / 2
            let guess = self[mid]
            if guess == item {
                // Found the item.
                index = mid
                break
            }
            if guess > item {
                // The guess was too high.
                high = mid - 1
            } else {
                // The guess was too low.
                low = mid + 1
            }
        }
        
        return index
    }
    
}

let unsortedList = [7, 1, 5, 9, 3]
let sortedList = unsortedList.sorted()

// Our sortedIndex(of:) is going to use binary search.
sortedList.sortedIndex(of: 3)
sortedList.sortedIndex(of: -1)

//: *1.1* Suppose you have a sorted list of 128 names, and you're searching through it using binary search. What's the maximum number of steps it would take?

func binarySearchCountingSteps<T: Comparable>(list: [T], item: T) -> Int {
    // Instead of returning the index, count up and return the number of steps.
    var steps = 0

    // low and high keep track of which part of the list you'll search in.
    var low = 0
    var high = list.count - 1
    
    // While you haven't narrowed it down to one element...
    while low <= high {
        // ...check the middle element.
        let mid = (low + high) / 2
        let guess = list[mid]
        if guess == item {
            // Found the item.
            break
        }
        if guess > item {
            // The guess was too high.
            high = mid - 1
        } else {
            // The guess was too low.
            low = mid + 1
        }
        
        steps += 1
    }
    
    return steps
}

let names = [
    "aa", "ab", "ac", "ad", "ae", "af", "ag", "ah", "ai", "aj", "ak", "al", "am", "an", "ao", "ap", "aq", "ar", "as", "at", "au", "av", "aw", "ax", "ay", "az",
    "ba", "bb", "bc", "bd", "be", "bf", "bg", "bh", "bi", "bj", "bk", "bl", "bm", "bn", "bo", "bp", "bq", "br", "bs", "bt", "bu", "bv", "bw", "bx", "by", "bz",
    "ca", "cb", "cc", "cd", "ce", "cf", "cg", "ch", "ci", "cj", "ck", "cl", "cm", "cn", "co", "cp", "cq", "cr", "cs", "ct", "cu", "cv", "cw", "cx", "cy", "cz",
    "da", "db", "dc", "dd", "de", "df", "dg", "dh", "di", "dj", "dk", "dl", "dm", "dn", "do", "dp", "dq", "dr", "ds", "dt", "du", "dv", "dw", "dx", "dy", "dz",
    "ea", "eb", "ec", "ed", "ee", "ef", "eg", "eh", "ei", "ej", "ek", "el", "em", "en", "eo", "ep", "eq", "er", "es", "et", "eu", "ev", "ew", "ex"]

names.count
binarySearchCountingSteps(list: names, item: "ex") // Returns 7

//: *1.2* Suppose you double the size of the list. What's the maximum number of steps now?

let doubleNames = [
    "aa", "ab", "ac", "ad", "ae", "af", "ag", "ah", "ai", "aj", "ak", "al", "am", "an", "ao", "ap", "aq", "ar", "as", "at", "au", "av", "aw", "ax", "ay", "az",
    "ba", "bb", "bc", "bd", "be", "bf", "bg", "bh", "bi", "bj", "bk", "bl", "bm", "bn", "bo", "bp", "bq", "br", "bs", "bt", "bu", "bv", "bw", "bx", "by", "bz",
    "ca", "cb", "cc", "cd", "ce", "cf", "cg", "ch", "ci", "cj", "ck", "cl", "cm", "cn", "co", "cp", "cq", "cr", "cs", "ct", "cu", "cv", "cw", "cx", "cy", "cz",
    "da", "db", "dc", "dd", "de", "df", "dg", "dh", "di", "dj", "dk", "dl", "dm", "dn", "do", "dp", "dq", "dr", "ds", "dt", "du", "dv", "dw", "dx", "dy", "dz",
    "ea", "eb", "ec", "ed", "ee", "ef", "eg", "eh", "ei", "ej", "ek", "el", "em", "en", "eo", "ep", "eq", "er", "es", "et", "eu", "ev", "ew", "ex",
    "fa", "fb", "fc", "fd", "fe", "ff", "fg", "fh", "fi", "fj", "fk", "fl", "fm", "fn", "fo", "fp", "fq", "fr", "fs", "ft", "fu", "fv", "fw", "fx", "fy", "fz",
    "ga", "gb", "gc", "gd", "ge", "gf", "gg", "gh", "gi", "gj", "gk", "gl", "gm", "gn", "go", "gp", "gq", "gr", "gs", "gt", "gu", "gv", "gw", "gx", "gy", "gz",
    "ha", "hb", "hc", "hd", "he", "hf", "hg", "hh", "hi", "hj", "hk", "hl", "hm", "hn", "ho", "hp", "hq", "hr", "hs", "ht", "hu", "hv", "hw", "hx", "hy", "hz",
    "ia", "ib", "ic", "id", "ie", "if", "ig", "ih", "ii", "ij", "ik", "il", "im", "in", "io", "ip", "iq", "ir", "is", "it", "iu", "iv", "iw", "ix", "iy", "iz",
    "ja", "jb", "jc", "jd", "je", "jf", "jg", "jh", "ji", "jj", "jk", "jl", "jm", "jn", "jo", "jp", "jq", "jr", "js", "jt", "ju", "jv", "jw", "jx"]

doubleNames.count
binarySearchCountingSteps(list: doubleNames, item: "jx") // Returns 8

//: [Next](@next)
