//
//  PublicClass.swift
//  NSRAccessControl
//
//  Created by Nasir Ahmed Momin on 02/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

public class PublicClass {
    public var publicVar : String?
    public func publicMethod () {    }
    
    private var privateVar : String?
    fileprivate var fileprivateVar : String?
}

class SomeRandomClass {
    let publicObj = PublicClass()
    
    init() {
        publicObj.fileprivateVar = "fileprivateText"
//        publicObj.privateVat = "privateText"
        publicObj.publicMethod();
    }
}

extension PublicClass {


}

extension SomeRandomClass {

}
