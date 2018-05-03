//
//  Person.swift
//  Interview Demo App
//
//  Created by Nasir Ahmed Momin on 03/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa
@objc(Person)
class Person: NSObject, Comparable {
   
    @objc dynamic var firstName : String
    @objc dynamic var lastName : String
    
    init(fname: String, lname: String) {
        firstName = fname
        lastName = lname
    }
    
    static func <(lhs: Person, rhs:Person) -> Bool{
        return (lhs.firstName < rhs.firstName) && (lhs.lastName < rhs.lastName)
    }
    
}

struct PersonSt: Decodable {
    let firstName : String
    let lastName : String

    private enum codingKeys : String, CodingKey {
        case firstName = "fname"
        case lastName = "lname"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
    }
}


let API_ENDPOINT = "https://api.myjson.com/bins/1hb6a2"

class DataFetcher : NSObject {

    static let shared = DataFetcher()
    let session : URLSession
    private override init() {
        session = URLSession.shared
    }
    
    func getPersonList(_ completionHandler : @escaping ([Person]) -> Void) {
        
        let url = URL(string : API_ENDPOINT)!
        session.dataTask(with: url) { (data, response, err) in
            guard let data = data else {
                completionHandler([])
                return
            }
            guard let httpResponse = response else {
                completionHandler([])
                return
            }
            
            if (httpResponse as! HTTPURLResponse).statusCode == 200 {
                // Data is availalbe & status code is valid
                do {
                    let decoder = JSONDecoder()
                    let pst = try decoder.decode([PersonSt].self, from: data)
                    
                    let persons = pst.map({ (personSt) -> Person in
                        let person = Person(fname: personSt.firstName, lname: personSt.lastName)
                        return person
                    })
                    
                    completionHandler(persons);
                }
                catch let err {
                    print("Error \(err)")
                    completionHandler([])
                }
            }
        }.resume()
        
    }
    
    
    
    
    
    
    func disposeDatafetcher () {
//        session = nil
    }
    
    
}
