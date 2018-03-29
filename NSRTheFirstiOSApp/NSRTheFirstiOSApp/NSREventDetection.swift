//
//  NSREventDetection.swift
//  NSRTheFirstiOSApp
//
//  Created by Nasir Ahmed Momin on 20/03/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import UIKit

extension UIApplication {
    func configureEventDetection () {
        let origionalMethod = class_getInstanceMethod(UIApplication.self, #selector(UIApplication.sendAction(_:to:from:for:)))
        let swizzledMethod = class_getInstanceMethod(UIApplication.self, #selector(UIApplication.swizzledSendAction(_:to:from:for:)))
        
        method_exchangeImplementations(origionalMethod!, swizzledMethod!);
    }
    
    
    @objc func swizzledSendAction(_ action:Selector, to target: Any?, from sender: Any?, for event: UIEvent?) -> Bool {
        
        if let target = target, let sender = sender, let event = event {
            print(action, type(of: target), event)
        }
        return self.swizzledSendAction(action, to: target, from: sender, for: event);
    }
}

extension UIControl {
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let touchView = super.hitTest(point, with: event)
        
        if touchView != nil {
            touchOnView(touchView);
        }
        
        return touchView
    }
}

extension UITextView : UIScrollViewDelegate {
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("textview scrolling...")
    }
}

extension UIScrollView : UIScrollViewDelegate {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchOnView(touches.first?.view)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrolling...")
    }
    
    
    //    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        //        print("touchesEnded")
    //    }
    //
    //    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        //        print("touchesMoved")
    //
    //    }
    //
    //    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        //        print("touchesCancelled")
    //    }
}




extension UIView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchOnView(touches.first?.view)
    }
    
    //    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        //        print("touchesEnded")
    //    }
    //
    //    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        //        print("touchesMoved")
    //
    //    }
    //
    //    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        //        print("touchesCancelled")
    //    }
}

private func touchOnView(_ touchView : UIView?) {
    
    var touchResponder : UIResponder?
    touchResponder = touchView!
    while (touchResponder != nil) {
        if (touchResponder?.isKind(of: UIViewController.self))! {
            let controller          = touchResponder as! UIViewController
            let viewString          =  NSStringFromClass((touchView?.classForCoder)!)
            let controllerString    =  NSStringFromClass(controller.classForCoder)
            print("Touch on \(viewString) of \(controllerString)")
            break;
        }
        else {
            touchResponder = touchResponder?.next
        }
    }
}



