//
//  NSRTiledImageView.swift
//  ImageTiling
//
//  Created by Nasir Ahmed Momin on 17/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

@IBDesignable class NSRTiledImageView: NSView {

    @IBInspectable var image : NSImage?
    let columnCount = 5
    let rowCount = 5
    
    override var intrinsicContentSize: NSSize {
        let furthestFrame = frameForImageAt(logicalX: columnCount - 1, logicalY: rowCount - 1)
        return NSSize(width: furthestFrame.maxX, height: furthestFrame.maxY)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        if let image = image {
            for x in 0..<columnCount {
                for y in 0..<rowCount {
                    let frame = frameForImageAt(logicalX: x, logicalY: y)
                    image.draw(in: frame)
                }
            }
        }
    }
    
    
    func frameForImageAt(logicalX lX :Int, logicalY lY : Int) -> CGRect {
        let spacing = 10
        let width = 100
        let height = 100
        let x = (spacing + width) * lX
        let y = (spacing + height) * lY
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
}
