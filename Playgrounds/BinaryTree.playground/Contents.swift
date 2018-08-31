//: Playground - noun: a place where people can play

//: https://www.raywenderlich.com/990-swift-algorithm-club-swift-binary-search-tree-data-structure

//: The Problem with Big-O (O) is, for value type, insertion operation has Time complexity of 0(n), because of copy-on-write issue.

//: Time Complexity of refrence type is O(log n), as No need to copy item everytime

enum BinaryTree<T: Comparable> {
    case empty
    indirect case node(BinaryTree, T, BinaryTree)
    
    
    mutating func insert(newValue: T) {
        guard case .node(_, _, _) = self else {
            self = .node(.empty, newValue, .empty)
            return
        }
        
        self = insertAndReturnBTree(newValue: newValue)
    }
    
    private func insertAndReturnBTree(newValue : T) -> BinaryTree {
        switch self {
        case .empty:
            return .node(.empty, newValue, .empty)
        case let .node(left, oldValue, right) :
            if oldValue > newValue {
                return .node(left.insertAndReturnBTree(newValue: newValue), oldValue, right)
            }
            else {
                return .node(left, oldValue, right.insertAndReturnBTree(newValue: newValue))
            }
        }
    }
    
    // left, process node, right
    func inorderTraverse(process: @escaping (T) -> ()) {
        switch self {
        case .empty:
            return
        case .node(let left, var value, let right):
            left.inorderTraverse(process: process)
            process(value)
            right.inorderTraverse(process: process)
        }
    }
    
    
    //: Process node, go left, go right
    func preorderTraverse(process: @escaping (T) -> ()) {
        switch self {
        case .empty:
            return
        case .node(let left, let val, let right):
            process(val)
            left.preorderTraverse(process: process)
            right.preorderTraverse(process: process)
        }
    }
    // Go left, go right, process node
    func postorderTraverse(_ process: @escaping (T) -> ()) {
        switch self {
        case .empty:
            return
        case .node(let left, let val, let right):
            left.postorderTraverse(process)
            right.postorderTraverse(process)
            process(val)
        }
    }
    
    func search(_ newValue: T) -> BinaryTree? {
        switch self {
        case .empty:
            return nil
        case .node(let left, let oldValue, let right):
            if oldValue == newValue {
                return self
            }
            
            if newValue < oldValue {
                // Go left
                return left.search(newValue)
            }
            else {
                // Go right
                return right.search(newValue)
            }
        }
    }
}



var bt = BinaryTree<Int>.empty
bt.insert(newValue: 10)
bt.insert(newValue: 11)
bt.insert(newValue: 9)
bt.insert(newValue: 15)
bt.insert(newValue: 8)
bt.insert(newValue: 12)

print(bt)

print("In order traversal")
bt.inorderTraverse {
    print($0)
}

print("Pre order traversal")
bt.preorderTraverse { (val) in
    print(val)
}

print("Post order traversal")
bt.postorderTraverse { (val) in
    print(val)
}

print("\nSearched Result")
let searchedResult = bt.search(15)
print(searchedResult)




// leaf node
let f5 = BinaryTree.node(.empty, "5", .empty)
let A = BinaryTree.node(.empty, "a", .empty)
let T10 = BinaryTree.node(.empty, "10", .empty)
let f4 = BinaryTree.node(.empty, "4", .empty)
let t3 = BinaryTree.node(.empty, "3", .empty)
let B = BinaryTree.node(.empty, "b", .empty)


// Left Intermediate node
let minusA10 = BinaryTree.node(A, "-", T10)
let multiple5A10 = BinaryTree.node(f5, "*", minusA10)


// Right Intermedite node

let minus4 = BinaryTree.node(.empty, "-", f4)

let t3ByB = BinaryTree.node(t3, "/", B)
let minus4T3ByB = BinaryTree.node(minus4, "*", t3ByB)

// Root Node
let root = BinaryTree.node(multiple5A10, "+", minus4T3ByB)



extension BinaryTree: CustomStringConvertible {
    var description: String {
        switch self {
        case let .node(left, value, right):
            return "value : \(value), Left = [\(left.description)] Right = [\(right.description)]"
        default:
            return ""
        }
    }
    
    var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty:
            return 0
        }
    }
}

//print(root)
//print("Node Count \(root.count)")
