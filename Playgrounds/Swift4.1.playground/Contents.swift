

// Synthsize support for Equatable & hashable protocol
struct Person : Equatable {
    var firstName: String
    var lastName: String
    var age: Int
}


func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.age == rhs.age;
}

let paul = Person(firstName: "Paul", lastName: "Hudson", age: 38)
let joanne = Person(firstName: "Joanne", lastName: "Rowling", age: 52)

if paul == joanne {
    print("These people match")
} else {
    print("No match")
}


struct User: Equatable {
    var id: Int
    var username: String
    var password: String
    var jobTitle: String
    var firstName: String
    var lastName: String
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}


extension User : Hashable {
    var hashValue: Int {
        return firstName.hashValue ^ lastName.hashValue
    }
}



// Conditional conformance

protocol Purchaseable {
    func buy()
}

struct Book: Purchaseable {
    func buy() {
        print("You bought a book")
    }
}

//extension Array : Purchaseable {
//
//}


// Recursive constraints on associated types

protocol Employee {
    associatedtype Manager : Employee
    var manager : Manager? {
        get set
    }
    
}


struct BoardMember: Employee {
    var manager: BoardMember?
}

class SeniorDeveloper: Employee {
    var manager: BoardMember?
}

class JuniorDeveloper: Employee {
    var manager: SeniorDeveloper?
}


// Flatmap is now compact map

let array = ["1", "2", "Fish"]
let numbers = array.compactMap { Int($0) }
print(numbers)

