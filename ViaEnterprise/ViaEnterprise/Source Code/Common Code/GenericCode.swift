//
//  GenericCode.swift
//  ViaEnterprise
//
//  Created by Nasir Ahmed Momin on 25/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

let BUTTON_BOTTOM_LINE = "ButtonBottomLine"

extension UIButton {
    
    func setBottomLine(thickness thick :CGFloat?, color: UIColor?) {
        
//        let layerExisits : Bool = (self.layer.sublayers?.contains(where: { (exisLayer) -> Bool in
//            return exisLayer.name == BUTTON_BOTTOM_LINE
//        }))!
        
        let noLayer = self.layer.sublayers?.isEmpty
        
        if noLayer == nil {
            let height: CGFloat = thick ?? 1.0
            let rect = CGRect(x: self.bounds.origin.x,
                              y: (self.bounds.height - height),
                              width: self.bounds.width,
                              height: height)
            
            let bottomLayer  = CALayer()
            bottomLayer.frame = rect
            bottomLayer.name = BUTTON_BOTTOM_LINE
            bottomLayer.backgroundColor = color?.cgColor ?? UIColor.blue.cgColor
            self.layer.addSublayer(bottomLayer)
        }
    }
    
    func bottomLine(ShouldHide hide: Bool) {
        
        guard let sublayer = self.layer.sublayers else { return }
        for bottomLayer in sublayer {
            if bottomLayer.name == BUTTON_BOTTOM_LINE {
                bottomLayer.isHidden = hide
                break;
            }
        }
    }
    

    
}

extension UIView {
    
    func drawBorderOf(thickness thick: CGFloat?, color: UIColor?) {
        self.layer.borderWidth = thick ?? 1.0
        self.layer.borderColor = color?.cgColor ?? UIColor.darkGray.cgColor
    }
}
