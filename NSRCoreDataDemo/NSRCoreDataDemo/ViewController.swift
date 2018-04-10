//
//  ViewController.swift
//  NSRCoreDataDemo
//
//  Created by Nasir Ahmed Momin on 10/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
    
        let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUserRecord = NSManagedObject(entity: userEntity!, insertInto: context)
        
        newUserRecord.setValue("Ayesha", forKey: "username")
        newUserRecord.setValue("ayesha", forKey: "password")
        newUserRecord.setValue(29, forKey: "age")
        
        do {
            try! context.save()
        }
        catch {
            print("Problem in saving user record");
        }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                let userName = data.value(forKey: "username") as! String
                print("UserName \(userName)")
            }
        }
        catch {
            print("Failed")
        }
        
        
        
    }
}

