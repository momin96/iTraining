//
//  NSRLogger.swift
//  NSR Logger
//
//  Created by Nasir Ahmed Momin on 15/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Foundation
import UIKit

var viewControllersCollection : [String : ViewLogger] = [:]

extension UIViewController {
    
    class func configureViewLogger() {
        
        let appearOrigionalMethod = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.viewWillAppear(_:)))
        let appearSwizzledMethod = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.swizzledViewWillAppear(_:)))
        method_exchangeImplementations(appearOrigionalMethod!, appearSwizzledMethod!)
        
        
        let disappearOrigionalMethod = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.viewWillDisappear(_:)))
        let disappearSizzeledMethod = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.swizzledViewWillDidappear(_:)))
        method_exchangeImplementations(disappearOrigionalMethod!, disappearSizzeledMethod!)
    }
    
    
    @objc func swizzledViewWillAppear(_ animated: Bool) {
        
        let className = NSStringFromClass(self.classForCoder)

        let viewLoggerObject = ViewLogger(viewVisibleTime: Date())
        
//        print(" \(className) appears on \(String(describing: viewLoggerObject.viewVisibleTime))" )
        
        viewControllersCollection.updateValue(viewLoggerObject, forKey: className)
    }
    
    @objc func swizzledViewWillDidappear(_ animated: Bool) {

        let className = NSStringFromClass(self.classForCoder)

        var viewLoggerObject = viewControllersCollection[className]
        
        viewLoggerObject?.calculateViewDeltaWith(viewHiddenTime: Date())
        
//        print(" \(className) disappeared on \(String(describing: viewLoggerObject?.viewHiddenTime))" )
        if let delta = viewLoggerObject?.viewDelta {
            let timeString = String.init(format: "%.3f", delta)
            print(" \(className) was visible for \(timeString) seconds" )
        }

    }
}

struct ViewLogger {
    var viewVisibleTime : Date?
    var viewHiddenTime : Date?
    var viewDelta : TimeInterval?
    
    init(viewVisibleTime : Date) {
        self.viewVisibleTime = viewVisibleTime
    }
    
    mutating func calculateViewDeltaWith(viewHiddenTime: Date) {
        self.viewHiddenTime = viewHiddenTime
        self.viewDelta = self.viewHiddenTime?.timeIntervalSince(self.viewVisibleTime!)
    }    
}
