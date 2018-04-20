//
//  NSRMainViewController.swift
//  RanchForcast
//
//  Created by Nasir Ahmed Momin on 20/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class NSRMainViewController: NSViewController, NSTableViewDelegate {

    @IBOutlet weak var arrayController: NSArrayController!
    @IBOutlet weak var tableView: NSTableView!
    
    let fetcher = NSRScheduleFetcher()
    @objc dynamic var courses : [NSRCourse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        tableView.delegate = self
        tableView.doubleAction = #selector(openClass(_:))
        
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
    
    @objc func openClass(_ sender : Any) {
        if let course = arrayController.selectedObjects.first as? NSRCourse {
            NSWorkspace.shared.open(course.url)
        }
    }
    
}
