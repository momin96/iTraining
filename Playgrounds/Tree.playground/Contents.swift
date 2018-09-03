//: Playground - noun: a place where people can play

final class Node<T> {
    var item : T
    var left : Node<T>?
    var right : Node<T>?
    var parent : Node<T>?
    
    var isRootNode : Bool = false
    
    init(value : T) {
        item = value
    }
}

enum Side {
    case left
    case right
}

protocol TreeImplementor {
    
    associatedtype T
    
    var isEmpty : Bool { get }
    
    func addNode(item : T, side : Side?)
    
    func addNode(newItem bItem: T, side : Side?, ofOldItem oItem:T)
    
    func displayTree(fromNode node: Node<T>?)
    
}

class Tree<T> : TreeImplementor {

    func addNode(newItem item: T, side: Side?, ofOldItem oItem: T) {
        
    }
    
    private var rootNode : Node<T>?
    
    var root : Node<T>? {
        return rootNode
    }
    
    var isEmpty: Bool {
        return rootNode == nil
    }
    
    func addNode(item: T, side: Side?) {
        
        let newNode = Node(value: item)
        
        if isEmpty || side == nil {
            newNode.isRootNode = true
            rootNode = newNode
        }
        else {
            
            newNode.isRootNode = false

            let topNode = rootNode
            
            let s = side!
            
            switch s {
            case .left:
                topNode?.left = newNode
                break
            case .right :
                topNode?.right = newNode
                break
            }
        }
    }
    
    init(rootNode item: T) {
        let node = Node(value: item)
        node.isRootNode = true
        rootNode = node
    }
    
    func displayTree(fromNode node: Node<T>?) {
        
        if node?.left != nil {
            let leftNode = node?.left
            displayTree(fromNode: leftNode)
            return
        }
        else if node?.right != nil {
            let rightNode = node?.right
            displayTree(fromNode: rightNode)
            return
        }
        
        print("Procesed Node : \(String(describing: node?.item))")
    }
    
}

let t = Tree<Int>(rootNode: 5)
t.addNode(item: 4, side: Side.left)
t.addNode(item: 6, side: Side.right)


t.displayTree(fromNode:t.root?.left)
