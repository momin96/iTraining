//
//  NSRMainSplitViewController.swift
//  Ranch Forcast Split
//
//  Created by Nasir Ahmed Momin on 24/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class NSRMainSplitViewController: NSSplitViewController, NSRCourseListViewControllerDelegate {
    var masterViewController : NSRCourseListViewController {
        let masterItem = splitViewItems[0]
        return masterItem.viewController as! NSRCourseListViewController
    }
    
    var detailViewController : NSRWebViewController {
        let detailItem = splitViewItems[1]
        return detailItem.viewController as! NSRWebViewController
    }
    
    let defaultURL = URL(string: "http://www.bignerdranch.com/")!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        masterViewController.delegate = self
        
        detailViewController.loadURL(defaultURL)
    }
    
    func courseListViewController(_ listController: NSRCourseListViewController, selectedCourse selected: NSRCourse?) {
        if let course = selected {
            detailViewController.loadURL(course.url)
        }
        else {
            detailViewController.loadURL(defaultURL)
        }
    }
    
    
}
