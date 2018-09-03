//: Playground - noun: a place where people can play

final class Node<T> {
    var value: T
    var next : Node<T>?
    var previous : Node<T>?
    
    init(value : T) {
        self.value = value
    }
}

protocol Linkable {
    
    associatedtype T
    
    var firstNode : Node<T>? { get }
    var lastNode : Node<T>? { get }
    var isEmpty: Bool { get }
    var length : Int { get }
    
    func appendFront(value : T)
    func appendRear(value : T)
    func displayFromHead()
    func dispayFromTail()
    func item(atIndex index : Int) -> T?
    func search(value v : T) -> Int?
}

class DoubllyLL<T>: Linkable {
    
    private var head : Node<T>?
    
    private var tail : Node<T>?
    
    var isEmpty: Bool {
        return head == nil || tail == nil
    }
    
    var firstNode: Node<T>? {
        return head
    }
    
    var lastNode: Node<T>? {
        return tail
    }
    var length: Int {
        
        var headPointer = firstNode
        var index = 0
        while headPointer != nil {
            index += 1
            headPointer = headPointer?.next
        }
        return index
    }
    
    func item(atIndex index: Int) -> T? {
        return nil
    }
    
    func search(value v: T) -> Int? {
        return nil
    }
    
    func displayFromHead() {
        var headPointer = firstNode
        print("\n--------\(#function) ---------")
        while headPointer != nil {
            print("\((headPointer?.value)!)")
            headPointer = headPointer?.next
        }
    }
    
    func dispayFromTail() {
        print("\n--------\(#function) ---------")

        var tailPointer = lastNode
        
        while tailPointer != nil {
            print("\((tailPointer?.value)!)")
            tailPointer = tailPointer?.previous
        }
    }
    
    func appendFront(value: T) {
        
        let newNode = Node(value: value)
        
        if isEmpty {
            head = newNode

        }
        else {
            
            var headerPointer = firstNode
            
            while headerPointer?.next != nil {
                headerPointer = headerPointer?.next
            }
            
            headerPointer?.next = newNode
            newNode.previous = headerPointer
            
        }
        
        tail = newNode
    }
    
    func appendRear(value: T) {
        
        let newNode = Node(value: value)
        
        if isEmpty {
            head = newNode
        }
        else {
            let tailPointer = lastNode
            newNode.previous = tailPointer
            tailPointer?.next = newNode
        }
        tail = newNode
        
    }
}

extension DoubllyLL: CustomStringConvertible {
    var description: String {
        var headPointer = firstNode
        var desc = "["
        while headPointer != nil {
            desc = "\(desc)\((headPointer?.value)!)"
            
            if headPointer?.next != nil {
                desc = "\(desc), "
            }
            
            headPointer = headPointer?.next
        }
        
        desc = "\(desc)]"
        
        return desc
    }
}

let dll = DoubllyLL<Int>()
dll.appendFront(value: 0)
dll.appendFront(value: 1)
dll.appendFront(value: 2)
dll.appendFront(value: 3)
dll.appendRear(value: 4)
dll.appendFront(value: 5)
dll.appendRear(value: 6)
dll.appendRear(value: 8)
dll.appendRear(value: 7)

print("First Node \((dll.firstNode?.value)!)")
print("Last Node \((dll.lastNode?.value)!)")

dll.displayFromHead()
dll.dispayFromTail()

print("\n --- Length \(dll.length)")

print("----- Description ------\n\(dll.description)")

