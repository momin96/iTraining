//: Playground - noun: a place where people can play

import Foundation

let API_ENDPOINT = "http://www.mocky.io/v2/5aa703fe2f000098008ea42b"

enum FamilyStature: String, Decodable {
    case GrandFather    = "Grand Father"
    case GrandMother    = "Grand Mother"
    case Father         = "Father"
    case Mother         = "Mother"
    case Son            = "Son"
    case Dauther        = "Dauther"
    case SonInLaw       = "Son In Law"
    case DautherInLaw   = "Dauther In Law"
    case Cousin         = "Cousin"
    case Friend         = "Friend"
    case Other          = "Other"
}



struct Member: Decodable {
    let name: String? // Nasir
    let age: Int?   // 29
    let stature: FamilyStature?
}

struct Family: Decodable {
    let name: String?
    let address: String?
    let familyHead: String?
    let children: [Member]?
    let elders: [Member]?
}

class NSRDataFetcher: NSObject {
    
    static let shared = NSRDataFetcher()
    let session : URLSession
    override init() {
        print("Init")
        session = URLSession.shared
    }
    
    func getRequestData(_ completionHandler : @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string : API_ENDPOINT)!
        print("Get data \(session), \(url)")

        session.dataTask(with: url) { (data, response, err) in
            print("response \(response)")
            completionHandler(data, response, err)
            }.resume()
    }
}


NSRDataFetcher.shared.getRequestData { (data, response, err) in
    print(data!)
    guard let data = data else {
        return
    }
    
    guard let httpResponse = response else {
        return
    }
    
    if (httpResponse as! HTTPURLResponse).statusCode == 200 {
        // Data is availalbe & status code is valid
        
                        do {
                            let decoder = JSONDecoder()
                            let families = try decoder.decode(Family.self, from: data)
                            print(families as Any)
//                            let persons = pst.map({ (personSt) -> Person in
//                                let person = Person(fname: personSt.firstName, lname: personSt.lastName)
//                                return person
//                            })
        
                        }
                        catch let err {
                            print("Error \(err)")
                        }
    }
}









