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
    

    // MARK: public properties
    public var inputData = [[String]]()
    
    
    // MARK: Private properties
    
    private var horizontalBottomMeasurer : NSView?
    
    private var verticalLeftMeasurer : NSView?
    
    private var points = [NSPoint]()
    
    private var startpoint : CGPoint = CGPoint(x: lineMargin, y: lineMargin)
    
    private var lineColor : NSColor = NSColor.black
    
    
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

    // MARK: Private functions
    
    private func calculateDOTPointForVerticalAndhorizontalAxis () {
        
        let count = inputData.count
        
        let verticalSegment : Int = Int(self.frame.height - pointArea) / count
        var verticalPoints = ZERO
        
        let horizontalSegment : Int = Int(self.frame.width - pointArea) / count
        var horizontalPoints = ZERO
        
        var pointsList = [CGPoint]()
        
        for i in 0..<count {
            let input = inputData[i]
            let vInput = input.first!
            let hInput = input.last!
            
            // Vertical left side seperator line
            verticalPoints += verticalSegment    // 0+50,50+50,100+50.....200+50
            
            horizontalPoints += horizontalSegment
            
            let verticalLinePoint = CGPoint(x: (lineMargin - textPadding),
                                            y: CGFloat(verticalPoints) - (pointArea*2.0))

            let horizontalLinePoint = CGPoint(x: CGFloat(horizontalPoints) - (pointArea/2.0),
                                              y: (lineMargin - textPadding))
            
            // Write input text on Horizontal Axis, Bottom line
            writeAxisText(vInput, onPoint: horizontalLinePoint)
            
            // Writesinput text on Vertical line, Left side line
            writeAxisText(hInput, onPoint: verticalLinePoint)
            
            // 50*(0+1), 50*(2+1),50*(1+1)....... 50*(4+1),
            let x = horizontalSegment * (i+1)
            
            let y = verticalSegment * (Int(input[1])!/10)
            
            let point = CGPoint(x: CGFloat(x), y: CGFloat(y))
            
            pointsList.append(point)
            
            /// Places point on inside chart axis
            drawPoint(point)
            
        }
        
        drawLine(withPoints: pointsList)
    }
    
    
    //MARK: Protocol Implementation

    func generateVerticalAxis() {
        
        let startPoint = CGPoint(x: lineMargin, y: lineMargin)
        let endPoint = CGPoint(x: lineMargin, y: self.frame.height)
        renderAxes(withStartPoint: startPoint, endPoint: endPoint)
    }
    
    func generateHorizontalAxis() {
        
        let startPoint = CGPoint(x: lineMargin, y: lineMargin)
        let endPoint = CGPoint(x: self.frame.width, y: lineMargin)
        
        renderAxes(withStartPoint: startPoint, endPoint: endPoint)
    }
    
    func renderAxes(withStartPoint start: CGPoint, endPoint end: CGPoint) {
        
        let path = CGMutablePath()
        path.move(to: start)
        path.addLine(to: end)
        
        let pathLayer = CAShapeLayer()
        pathLayer.lineWidth = axisWidth
        pathLayer.fillColor = NSColor.red.cgColor
        pathLayer.path = path
        pathLayer.strokeColor = NSColor.red.cgColor
        pathLayer.strokeEnd = 1.0
        self.layer?.addSublayer(pathLayer)
    }

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
//        path.fill()
        path.stroke()
        
        NSGraphicsContext.restoreGraphicsState()
        
    }
    
    /*
    func drawLineOnChart(withPoint point: CGPoint) {
        
        drawPoint(point)
        
        let cgContext = NSGraphicsContext.current?.cgContext

        cgContext?.saveGState()
        
        let cgPath = CGMutablePath()
        cgPath.move(to: startpoint)
        cgPath.addLine(to: point)
        cgPath.closeSubpath()
        cgContext?.setLineWidth(1.0)
        cgContext?.setStrokeColor(lineColor.cgColor)
        cgContext?.addPath(cgPath)
        cgContext?.drawPath(using: .stroke)
        
        cgContext?.restoreGState()

        startpoint = point
    }
    */
    
    func drawLine(withPoints points: [CGPoint]) {
        
        let path = CGMutablePath()
        path.move(to: startpoint)
        for point in points {
            path.addLine(to: point)
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = path
        shapeLayer.lineWidth = 1.5
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.fillColor = nil
        shapeLayer.strokeEnd = 1.0
        self.layer?.addSublayer(shapeLayer)
        
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.fromValue = 0.0
        drawAnimation.toValue = 1.0
        drawAnimation.duration = 2.5
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        shapeLayer.add(drawAnimation, forKey: "strokeEndAnimation")
        
    }
    
    func calculateAxis() {
        
        
        generateVerticalAxis()
        
        generateHorizontalAxis()
        
//        let verticalAxisLine : CGRect = CGRect(x: lineMargin,
//                                               y: lineMargin,
//                                               width: axisWidth,
//                                               height: self.frame.height - lineMargin)
//        drawAxis(onFrame: verticalAxisLine)
//
//        let horizontalAxisLine = CGRect(x: lineMargin,
//                                        y: lineMargin,
//                                        width: self.frame.width - lineMargin,
//                                        height:axisWidth )
//        drawAxis(onFrame: horizontalAxisLine)
        
    }
    
    func writeAxisText(_ text: String, onPoint point: CGPoint) {
        
        let textLabel = NSTextField(string: text)
        textLabel.sizeToFit()
        textLabel.backgroundColor = NSColor.clear
        textLabel.isBordered = false
        textLabel.isEditable = false
        textLabel.setFrameOrigin(point)
        self.addSubview(textLabel)
    }
    
    
}

protocol Axis {
    
    func calculateAxis()
    
    func drawAxis(onFrame rect : CGRect)
    
    func generateVerticalAxis()
    
    func generateHorizontalAxis ()
    
    func renderAxes(withStartPoint start : CGPoint, endPoint end: CGPoint)
    
}


protocol AxisPoint : Axis {
    
    func drawPoint(_ point: NSPoint)
    
    func drawLine(withPoints points: [CGPoint])
    
    func writeAxisText(_ text : String, onPoint point: CGPoint)
}



