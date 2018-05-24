//
//  NSRLogger.swift
//  NSR Logger
//
//  Created by Nasir Ahmed Momin on 15/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Foundation
import UIKit

private var viewControllersCollection : [String : ViewLogger] = [:]

private var classes = [AnyClass]()


class NSRLogger: NSObject {
    
    override init() {
        
        UIViewController.configureViewLogger()
        
        let operationQueue = OperationQueue()
        
        operationQueue.addOperation {
            classes = objc_getClasses()
            UIViewController.configureScroller()
        }
    }
}

extension UIViewController {
    
    
    // MARK: UIViewController Swizzle
    
    class func configureViewLogger() {
        
        // Selectors
        let appearOriginalSEL = #selector(UIViewController.viewWillAppear(_:))
        let appearSwizzledSEL = #selector(UIViewController.swizzledViewWillAppear(_:))
        
        // Methods
        let appearOrigionalMethod = class_getInstanceMethod(UIViewController.self, appearOriginalSEL)
        let appearSwizzledMethod = class_getInstanceMethod(UIViewController.self, appearSwizzledSEL)
        
        let didAppearMethod = class_addMethod(self, appearOriginalSEL, method_getImplementation(appearSwizzledMethod!), method_getTypeEncoding(appearSwizzledMethod!))
        
        if didAppearMethod {
            class_replaceMethod(self, appearSwizzledSEL, method_getImplementation(appearOrigionalMethod!), method_getTypeEncoding(appearOrigionalMethod!))
        }
        else {
            // Implementation
            method_exchangeImplementations(appearOrigionalMethod!, appearSwizzledMethod!)
        }
        
        
        // Selectors
        let disappearOrigionalSEL = #selector(UIViewController.viewWillDisappear(_:))
        let disappearSwizzledSEL = #selector(UIViewController.swizzledViewWillDidappear(_:))
        
        // Methods
        let disappearOrigionalMethod = class_getInstanceMethod(UIViewController.self, disappearOrigionalSEL)
        let disappearSizzeledMethod = class_getInstanceMethod(UIViewController.self, disappearSwizzledSEL)
        
        let didDisappearMethod = class_addMethod(self, disappearOrigionalSEL, method_getImplementation(disappearSizzeledMethod!), method_getTypeEncoding(disappearSizzeledMethod!))
        
        if didDisappearMethod {
            class_replaceMethod(self, disappearSwizzledSEL, method_getImplementation(disappearOrigionalMethod!), method_getTypeEncoding(disappearOrigionalMethod!))
        }
        else {
            // Implementation
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
    
    // MARK: UIScrollView swizzle
    class func configureScroller () {
        
        scrollBeginDeceleratingConfig()
        
        scrollEndDeceleratingConfig()
        
    }
    
    // MARK: Swizzled Method
    @objc func swizzleScrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("swizzle ScrollView Will Begin Decelerating")
        
        // Passing control to original method
        self.swizzleScrollViewWillBeginDecelerating(scrollView)
    }
    
    @objc func swizzleScrollViewWillEndDecelerating(_ scrollView: UIScrollView) {
        print("swizzle ScrollView Will End Decelerating")
    }
    
    
    // MARK: Config support methods
    
    private class func scrollBeginDeceleratingConfig () {
        
        // Selectors
        let descSEL = #selector(UIScrollViewDelegate.scrollViewWillBeginDecelerating(_:))
        let descSwizzleSEL = #selector(self.swizzleScrollViewWillBeginDecelerating(_:))

        let didBeginDeceleratingRespond : [AnyClass]? = didClassConfirms(toProtocol: UIScrollViewDelegate.self, andRespondToSelector: descSEL)
        
        if let deceleratingClasses = didBeginDeceleratingRespond {

            for deceleratingClass in deceleratingClasses {
                // Methods
                let beginDeceleratingOrigionalMethod = class_getInstanceMethod(deceleratingClass, descSEL)
                let beginDeceleratingSwizzelMethod = class_getInstanceMethod(self, descSwizzleSEL)
                
                if let originalMethod = beginDeceleratingOrigionalMethod, let swizzleMethod = beginDeceleratingSwizzelMethod {
                    // Implementation
                    method_exchangeImplementations(originalMethod, swizzleMethod)
                }
                else {
                    debugFatalError("Nil originalMethod or swizzleMethod")
                }
            }

        }
        else {
            debugFatalError("Nil didBeginDeceleratingRespond")
        }
    }
    
    private class func scrollEndDeceleratingConfig () {
        
        // Selectors
        let endDeceleratingSEL = #selector(UIScrollViewDelegate.scrollViewDidEndDecelerating(_:))
        let endDeceleratingSwizzleSEL = #selector(self.swizzleScrollViewWillEndDecelerating(_:))

        let didEndDeceleratingRespond : [AnyClass]? = didClassConfirms(toProtocol: UIScrollViewDelegate.self, andRespondToSelector: endDeceleratingSEL)
        
        if let deceleratingClasses = didEndDeceleratingRespond {
            
            for deceleratingClass in deceleratingClasses {

                // Methods
                let methodEndDeceleratingOrigional = class_getInstanceMethod(deceleratingClass, endDeceleratingSEL)
                let methodEndDeceleratingSwizzle = class_getInstanceMethod(self, endDeceleratingSwizzleSEL)
                
                if let origionalMethod = methodEndDeceleratingOrigional, let swizzleMethod = methodEndDeceleratingSwizzle {
                    // Implementation
                    method_exchangeImplementations(origionalMethod, swizzleMethod)
                }
                else {
                    debugFatalError("Nil origionalMethod or swizzleMethod")
                }
            }
        }
        else {
            debugFatalError("Nil didEndDeceleratingRespond")
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

// MARK: Support methods

/**
 Check which class confirm to specified protocol, if confirms,
 then check class can respond to selector passed.
 
 
 - Parameter confrimProtocol: Protocol name that need to be confirmed by many classes.
 
 - Parameter selector: Selector that need to respond to against many classes.
 
 - Returns: Optional of type AnyClass
 */
private func didClassConfirms(toProtocol confrimProtocol : Protocol, andRespondToSelector selector: Selector) -> [AnyClass]? {
    
    var confirmedClasses : [AnyClass]? = []
    
    print("Selector : \(selector)")
    print("confrimProtocol \(confrimProtocol)")
    var i = 1
    for cls in classes {
        print("cls \(i) \(cls) ")
        i+=1
                
        if class_conformsToProtocol(cls, confrimProtocol){
            if class_respondsToSelector(cls, selector)  {
            print("---------")
            print("cls \(cls)")
            confirmedClasses?.append(cls)
//            return cls
        }
            
        }
    }
    
    return confirmedClasses
}


/**
    Responsible for returning all classes in current platform.
 
 - Returns: Array of AnyClass
*/
private func objc_getClasses() -> [AnyClass] {
    
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

/**
 Perform initentional crash in debug mode
 
 */
private func debugFatalError(_ errMessage : String) {
    #if DEBUG
        fatalError(errMessage)
    #endif
}
