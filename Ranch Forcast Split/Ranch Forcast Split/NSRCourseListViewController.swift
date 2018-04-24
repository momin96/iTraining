//
//  NSRCourseListViewController.swift
//  Ranch Forcast Split
//
//  Created by Nasir Ahmed Momin on 24/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

protocol NSRCourseListViewControllerDelegate: class {
    func courseListViewController(_ listController: NSRCourseListViewController, selectedCourse selected: NSRCourse?) -> Void
}

class NSRCourseListViewController: NSViewController {

    
    weak var delegate : NSRCourseListViewControllerDelegate? = nil
    
    @objc dynamic var courses : [NSRCourse] = []
    let fetcher = NSRScheduleFetcher()
    
    @IBOutlet var arrayController : NSArrayController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        fetcher.fetchCoursesUsingCompletionHandler { (result) in
            switch result {
            case .Success(let courses) :
                self.courses = courses
            case .Failure(let err) :
                NSAlert(error: err).runModal()
                self.courses = []
            }
        }
        
    }
    
    @IBAction func selectCourse(_ sender: Any) {
        let selectedCourse = self.arrayController.selectedObjects.first as! NSRCourse?
        delegate?.courseListViewController(self, selectedCourse: selectedCourse)
    }
    
    
}
