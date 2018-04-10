//: Playground - noun: a place where people can play

import UIKit

open class OpenClass {
    var openVar : String?
    func openMethod () {    }
}

public class PublicClass {
    var publicVar : String?
    func publicMethod () {    }

}

internal class InternalClass {
    var internalVar : String?
    func internalMethod () {    }

}

fileprivate class FilePrivateClass {
    var fileprivateVar : String?
    func fileprivateMethod () {    }

}

private class PrivateClass {
    var privateVar : String?
    func privateMethod () {    }

}



/*final*/ class FinalSuperClass {
    
}

class SubClass : FinalSuperClass {
    
}



// ====================================================================================
// usage of mutating keywork in swift

struct Rectangle {
    var width = 2
    var height = 3

    func area() -> Int {
        return width * height;
    }

    mutating func scaleBy(a : Int) {
        self.width *= a
        self.height *= a
    }
    mutating func increaseWidthBy(_ by : Int) {
        width = width + 10
    }
}

var rect = Rectangle()
rect.area()

rect

rect.scaleBy(a: 3)

rect.width = 10

rect.increaseWidthBy(20)



// ====================================================================================
// Usage of higher order functions like, Map, flatmap, reduce, Filter


// Map on array
var arrayOfInt = [1,2,3,4,2,6,5,789,10,11]

let a1 = arrayOfInt.map { (element) -> Int in
    return element * 10
}
print(a1)


let a2 = arrayOfInt.map { (element) in
    return element * 10
}
print(a2)


let a3 = arrayOfInt.map { element in
    element * 10
}
print(a3)

let a4 = arrayOfInt.map { $0 * 10 } // $1 intentionally
print(a4)

// Map on Dictionary
let dict = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
let d1 = dict.map { (key, value) -> String in
    return key
}
print(d1)


let d2 = dict.map {
    $1
}
print(d2)

// Map on Set
let lengthInMeters = [12.0,315.0,65.2,45.2];
let lengthInFoot = lengthInMeters.map { (element) in
    element * 2
}
print(lengthInFoot)



// FILTERS
// filter on array

let arrayOfEvenInt = arrayOfInt.filter { (element) -> Bool in
    element % 2 == 0 ? true : false
}
print(arrayOfEvenInt)

let arr2 = arrayOfInt.filter { $0 % 2 == 0 }
print(arr2)


// filter on Dictionary

let bookPrice = ["Book1" : 10, "Book2" : 11, "Book3" : 9, "Book4" : 1, "Book5" : 13]

let priceLessThan10 = bookPrice.filter { (bookKey, bookValue) -> Bool in
    bookValue <= 10
}
print(priceLessThan10)

let pr = bookPrice.filter { $1 >= 10 }
print(pr)


// Filters on Sets

let fil = lengthInMeters.filter { $0 > 65}
print(fil)



// REDUCE function

let numbers = [1,2,3,4];
print(numbers.reduce(0, { (x, y) in
    x + y
}))

let nSum = numbers.reduce(0) { $1 - $0 }
print(nSum)



// Flat map function

let arrayOfArray = [[1,2,3],[2,3,4,5,6],[6,7,8]]
print(arrayOfArray.flatMap({ $0 }))

//let people : [String? : String?] = ["name" : "nasir" , "name" : "nil" , "name" : "Ayesha"]
//print(people.flatMap({ $0 }))



