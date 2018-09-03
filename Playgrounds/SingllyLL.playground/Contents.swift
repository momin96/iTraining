//: Playground - noun: a place where people can play

final class Node<T> {
    
    var dataVal : T
    var next : Node<T>?
    
    init(dataVal val: T) {
        dataVal = val
    }
    
    static func displayLinked(node : Node<T>?) {
        
        print("\n------ \(#function) ------")
        
        guard node != nil else {
            print("Nil Node")
            return
        }
        
        var currPointer = node
        while currPointer != nil {
            print("\(String(describing: (currPointer?.dataVal)!))")
            currPointer = currPointer?.next
        }
    }
}

protocol Linkable {
    
    associatedtype T
    
    var isLLEmpty: Bool { get }
    var firstNode: Node<T>? { get }
    var lastNode: Node<T>? { get }
    var length: Int { get }
    
    func append(fromFront value: T)
    func display()
    func insert(item val: T, atIndex index: Int)
    func item(atIndex index: Int) -> T?
    
    func reverse() -> Node<T>?
}

class SingllyLinkedList<T>: Linkable {
    
    // Always points first node
    private var front: Node<T>?
    
    // Always points to last node
    private var rear: Node<T>?
    
    // Keeps track of current head pointer in list
    private var headPointer: Node<T>?
    
    var isLLEmpty: Bool {
        return front == nil
    }
    
    var firstNode: Node<T>? {
        return front
    }
    
    var lastNode: Node<T>? {
        return rear
    }
    
    var length: Int {
        
        var tempHead = firstNode
        var index = 0
        
        while tempHead != nil {
            index += 1
            tempHead = tempHead?.next
        }
        
        return index
    }
    
    func append(fromFront value: T) {
        
        let newNode = Node.init(dataVal: value)
        
        if headPointer != nil {
            headPointer?.next = newNode
            headPointer = headPointer?.next
        }
        else {
            front = newNode
            headPointer = front
        }
        
        rear = newNode
    }
    
    func display() {
        
        var front = firstNode
        var index = 0
        while front != nil {
            print("Index \(index) has element \(String(describing: (front?.dataVal)!))")
            front = front?.next
            index += 1
        }
    }
    
    func insert(item val: T, atIndex index: Int) {
       
        guard index >= 0  else {
            print("Invalid Index \(index)")
            return
        }
        
        guard (index == 0 || index <= length ) else {
            print("Out of bound index, length \(length)")
            return
        }
        
        let newNode = Node.init(dataVal: val)
        
        // If list is empty then make 0th item as first Node
        if isLLEmpty {
            front = newNode
            headPointer = newNode
            rear = newNode
        }
        else {
            var idx = 0
            var localhead = firstNode
            var previous = localhead
            while localhead != nil {
                
                if idx == index {
                    previous?.next = newNode
                    newNode.next = localhead
                    return
                }
                
                idx += 1
                previous = localhead
                localhead = localhead?.next
            }
            
            if idx == length {
                previous?.next = newNode
                newNode.next = localhead
            }
        }
    }
    
    func item(atIndex index: Int) -> T? {
        
        guard index >= 0 else {
            print("Invalid index \(index)")
            return nil
        }
        
        guard index < length else {
            print("Index out of bound \(index), Max length \(length)")
            return nil
        }
        
        var idx = 0
        
        var headPointer = firstNode
        
        while headPointer != nil {
            if idx == index {
                return headPointer?.dataVal
            }
            idx += 1
            headPointer = headPointer?.next
        }
        
        return nil
    }
    
    func reverse() -> Node<T>? {
                
        var headPointer = firstNode?.next
        var tailPointer = firstNode
        var aheadPointer : Node<T>?
        
        while headPointer != nil {

            aheadPointer = headPointer?.next
            
//            print("tail \(String(describing: tailPointer?.dataVal))  headed \(String(describing: headPointer?.dataVal)) , ahead \(String(describing: aheadPointer?.dataVal))")
            
            headPointer?.next = tailPointer
            
            tailPointer = headPointer

            headPointer = aheadPointer
        }
        
        firstNode?.next = nil
        
        return tailPointer
    }
}


extension SingllyLinkedList: CustomStringConvertible {
    var description: String {
        var text = "["
        
        
        var headPointer = firstNode
        
        while headPointer != nil {
            text = text + "\(String(describing: headPointer?.dataVal))"
            headPointer = headPointer?.next
            if headPointer != nil {
                text += ", "
            }
        }
        text = text + "]"
        return text
    }
    
}

var sll = SingllyLinkedList<String>()

sll.insert(item: "Zero", atIndex: 0)
sll.append(fromFront: "first")
sll.append(fromFront: "second")
sll.append(fromFront: "Third")
sll.append(fromFront: "Forth")
sll.insert(item: "Fifth", atIndex: 5)
sll.insert(item: "Sixth", atIndex: 6)
sll.insert(item: "seven", atIndex: 7)
sll.insert(item: "nine", atIndex: 8)

sll.display()

print("---- Index finder ----")
let index = 5
let item = sll.item(atIndex: index)
if let i = item {
    print("Item at index \(index) is \(i)")
}

print(sll.description)

let reverseList = sll.reverse()


//print("Reverse list \(reverseList?.dataVal as Any), front node \(String(describing: sll.firstNode?.next?.dataVal))")
//sll.display()

Node.displayLinked(node: reverseList)





