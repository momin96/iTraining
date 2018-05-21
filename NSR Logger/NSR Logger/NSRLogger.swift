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

class NSRLogger: NSObject {
    
    override init() {
        UIViewController.configureViewLogger()
        UIScrollView.configureScroller()
    }
}

extension UIScrollView {
    
    class func configureScroller () {
    
        let descSEL = #selector(UIScrollViewDelegate.scrollViewWillBeginDecelerating(_:))
        let descSwizzleSEL = #selector(UIScrollView.swizzleScrollViewWillBeginDecelerating(_:))

        var beginDeceleratingOrigionalMethod : Method?
        
       let classes = objc_getClasses()
    
        for cls in classes {
            if class_conformsToProtocol(cls, UIScrollViewDelegate.self) {
                if class_respondsToSelector(cls, descSEL) {
                    print("class \(cls)")
                    print(descSEL)
                    beginDeceleratingOrigionalMethod = class_getInstanceMethod(cls, descSEL)
                }
            }
        }
        
        let beginDeceleratingSwizzelMethod = class_getInstanceMethod(UIScrollView.self, descSwizzleSEL)

        if let originalMethod = beginDeceleratingOrigionalMethod, let swizzleMethod = beginDeceleratingSwizzelMethod {
            method_exchangeImplementations(originalMethod, swizzleMethod)
        }
        
    }
    
    @objc func swizzleScrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("swizzleScrollViewWillBeginDecelerating")
    }
}

func objc_getClasses() -> [AnyClass] {
    
    
    let expectedClassCount = objc_getClassList(nil, 0)
    
    let allClasses = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedClassCount))
    
    let cls = AutoreleasingUnsafeMutablePointer<AnyClass>(allClasses)
    
    let actualClassCount : Int32 = objc_getClassList(cls, expectedClassCount)
    
    var classes = [AnyClass]()
    
    for i in 0..<actualClassCount {
        if let currentClass : AnyClass = allClasses[Int(i)] {
            classes.append(currentClass)
        }
    }
    
    allClasses.deallocate(capacity: Int(expectedClassCount))
    
    return classes
}

extension UIViewController {
    
    class func configureViewLogger() {
        
        let appearOriginalSEL = #selector(UIViewController.viewWillAppear(_:))
        let appearSwizzledSEL = #selector(UIViewController.swizzledViewWillAppear(_:))
        
        let appearOrigionalMethod = class_getInstanceMethod(UIViewController.self, appearOriginalSEL)
        let appearSwizzledMethod = class_getInstanceMethod(UIViewController.self, appearSwizzledSEL)
        
        let didAppearMethod = class_addMethod(self, appearOriginalSEL, method_getImplementation(appearSwizzledMethod!), method_getTypeEncoding(appearSwizzledMethod!))
        
        if didAppearMethod {
            class_replaceMethod(self, appearSwizzledSEL, method_getImplementation(appearOrigionalMethod!), method_getTypeEncoding(appearOrigionalMethod!))
        }
        else {
            method_exchangeImplementations(appearOrigionalMethod!, appearSwizzledMethod!)
        }
        
        
        
        let disappearOrigionalSEL = #selector(UIViewController.viewWillDisappear(_:))
        let disappearSwizzledSEL = #selector(UIViewController.swizzledViewWillDidappear(_:))
        
        
        let disappearOrigionalMethod = class_getInstanceMethod(UIViewController.self, disappearOrigionalSEL)
        let disappearSizzeledMethod = class_getInstanceMethod(UIViewController.self, disappearSwizzledSEL)
        
        let didDisappearMethod = class_addMethod(self, disappearOrigionalSEL, method_getImplementation(disappearSizzeledMethod!), method_getTypeEncoding(disappearSizzeledMethod!))
        
        if didDisappearMethod {
            class_replaceMethod(self, disappearSwizzledSEL, method_getImplementation(disappearOrigionalMethod!), method_getTypeEncoding(disappearOrigionalMethod!))
        }
        else {
            method_exchangeImplementations(disappearOrigionalMethod!, disappearSizzeledMethod!)
        }
    }
    
    
    @objc func swizzledViewWillAppear(_ animated: Bool) {
        
        let className = NSStringFromClass(self.classForCoder)

        let viewLoggerObject = ViewLogger(viewVisibleTime: Date())
        
        viewControllersCollection.updateValue(viewLoggerObject, forKey: className)
    }
    
    @objc func swizzledViewWillDidappear(_ animated: Bool) {

        let className = NSStringFromClass(self.classForCoder)

        var viewLoggerObject = viewControllersCollection[className]
        
        viewLoggerObject?.calculateViewDeltaWith(viewHiddenTime: Date())
        
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
