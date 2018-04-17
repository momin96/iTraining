//
//  NSRDieView.swift
//  Dice
//
//  Created by Nasir Ahmed Momin on 17/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class NSRDieView: NSView {

    
    var intValue : Int? = 5 {
        didSet {
            needsDisplay = true
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let backgroundColor = NSColor.lightGray;
        backgroundColor.set()
        NSBezierPath.fill(bounds)
            
            
//        NSColor.green.set()
//        let path = NSBezierPath()
//        path.move(to: NSPoint(x: 0, y: 0))
//        path.line(to: NSPoint.init(x: bounds.width, y: bounds.height))
//        path.stroke()
        
        drawDieWithSize(bounds.size)
        
    }
 
    
    func metricForSize(_ size : CGSize) -> (edgeLength : CGFloat, dieFrame : CGRect) {
        
        let edgeLength = min(size.width, size.height)
        let padding = edgeLength / 10.0
       
        let drawingBounds = CGRect(x: 0, y: 0, width: edgeLength, height: edgeLength)
        let dieFrame = drawingBounds.insetBy(dx: padding, dy: padding)
        
        return (edgeLength, dieFrame)
    }
    
    
    func drawDieWithSize(_ size : CGSize) {
        
        if let intValue = intValue {
            let (edgeLength, dieFrame) = metricForSize(size)
            
            let cornerRadius : CGFloat = edgeLength / 5.0
            
            let dotRadius = edgeLength / 12.0
            let dotFrame = dieFrame.insetBy(dx: dotRadius * 2.5, dy: dotRadius * 2.5)
            
            NSColor.white.set()
            let path = NSBezierPath(roundedRect: dieFrame, xRadius: cornerRadius, yRadius: cornerRadius)
            path.fill()
            
            NSColor.black.set()
            
            func drawDot(u :  CGFloat, v : CGFloat) {
                
                let dotOrigin = CGPoint(x: dotFrame.minX + dotFrame.width * u, y: dotFrame.minY + dotFrame.height * v)
                let dotRect = CGRect(origin: dotOrigin, size: NSZeroSize).insetBy(dx: -dotRadius, dy: -dotRadius)
                NSBezierPath(ovalIn: dotRect).fill()
            }
            
            if find([1,2,3,4,5,6], value: intValue) != nil {
                if find([1,3,5], value: intValue) != nil {
                    drawDot(u: 0.5, v: 0.5)
                }
                if find([2,3,4,5,6], value: intValue) != nil {
                    drawDot(u: 0, v: 1)
                    drawDot(u: 1, v: 0)
                }
                if find([4,5,6], value: intValue) != nil {
                    drawDot(u: 1, v: 1)
                    drawDot(u: 0, v: 0)
                }
                if intValue == 6 {
                    drawDot(u: 0, v: 0.5)
                    drawDot(u: 1, v: 0.5)
                }
            }
        }
    }
    
    func find(_ list : [Int], value : Int) -> Int? {
        if list.contains(value) {
            return list.index(of: value)
        }
        return nil;
    }
    
}
