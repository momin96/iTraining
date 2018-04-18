//
//  NSRDieView.swift
//  Dice
//
//  Created by Nasir Ahmed Momin on 17/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class NSRDieView: NSView, NSDraggingSource {

    var intValue : Int? = 5 {
        didSet {
            needsDisplay = true
        }
    }
    
    var pressed : Bool = false {
        didSet {
            needsDisplay = true
        }
    }
    
    var highlightForDraging : Bool = false {
        didSet {
            needsDisplay = true
        }
    }
    
    var mouseDownEvent : NSEvent?
    
    var rollsRemaining : Int = 0
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }
    
    func commonInit()  {
        self.registerForDraggedTypes([NSPasteboard.PasteboardType.string])
    }
    
    override var intrinsicContentSize: NSSize {
        return CGSize(width: 200, height: 200)
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
        
        
        if highlightForDraging {
            let gradiant = NSGradient(starting: NSColor.white, ending: backgroundColor)
            gradiant?.draw(in: bounds, relativeCenterPosition: NSZeroPoint)
        }
        else {
            drawDieWithSize(bounds.size)
        }
        
    }
 
    // MARK: First Responder
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    override func keyDown(with event: NSEvent) {
        interpretKeyEvents([event])
    }
    
    override func insertText(_ insertString: Any) {
        let text = insertString as! String
        if let number = Int(text) {
            intValue = number
        }
    }
    
    override func drawFocusRingMask() {
        NSBezierPath.fill(bounds)
    }
    
    override var focusRingMaskBounds: NSRect {
        return bounds
    }
    
    override func insertTab(_ sender: Any?) {
        window?.selectNextKeyView(sender)
    }
    
    override func insertBacktab(_ sender: Any?) {
        window?.selectPreviousKeyView(sender)
    }
    
    func metricForSize(_ size : CGSize) -> (edgeLength : CGFloat, dieFrame : CGRect) {
        
        let edgeLength = min(size.width, size.height)
        let padding = edgeLength / 10.0
       
        let drawingBounds = CGRect(x: 0, y: 0, width: edgeLength, height: edgeLength)
        var dieFrame = drawingBounds.insetBy(dx: padding, dy: padding)
        
        if pressed {
            dieFrame = dieFrame.offsetBy(dx: 0, dy: -edgeLength/40)
        }
        
        return (edgeLength, dieFrame)
    }
    
    
    func drawDieWithSize(_ size : CGSize) {
        
        if let intValue = intValue {
            let (edgeLength, dieFrame) = metricForSize(size)
            
            let cornerRadius : CGFloat = edgeLength / 5.0
            
            let dotRadius = edgeLength / 12.0
            let dotFrame = dieFrame.insetBy(dx: dotRadius * 2.5, dy: dotRadius * 2.5)
            
            NSGraphicsContext.saveGraphicsState()

            let shadow = NSShadow()
            shadow.shadowOffset = NSSize(width: 0, height: -1)
            shadow.shadowBlurRadius = pressed ? edgeLength/100 : edgeLength/20
            shadow.set()

            NSColor.white.set()
            let path = NSBezierPath(roundedRect: dieFrame, xRadius: cornerRadius, yRadius: cornerRadius)
            path.fill()

            NSGraphicsContext.restoreGraphicsState()
            
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
            else {
                let paraStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
                paraStyle.alignment = .center
                let font = NSFont.systemFont(ofSize:edgeLength*0.5 )
                
                var attributes : [NSAttributedStringKey : Any] = [NSAttributedStringKey : Any]()
                attributes.updateValue(font, forKey: NSAttributedStringKey.font)
                attributes.updateValue(NSColor.black, forKey: NSAttributedStringKey.foregroundColor)
                attributes.updateValue(paraStyle, forKey: NSAttributedStringKey.paragraphStyle)

                let string = "\(intValue)" as NSString
//                string.draw(in: dieFrame, withAttributes: attributes)
                string.drawCenteredIn(Rect: dieFrame, attributes: attributes)
            }
        }
    }
    
    func find(_ list : [Int], value : Int) -> Int? {
        if list.contains(value) {
            return list.index(of: value)
        }
        return nil;
    }
    
    func randomize () {
        intValue = Int(arc4random_uniform(5)) + 1
    }
    
    override func mouseDown(with event: NSEvent) {
        print("mouseDown")
        mouseDownEvent = event
        let dieFrame = metricForSize(bounds.size).dieFrame
        let pointInView = convert(event.locationInWindow, from: nil)
        pressed = dieFrame.contains(pointInView)
    }
    
    override func mouseDragged(with event: NSEvent) {
        print("mouseDragged in location \(event.locationInWindow)")
        
        let downPoint = mouseDownEvent?.locationInWindow
        let dragPoint = event.locationInWindow
        
        let distanceDragged = hypot((downPoint?.x)! - dragPoint.x , (downPoint?.y)! - dragPoint.y)
        
        if distanceDragged < 3 {
            return
        }
        
        pressed = false
        
        if let intValue = intValue {
            let imageSize = bounds.size
            let image = NSImage(size: imageSize, flipped: false, drawingHandler: { (imageBounds) -> Bool in
                self.drawDieWithSize(imageBounds.size)
                return true
            })
            
            let draggingFrameOrigin = convert(downPoint!, from: nil)
            
            let draggingFrame = NSRect(origin: draggingFrameOrigin, size: imageSize).offsetBy(dx: -imageSize.width / 2, dy: -imageSize.height / 2)
            
            let item = NSDraggingItem(pasteboardWriter: String(intValue) as NSPasteboardWriting)
            item.draggingFrame = draggingFrame
            item.imageComponentsProvider = {
                let component = NSDraggingImageComponent(key: .icon)
                component.contents = image
                component.frame = NSRect(origin: NSPoint(), size: imageSize)
                
                return [component]
            }
            beginDraggingSession(with: [item], event: mouseDownEvent!, source: self)
        }
        
    }
    
    override func mouseUp(with event: NSEvent) {
        print("mouseUp clickcount \(event.clickCount)")
        if event.clickCount == 2 {
//            randomize()
            roll()
        }
        pressed = false
    }
    
    
    @IBAction func savePDF(_ sender : NSMenuItem) {
        let savePanel = NSSavePanel()
        savePanel.allowedFileTypes = ["pdf"]
        savePanel.beginSheetModal(for: window!) { (result) in
            if result == NSApplication.ModalResponse.OK {
                let data = self.dataWithPDF(inside: self.bounds)
                let error : Error?
                do {
                    try! data.write(to: savePanel.url!, options: Data.WritingOptions.atomic)
                }
                catch {
                    let alert = NSAlert(error: error)
                    alert.runModal()
                }
            }
        }
    }
    
    @IBAction func cut(_ sender : NSMenuItem) {
        writeToPasteBoard(NSPasteboard.general)
        intValue = nil
    }

    @IBAction func copy(_ sender : NSMenuItem) {
        writeToPasteBoard(NSPasteboard.general)
    }
    @IBAction func paste(_ sender : NSMenuItem) {
        readFromPasteboard(NSPasteboard.general)
    }
    
    func writeToPasteBoard(_ pasteboard : NSPasteboard) {
        if let intValue = intValue {
            pasteboard.clearContents()
            pasteboard.writeObjects(["\(intValue)" as NSPasteboardWriting])
        }
    }
    
    func readFromPasteboard(_ pasteboard : NSPasteboard) -> Bool{
        let objects = pasteboard.readObjects(forClasses: [NSString.self], options: [:]) as! [String]
        if let str = objects.first {
            intValue = Int(str)
            return true
        }
        return false
    }
    
    func roll() {
        rollsRemaining = 10
        Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(rollTick(_:)), userInfo: nil, repeats: true)
        window?.makeFirstResponder(nil)
    }
    
    @objc func rollTick(_ sender : Timer) {
        let lastIntValue = intValue
        while intValue == lastIntValue {
            randomize()
        }
        rollsRemaining -= 1
        if rollsRemaining == 0 {
            sender.invalidate()
            window?.makeFirstResponder(self)
        }
    }
    
    // MARK: Drag Source
    func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
        return [.delete,.copy]
    }
    
    func draggingSession(_ session: NSDraggingSession, endedAt screenPoint: NSPoint, operation: NSDragOperation) {
        if operation == .delete {
            intValue = nil
        }
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if sender.draggingSource() as! NSRDieView == self {
            return []
        }
        highlightForDraging = true
        return sender.draggingSourceOperationMask()
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        highlightForDraging = false
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return true
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let ok = readFromPasteboard(sender.draggingPasteboard())
        return ok
    }
    
    override func concludeDragOperation(_ sender: NSDraggingInfo?) {
        highlightForDraging = false
    }
//    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
//        printView("Operation Mask = \(sender.draggingSourceOperationMask().rawValue)")
//        if sender.draggingSource() as! NSRDieView == self {
//            return []
//        }
//        return [.copy,.delete]
//    }
    
}

