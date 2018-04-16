//
//  CarArrayController.swift
//  NSRCarLot
//
//  Created by Nasir Ahmed Momin on 16/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class CarArrayController: NSArrayController {

    override func newObject() -> Any {
        let newObj = super.newObject() as! NSObject
        let now = Date()
        newObj.setValue(now, forKey: "datePurchased")
        return newObj
    }
    
}
