//: Playground - noun: a place where people can play


let list : [Any] = ["Monday", "Tuesday", "Wed", "Thur", "Fri", "Sat", "Sun"]



class HorizontalAxisView {
    
    private var xAxisLabelsArray : Array<Any>?
    internal var domainArray : Array<Any>? {
        didSet {
            prepareAxisArray()
        }
    }
    
    
    func prepareAxisArray () {
        for item in domainArray! {
            print(item)
        }
        print(domainArray!)
    }
}

let hAV = HorizontalAxisView()

hAV.domainArray = list


struct StringPair<T1, T2> {
    var first : T1
    var second: T2
}

let s = StringPair<Float,String>(first: 3.8, second: "String")
print(s)

var uniqueNumber : Set = [0,2,3,2,0,5,6,12,5,6]
print(uniqueNumber)

uniqueNumber.remove(0)
print(uniqueNumber)



struct Student: Hashable {
    var name : String
    
    public var hashValue: Int {
        return name.hashValue
    }
    
    public static func ==(lhs: Student, rhs: Student) -> Bool {
            return lhs.name == rhs.name
    }
}

let v = Set<Student>()

let number : Set = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
let primeNo : Set = [13, 17, 19, 23]
let oddNo : Set = [11, 13, 15, 17, 19]

print("Union : \((primeNo.union(oddNo)).sorted())")

print("Intersection : \((primeNo.intersection(oddNo)).sorted())")

print("symmetricDifference \((primeNo.symmetricDifference(oddNo)).sorted())")

print("Substract : \((oddNo.subtracting(primeNo)).sorted())")

print("== \(primeNo == primeNo)")


var mixedMap : [AnyHashable : Any] = [0:"Zero", "pi":3.142]

let piWrap = AnyHashable.init("pi")

if let unwrap = piWrap as? String {
    print(unwrap)
}


protocol Stackable {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element
    mutating func removeAll()
    func lastElement() -> Element
}


struct Stack<T>: Stackable {
    typealias Element = T
    private var elements = [Element]()
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T {
        return elements.popLast()!
    }
    
    mutating func removeAll() {
        elements.removeAll()
    }
    
    func lastElement() -> T {
        return elements.last!
    }
}

var stringStack = Stack<String>()
stringStack.push("first")
stringStack.push("second")
print(stringStack)

stringStack.push("third")
print(stringStack.lastElement())

print("removed \(stringStack.pop())")

//stringStack.removeAll()

print(stringStack)


// Queue

protocol Queueable {
    
    associatedtype Element
    mutating func insert(fromFront element: Element)
    mutating func remove(fromRear element: Element)
    func frontItem() -> Element
    
    mutating func insert(fromRear element: Element)
    mutating func remove(fromFront element: Element)
    func rearItem() -> Element
}

struct Queue<Q>:Queueable {
    
    typealias Element = Q
    
    private var elements = [Element]()
    
    mutating func insert(fromRear element: Q) {
        
    }
    mutating func remove(fromFront element: Q) {
        
    }
    func frontItem() -> Q {
        return elements.last!
    }
    
    mutating func insert(fromFront element: Q) {
        
    }
    mutating func remove(fromRear element: Q) {
        
    }
    func rearItem() -> Q {
        return elements.first!
    }
}

// Linked List

final class Node<T> {
    
    private var data: T
    
    var value: T {
        return data
    }
    
    var next: Node<T>?
    var previous: Node<T>?
    
    init(value: T) {
        data = value
    }
}

class LinkedList<T> {
    
    private var head: Node<T>?
    private var tail: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: Node<T>? {
        return head
    }
    
    var last : Node<T>? {
        return tail
    }
    
    init() {
        
    }
    
    func append(_ value: T) {
        let newNode = Node.init(value: value)
        
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        }
        else {
            head = newNode
        }
        
        tail = newNode
        
    }
    
    func display()  {
        
        var head = first

        while head?.next != nil {
            print("Elements \(head?.value as! String)")
            head = head?.next
        }
        print((head?.value)! as Any)
        
    }
}


let ll = LinkedList<String>()
ll.append("First")
ll.append("Second")
ll.append("third")
ll.append("Fourth")
ll.append("Fifth")

print(ll.last?.value)

ll.display()










