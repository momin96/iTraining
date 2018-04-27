//: Playground - noun: a place where people can play

import UIKit

let url = URL(string: "https://api.myjson.com/bins/uzagf")!

typealias JSONDictionary = [String: Any]

struct Episode {
    
    let id: String
    let title: String
    
}

extension Episode {
    init?(dictionary : JSONDictionary) {
        guard let id = dictionary["id"] as? String,
                let title = dictionary["title"] as? String else {return nil}
        
        self.id = id;
        self.title = title
    }
    
    static let all = Resource<[Episode]>(url: url, parseJSON:{ json in
        guard let dictionaries =  json as? [JSONDictionary]  else { return nil }
        return dictionaries.flatMap({ json in
            return Episode.init(dictionary: json)
        })
    })
    
//    var media: Resource<Media> {
//        let url = URL(string: "https://api.myjson.com/bins/uzagf")!
//    }
}

extension Resource {
    init(url : URL, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }
}

struct Media { }

struct Resource<A> {
    let url : URL
    let parse: (Data) -> A?
}

final class Webservice {
    
    let session  = URLSession.shared
    
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { data, _, _ in
            
            let result = data.flatMap({ data in
                return resource.parse(data)
            })
            completion(result)
//
//            if let data = data {
//                completion(resource.parse(data))
//            }
//            else {
//                completion(nil)
//            }
        }.resume()
    }
    
}

Webservice().load(resource: Episode.all) { (result) in
    print(result as Any)
}


