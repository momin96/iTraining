//
//  NSRNavigationController.swift
//  NSRTheFirstiOSApp
//
//  Created by Nasir Ahmed Momin on 20/03/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import UIKit

class NSRNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//extension UIControl {
//    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        let touchView = super.hitTest(point, with: event)
//
//        if touchView != nil {
//            touchOnView(touchView);
//        }
//
//        return touchView
//    }
//}
//
//extension UIScrollView {
//    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        touchOnView(touches.first?.view)
//    }
//
////    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
////        //        print("touchesEnded")
////    }
////
////    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
////        //        print("touchesMoved")
////
////    }
////
////    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
////        //        print("touchesCancelled")
////    }
//}
//
//extension UIView {
//    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        touchOnView(touches.first?.view)
//    }
//
////    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
////        //        print("touchesEnded")
////    }
////
////    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
////        //        print("touchesMoved")
////
////    }
////
////    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
////        //        print("touchesCancelled")
////    }
//}

