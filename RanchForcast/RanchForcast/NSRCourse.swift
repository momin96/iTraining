//
//  NSRCourse.swift
//  RanchForcast
//
//  Created by Nasir Ahmed Momin on 20/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

struct Upcoming: Codable {
    var startDate : String
    var endDate : String
    var instructors : String
    var location : String
    
    private enum Codngkeys: String, CodingKey {
        case startDate  = "start_date"
        case endDate    = "end_date"
        case instructors = "instructors"
        case location    = "location"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Codngkeys.self)
        startDate = try values.decode(String.self, forKey: .startDate)
        endDate = try values.decode(String.self, forKey: .endDate)
        instructors = try values.decode(String.self, forKey: .instructors)
        location = try values.decode(String.self, forKey: .location)
    }
}

struct Course: Codable {
    let title: String
    let url: String
    let upcoming: [Upcoming]
}

struct Courses: Codable {
    var courses: [Course]
}

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
