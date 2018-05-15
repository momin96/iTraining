//
//  NSRLogger.swift
//  NSR Logger
//
//  Created by Nasir Ahmed Momin on 15/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Foundation
import UIKit

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
        print(" \(className)'s View appears" )

    }
    
    @objc func swizzledViewWillDidappear(_ animated: Bool) {
        print("View disappears")

    }
    
    
}


struct ViewLogger {
    var visibleTime : TimeInterval
    var hiddenTime : TimeInterval
    var delta : TimeInterval
}
