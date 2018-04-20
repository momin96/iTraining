//
//  NSRMainViewController.swift
//  RanchForcast
//
//  Created by Nasir Ahmed Momin on 20/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class NSRMainViewController: NSViewController {

    
    let fetcher = NSRScheduleFetcher()
    @objc dynamic var courses : [NSRCourse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetcher.fetchCoursesUsingCompletionHandler { (result) in
            switch result {
            case .Success(let courses) :
                self.courses = courses
            case .Failure(let error) :
                NSAlert(error: error).runModal()
                self.courses = []
            }
        }
    
    }
    
}
