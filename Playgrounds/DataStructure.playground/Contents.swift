//: Playground - noun: a place where people can play

class Node<G> {
    
    var value: G
    
    var next: Node<G>?
    var previous: Node<G>?
    
    init(_ value: G) {
        self.value = value
    }
}

protocol Linkable {
    
    associatedtype G
    var first: Node<G>? { get }
    var last: Node<G>? { get }
    var isEmpty: Bool { get }
    
    func display()
    func append(_ value: G)
    func value(atIndex index: Int) -> G?
    func insert(value v: G, atIndex index: Int)
    func remove(atIndex index: Int) ->G?
    
}


class LinkedList<G> : Linkable {
    
    private var front: Node<G>?
    private var rear: Node<G>?
    
    var first: Node<G>? {
        return front
    }
    
    var last: Node<G>? {
        return rear
    }
    
    var isEmpty: Bool {
        return front == nil || rear == nil
    }
    
    func append(_ value: G) {
        let newNode = Node.init(value)
        
        if let frontNode = front {
            
            frontNode.next = newNode
            newNode.previous = frontNode
        }
        else {
            rear = newNode
        }
        
        front = newNode
    }
    
    func display() {
        
        var frontNode = first
        print("--------- Display Element ---------------")
        
        while frontNode?.previous != nil {
            print("Element \(String(describing: frontNode?.value))")
            frontNode = frontNode?.previous
        }
        
        print("Element \(String(describing: frontNode?.value))")
        print("-----------------------------------------")

    }
    // 5378
    func value(atIndex index: Int) -> G? {
        
        if isEmpty == false {
            var idx = 0
            var rear = last
            
            while rear?.next != nil {
                if idx == index {
                    return rear?.value
                }
                rear = rear?.next
                idx += 1
            }
        }
        
        return nil
    }
    
    func insert(value v: G, atIndex index: Int) {
        
        if isEmpty {
            print("empty")
        }
        else {
            var idx = 0
            
            var rearNode = last
            var tempRear = rearNode
            
            while rearNode?.next != nil {
                
                if idx == index {
                    
                    let newNode = Node.init(v)
                    
                    tempRear?.next = newNode
                    newNode.next = rearNode
                    newNode.previous = rearNode?.previous
                    rearNode?.previous = newNode
                    return
                }
                tempRear = rearNode
                rearNode?.next = rearNode
                idx += 1
            }
            
        }
        
    }
    
    func remove(atIndex index: Int) -> G? {
        
        
        return nil
    }
}

var ll = LinkedList<String>()

print("value : \(ll.value(atIndex: 0))")

ll.append("First")
ll.append("Second")
ll.append("Third")
ll.append("Fourth")

ll.insert(value: "rrrr", atIndex: 2)
ll.insert(value: "drty", atIndex: 3)


print("value : \(ll.value(atIndex: 1))")

ll.display()
