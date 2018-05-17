//: Playground - noun: a place where people can play

import UIKit
import Foundation



let LIMIT = 10

class ModelContainer: NSObject {
    
    var models : [Data] = []
    
    func encryptAndStoreGenericModel (_ genericModel : MyGenericModel) {
        let encryptedModelData = NSKeyedArchiver.archivedData(withRootObject: genericModel)
        
        models.append(encryptedModelData)
        if models.count >= LIMIT {
            
            let modelSlices = models.dropFirst(LIMIT + 1)
            print(models.count)
            //            initAPIServiceCallWithListOfModels(modelSlices)
            
            removeEncyptedObject()
            
        }
    }
    
    func initAPIServiceCallWithListOfModels (_ models : [Data]) {
        print("Service call initiated with list \(models)")
    }
    
    func removeEncyptedObject() {
        models.removeFirst(LIMIT)
        print("Removed models with list : \(models)")
    }
}

class MyGenericModel: NSObject, NSCoding {
    
    var someInt: Int?
    var someString: String?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(someInt!, forKey: "someInt")
        aCoder.encode(someString!, forKey: "someString")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.someInt = aDecoder.decodeObject(forKey: "someInt") as? Int
        self.someString = aDecoder.decodeObject(forKey: "someString") as? String
    }
    
    override init() {
        someInt = 10
        someString = "Exilant"
    }
}

let globalContainer = ModelContainer()
for _ in 0...19 {
    let model = MyGenericModel()
    globalContainer.encryptAndStoreGenericModel(model)
}

globalContainer.models.count


//for _ in 0...16 {
//    let model = MyGenericModel()
//    globalContainer.encryptAndStoreGenericModel(model)
//}
//
//globalContainer.models.count


