//
//  NSRCourse.swift
//  RanchForcast
//
//  Created by Nasir Ahmed Momin on 20/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

@objc class NSRCourse: NSObject {
    @objc dynamic let title : String
    @objc dynamic let url : URL
    @objc dynamic let nextStartDate : Date
    
    init(title : String, url : URL, nextStartDate : Date) {
        self.title = title
        self.url = url
        self.nextStartDate = nextStartDate
    }
    
}
