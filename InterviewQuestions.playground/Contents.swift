//: Playground - noun: a place where people can play

import UIKit
//=====================================================================================================
/*
     1. What’s a better way to write this for loop with ranges?
     for var i = 0; i < 5; i++ {
        print("Hello!")
     }
*/
for _ in 0..<5 {
    print("Hello!")
}
//=====================================================================================================

/**
 2. Consider the following:
 struct Tutorial {
    var difficulty: Int = 1
 }
 var tutorial1 = Tutorial()
 var tutorial2 = tutorial1
 tutorial2.difficulty = 2
 
    What's the value of tutorial1.difficulty and tutorial2.difficulty? Would this be any different if Tutorial was a class? Why?
 */

class Tutorial {
    var difficulty = 1
}
var t1 = Tutorial()
var t2 = t1
t2.difficulty = 2
print(t1.difficulty, t2.difficulty)

/** Justification: Because class is refrence type but struct is value type, t2 points to same location as t1, so any modification of t2's it will reflect in t1  */

//=====================================================================================================

/**
 3. view1 is declared with var, and view2 is declared with let. What's the difference here, and will the last line compile?
 */
 var view1 = UIView()
 view1.alpha = 0.5
 
 let view2 = UIView()
 view2.alpha = 0.5 // Will this line compile?

/** Justification: Yes, it will compile, because alpha property is variable not constant, view2 is declared as constant. */

//=====================================================================================================

/**
 4. This code sorts an array of names alphabetically and looks complicated. Simplify it and the closure as much as you can.
 */

let animals = ["fish", "cat", "chicken", "dog"]
print(animals)
let sortedAnimals = animals.sorted(by: <)
print(sortedAnimals)

//=====================================================================================================

/**
 5. This code creates two classes, Address and Person, and it creates two instances to represent Ray and Brian.
 Suppose Brian moves to the new building across the street, so you update his record like this:
                brian.address.fullAddress = "148 Tutorial Street"
 What's going on here? What's wrong with this?
 */

struct Address {
    var fullAddress: String
    var city: String
    
    init(fullAddress: String, city: String) {
        self.fullAddress = fullAddress
        self.city = city
    }
}

class Person {
    var name: String
    var address: Address
    
    init(name: String, address: Address) {
        self.name = name
        self.address = address
    }
}

var headquarters = Address(fullAddress: "123 Tutorial Street", city: "Appletown")
var ray = Person(name: "Ray", address: headquarters)
var brian = Person(name: "Brian", address: headquarters)
brian.address.fullAddress = "148 Tutorial Street"
brian
ray
// OR in Address is of class type
var brainsNewAddress = Address(fullAddress: "Exilant KR Bangalore", city: "Appletown")
brian.address = brainsNewAddress
brian
ray

/**
 Justification: If Address is of class type then we need to create a new instance so that brain's & ray's should not be same (Reference type)
 OR Address has to be struct type & insturction which updates brain's address will no update ray's address (Value type)
 */
