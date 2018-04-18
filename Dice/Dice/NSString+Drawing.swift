//
//  NSString+Drawing.swift
//  Dice
//
//  Created by Nasir Ahmed Momin on 18/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

extension NSString {
    func drawCenteredIn(Rect rect : CGRect, attributes attr : [NSAttributedStringKey : Any]) {
        let stringSize = size(withAttributes: attr)
        let points = NSPoint(x: rect.origin.x + (rect.width - stringSize.width) / 2.0,
                             y: rect.origin.y + (rect.height - stringSize.height) / 2.0)
        draw(at: points, withAttributes: attr)
    }
}
