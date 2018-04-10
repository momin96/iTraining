//
//  ViewController.swift
//  NSRAccessControl
//
//  Created by Nasir Ahmed Momin on 02/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        let privateObj = PrivateClass()
//        privateObj.privateMethod()
//        privateObj.privateVar = "privateText"
//        privateObj.publicVar = "PublicText"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


open class OpenClass {
    var openVar : String?
    func openMethod () {    }
}


internal class InternalClass {
    var internalVar : String?
    func internalMethod () {    }
    
}

fileprivate class FilePrivateClass {
    var fileprivateVar : String?
    func fileprivateMethod () {    }
    
}
