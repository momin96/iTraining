//
//  NSRCourse.swift
//  RanchForcast
//
//  Created by Nasir Ahmed Momin on 20/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class NSRCourse: NSObject {
    let title : String
    let url : URL
    let nextStartDate : Date
    
    init(title : String, url : URL, nextStartDate : Date) {
        self.title = title
        self.url = url
        self.nextStartDate = nextStartDate
    }
    
}
