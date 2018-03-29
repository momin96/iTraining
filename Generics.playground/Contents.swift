//: Playground - noun: a place where people can play

import UIKit

enum Result<T, U> {
    case Success(T)
    case Failure(U)
}

let aSuccess : Result<Int, String> = .Success(123)
let aFailure : Result<Int, String> = .Failure("temprature is too high")
//let newSuccess : Result<[Int]> = .Success([1,2,3])

struct Queue<T> {
    
    static func staticFactoryMethod() {
        
    }
}

let aQ1 : Queue<Int> = Queue()
//let aQ2 : Queue<Int> = Queue.staticFactoryMethod()

//let bQ1 = Queue<Int>()
//let bQ2 = Queue<Int>.staticFactoryMethod()


// Generics in functions
func duplicate<T>(_ items : T, numberOfTimes n : Int) -> [T] {
    var buffer : [T] = []
    for _ in 0..<n{
        buffer.append(items)
    }
    return buffer
}

print (duplicate("nasir", numberOfTimes: 3))


/**
 Objective: To Write code Generics while reading & practicing
 */

struct Money {
    
}

struct Product {
    var name : String = ""
    var type : Int = 0
}

struct PastaPackage{
    
}

struct Tomato {
    
}

struct InventoryList<T> {
    var items : [T] = []
    
    init() {
        
    }
    
    mutating func add(package : T) {
        items.append(package)
    }
    
    mutating func remove() -> T {
        return items.removeLast()
    }
    
    func isCapacityLow () -> Bool {
        return items.count < 3
    }
}

protocol LegallyTradeable {
    
}

protocol Company {
    
    func buy<T: LegallyTradeable>(product : T, money : Money)
    func sell<T: LegallyTradeable>(productType : T.Type , money : Money) -> T?
}


var pastaInventory : InventoryList<PastaPackage> = InventoryList()
pastaInventory.add(package: PastaPackage())

var tomatoInventory : InventoryList<Tomato> = InventoryList()
tomatoInventory.add(package: Tomato())

extension InventoryList {
    var topMostItem : T? {
        return items.last
    }
}

protocol Storage {
    associatedtype Item
    var items : [Item] { set get}
    var size : Int { get }
    mutating func add(item : Item)
    mutating func remove();
    func showCurrentInventory() -> [Item]
}

struct swiftResturant {
    
    typealias Item = Food
    
    var items = [Food]()
    
    var size : Int { return 100 }
    
    mutating func add(item : Food) { }
    
    mutating func remove () { }
    
    func showCurrentInventory ()  { }
}













