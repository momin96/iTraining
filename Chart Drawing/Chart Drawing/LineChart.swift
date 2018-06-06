//
//  LineChart.swift
//  Chart Drawing
//
//  Created by Nasir Ahmed Momin on 04/06/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa


let axisWidth : CGFloat = 1

let lineMargin : CGFloat = 35

let textPadding : CGFloat = 25

let pointArea : CGFloat = 10

let ZERO = 0

class LineChart: NSView, AxisPoint {
    

    
    private var lineColor : NSColor = NSColor.blue

    // MARK: public properties
    public var inputData = [[String]]()
    
    
    // MARK: Private properties
    
    private var horizontalBottomMeasurer : NSView?
    
    private var verticalLeftMeasurer : NSView?
    
    private var points = [NSPoint]()
    
    private var startpoint : CGPoint = CGPoint(x: lineMargin, y: lineMargin)
    
    
    // MARK: System provided
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        
        calculateAxis()
        calculateDOTPointForVerticalAndhorizontalAxis()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)

    }
    
    // MARK:Public functions
    public func renderLineChart() {
        
    }
    

    
    // MARK: Private functions
    
    private func calculateDOTPointForVerticalAndhorizontalAxis () {
        
        let count = inputData.count
        
        let verticalSegment : Int = Int(self.frame.height - pointArea) / count
        var verticalPoints = ZERO
        
        let ppi = pointPerInput(self.frame.height, inputData: inputData)
        
        for input in inputData {
            
            let vInput = input.first!
            let hInput = input.last!
            
            let x : Int = ppi * Int(input[1])!

            // Vertical left side seperator line
            verticalPoints += verticalSegment    // 0+50,50+50,100+50.....200+50
            
            let verticalLinePoint = CGPoint(x: (lineMargin - textPadding),
                                            y: CGFloat(verticalPoints) - pointArea)

            let horizontalLinePoint = CGPoint(x: CGFloat(x) - pointArea,
                                              y: (lineMargin - textPadding))
            
            
            writeAxisText(vInput, onPoint: horizontalLinePoint)
            
            writeAxisText(hInput, onPoint: verticalLinePoint)

            
            let point = CGPoint(x: CGFloat(x), y: CGFloat(verticalPoints))
            drawLineOnChart(withPoint: point)
            
        }
    }
    
    
    
    // MARK: Support Method

    private func pointPerInput(_ maxFrame: CGFloat, inputData: [[String]]) -> Int {
        
        let output = inputData.map { inp in
            return Int(inp[1])!
        }
        
        let maxValue = output.reduce(output[0], { max($0, $1) })
        
        let ppi = Int(maxFrame) / maxValue  // 250/50 = 5
        
        return ppi
    }
    
    //MARK: Protocol Implementation

    func drawAxis(onFrame rect : CGRect) {
        
        NSGraphicsContext.saveGraphicsState()
        NSColor.red.set()
        let bPath = NSBezierPath(rect: rect)
        bPath.fill()
        NSGraphicsContext.restoreGraphicsState()
    }
    
    func drawPoint(_ point: NSPoint) {
        
        let rect = CGRect(x: point.x - pointArea / 2,
                          y: point.y - pointArea / 2,
                          width: pointArea,
                          height: pointArea)
        
        NSGraphicsContext.saveGraphicsState()
        
        NSColor.orange.set()
        let path = NSBezierPath(roundedRect: rect,
                                xRadius: pointArea/2,
                                yRadius: pointArea/2)
        path.fill()
        
        NSGraphicsContext.restoreGraphicsState()
        
    }
    
    func drawLineOnChart(withPoint point: CGPoint) {
        
        drawPoint(point)
        
        NSGraphicsContext.saveGraphicsState()
        lineColor.set()
        let path = NSBezierPath()
        path.move(to: startpoint)
        path.line(to: point)
        path.lineWidth = axisWidth
        path.stroke()
        NSGraphicsContext.restoreGraphicsState()
        startpoint = point
    }
    
    func calculateAxis() {
        let verticalAxisLine : CGRect = CGRect(x: lineMargin,
                                               y: lineMargin,
                                               width: axisWidth,
                                               height: self.frame.height - lineMargin)
        drawAxis(onFrame: verticalAxisLine)
        
        let horizontalAxisLine = CGRect(x: lineMargin,
                                        y: lineMargin,
                                        width: self.frame.width - lineMargin,
                                        height:axisWidth )
        drawAxis(onFrame: horizontalAxisLine)
        
    }
    
    func writeAxisText(_ text: String, onPoint point: CGPoint) {
        
        let textLabel = NSTextField(string: text)
        textLabel.sizeToFit()
        textLabel.backgroundColor = NSColor.clear
        textLabel.isBordered = false
        textLabel.setFrameOrigin(point)
        self.addSubview(textLabel)
    }
}

protocol Axis {
    
    func calculateAxis()
    
    func drawAxis(onFrame rect : CGRect)
}


protocol AxisPoint : Axis {
    func drawPoint(_ point: NSPoint)

    func drawLineOnChart(withPoint point : CGPoint)
    
    func writeAxisText(_ text : String, onPoint point: CGPoint)
}



