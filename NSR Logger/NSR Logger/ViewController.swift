//
//  ViewController.swift
//  NSR Logger
//
//  Created by Nasir Ahmed Momin on 15/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let globalContainer = ModelContainer()

        for _ in 0...18 {
            let model = MyGenericModel()
            globalContainer.encryptAndStoreGenericModel(model)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        print("viewWillAppear in ViewController")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        print("viewWillDisappear in ViewController")

    }
    
//    @IBAction func presentController(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondTableViewController")
//        self.present(vc!, animated: true, completion: nil)
//    }
    
}

class SecondTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false

    }
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            
        }
    }
    
    override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("SecondTableViewController scrollViewWillBeginDecelerating")
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("SecondTableViewController scrollViewDidEndDecelerating")
    }
    
}

class FirstViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        scrollView.contentSize = CGSize(width: 500, height: 500)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("FirstViewController scrollViewWillBeginDecelerating")
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("FirstViewController scrollViewDidEndDecelerating")
//    }
}


let LIMIT = 10

class ModelContainer: NSObject {
    
    var models : [Data] = []
    
    func encryptAndStoreGenericModel (_ genericModel : MyGenericModel) {
        let encryptedModelData = NSKeyedArchiver.archivedData(withRootObject: genericModel)
        
        models.append(encryptedModelData)
        if models.count >= LIMIT {
            
            let modelSlices = models.dropLast(LIMIT + 1)
            
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

