//: [Previous](@previous)
//:
//: ## Chapter 3: Recursion
//:
//: Every recursive function has two parts: the base case and the recursive case.

func countdown(_ index: Int) {
    print(index)
    if index <= 0 {
        return
    } else {
        countdown(index - 1)
    }
}

print("countdown:")
countdown(3)

//: Call stack with recursion

// Naïve version of factorial function
do {

    func factorial(_ number: Int) -> Int {
        if number == 1 {
            return 1
        } else {
            return number * factorial(number - 1)
        }
    }

    factorial(3)
    factorial(8)
    
    // Eeek!
    //factorial(0)
}

// More Swift-y way to implement recursive factorial

do {
    func factorial(_ number: Int) -> Int? {
        guard number >= 1 else { return nil }
        guard number != 1 else { return 1 }
        return number * factorial(number - 1)!
    }
    
    factorial(3) // returns 6
    factorial(8) // returns 40320
    
    factorial(-30) // returns nil
    factorial(0) // returns nil
}

//: [Next](@next)
