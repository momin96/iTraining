//
//  LineChart.swift
//  Chart Drawing
//
//  Created by Nasir Ahmed Momin on 04/06/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa


let lineWidth : CGFloat = 5
let lineMargin : CGFloat = 5
let pointArea : CGFloat = 5

let pointMargin : CGFloat = lineMargin - 2

let ZERO = 0

class LineChart: NSView, HorizontalAxis, VerticalAxis, AxisPoint {
 
    
    
    // MARK: public properties
    public var inputData = [[String]]()
    
    
    // MARK: Private properties
    
    private var horizontalBottomMeasurer : NSView?
    
    private var verticalLeftMeasurer : NSView?
    
    private var points = [NSPoint]()
    
    private var startpoint : CGPoint = CGPoint(x: lineWidth, y: lineMargin)
    
    
    // MARK: System provided
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor.gray.setFill()
        dirtyRect.fill()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    // MARK:Public functions
    public func renderLineChart() {
        
        drawVerticalAxis()
        
        drawHorizontalAxis()
        
        calculateDOTPointForVerticalAndhorizontalAxis()
        
        calculateDOTPointForChart()
        
    }
    
    
    // MARK: Private functions
    
    private func calculateDOTPointForChart() {
        // Drawing points on View
        //                    let point = NSPoint(x: CGFloat(horizontalPoints), y: CGFloat(verticalPoints))
        //                    points.append(point)
        //                    let pointView = createPointView(point)
        //                    self.addSubview(pointView)
    }
    
    private func calculateDOTPointForVerticalAndhorizontalAxis () {
        
        let count = inputData.count
        
        let verticalSegment : Int = Int((verticalLeftMeasurer?.frame.height)!) / count
        var verticalPoints = ZERO
        
        let horizontalSegment : Int = Int((horizontalBottomMeasurer?.frame.width)!) / count
        var horizontalPoints = ZERO
        
        
        let ppi = pointPerInput((verticalLeftMeasurer?.frame.height)!, inputData: inputData)
        
        for input in inputData {
            
            // Vertical left side seperator line
            verticalPoints += verticalSegment    // 0+50,50+50,100+50.....200+50
            
            let verticalLinePoint = CGPoint(x: pointMargin, y: CGFloat(verticalPoints))
            drawAxisPoint(on: verticalLinePoint)
            
            // Horizontal bottom side seperator line
            horizontalPoints += horizontalSegment    // 0+50,50+50,100+50.....200+50
            
            let horizontalLinePoint = CGPoint(x: CGFloat(horizontalPoints), y: pointMargin)
            drawAxisPoint(on: horizontalLinePoint)
         
            
            let x : Int = ppi * Int(input[1])!
            let point = CGPoint(x: CGFloat(x), y: CGFloat(verticalPoints))
            drawLineOnChart(withPoint: point)
            
        }
    }
    
    
    
    // MARK: Support Method
    private func createSeperatorWithRect(_ rect : CGRect) -> NSView{
        let seperator = NSView(frame: rect)
        NSColor.blue.setFill()
//        rect.fill()
        return seperator
    }
    
    

    
    private func createPointView(_ point: NSPoint) -> NSView {
        
        let pointView = NSView(frame: CGRect(x: point.x - pointArea,
                                             y: point.y - pointArea,
                                             width: pointArea * 2,
                                             height: pointArea * 2))
        pointView.layer = CALayer()
        pointView.wantsLayer = true
        pointView.layer?.masksToBounds = true
        pointView.layer?.cornerRadius = 10
        
        NSColor.red.setFill()
        pointView.frame.fill()
        
        
        return pointView
    }
    
    private func drawLine (toPoint point: NSPoint) {
        let path = NSBezierPath()
        path.move(to: startpoint)
        path.line(to: point)
        path.lineWidth = lineWidth - 2
        path.stroke()
        
        startpoint = point
        
    }
    
    
    //MARK: Protocol Implementation
    
    func pointPerInput(_ maxFrame: CGFloat, inputData: [[String]]) -> Int {
        
        let output = inputData.map { inp in
            return Int(inp[1])!
        }
        
        let maxValue = output.reduce(output[0], { max($0, $1) })
        
        let ppi = Int(maxFrame) / maxValue  // 250/50 = 5
        
        return ppi
    }
    
    func drawVerticalAxis() {
        verticalLeftMeasurer?.removeFromSuperview()
        verticalLeftMeasurer = createSeperatorWithRect(CGRect(x: lineMargin,
                                                              y: lineMargin,
                                                              width: lineWidth,
                                                              height: self.frame.height - lineMargin))
        self.addSubview(verticalLeftMeasurer!)
    }
    
    func drawHorizontalAxis() {
        
        horizontalBottomMeasurer?.removeFromSuperview()
        
        horizontalBottomMeasurer = createSeperatorWithRect(CGRect(x: lineMargin,
                                                                  y: lineMargin,
                                                                  width: self.frame.width - lineMargin,
                                                                  height:lineWidth ))
        self.addSubview(horizontalBottomMeasurer!)
    }
    
    
    func drawAxisPoint(on point: NSPoint) {
        
        let pointView : NSView = NSView(frame: CGRect(x: point.x,
                                                      y: point.y,
                                                      width: pointArea,
                                                      height: pointArea))
        NSColor.red.setFill()
//        pointView.frame.fill()
        self.addSubview(pointView)
    }
    
    func drawLineOnChart(withPoint point: CGPoint) {
        
        drawAxisPoint(on: point)
        
        let path = NSBezierPath()
        path.move(to: startpoint)
        path.line(to: point)
        path.lineWidth = lineWidth - 2
        path.stroke()
        
        startpoint = point
    }
    
}


protocol HorizontalAxis {
    func drawHorizontalAxis ()
}

protocol VerticalAxis {
    func drawVerticalAxis()
}

protocol AxisPoint {
    func drawAxisPoint(on point: NSPoint)
    
    func drawLineOnChart(withPoint point : CGPoint)
}



