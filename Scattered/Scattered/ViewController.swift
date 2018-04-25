//
//  ViewController.swift
//  Scattered
//
//  Created by Nasir Ahmed Momin on 24/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var textLayer : CATextLayer!
    
    var text : String? {
        didSet {
            let font = NSFont.systemFont(ofSize: textLayer.fontSize)
            let attributes = [NSAttributedStringKey.font : font]
            
            var size : CGSize = (text as! NSString).size(withAttributes: attributes) ?? CGSize.zero
            
            size.width = ceil(size.width)
            size.height = ceil(size.height)
            
            textLayer.bounds = CGRect(origin: CGPoint.zero, size: size)
            
            textLayer.superlayer?.bounds = CGRect(x: 0, y: 0, width: size.width + 16, height: size.height + 20)
            
            textLayer.string = text
        }
    }
    
    
    func thumbImageForImage(_ image : NSImage) -> NSImage {
        let targetHeight : CGFloat = 200.0
        let imageSize = image.size
        
        let smallerSize = NSSize(width: targetHeight * imageSize.width / imageSize.height,
                                  height: targetHeight)
        
        let smallerImage = NSImage(size: smallerSize, flipped: false) { (rect) -> Bool in
            image.draw(in: rect)
            return true
        }
        return smallerImage
    }
    
    func addImagesfromFolrderURL(_ folderURL: URL) {
        let t0 = Date.timeIntervalSinceReferenceDate
        let fileManager = FileManager()
        
        let directoryEnumerator = fileManager.enumerator(at: folderURL,
                                                         includingPropertiesForKeys: nil,
                                                         options:FileManager.DirectoryEnumerationOptions.init(rawValue: 0) ,
                                                         errorHandler: nil)
        
        
        var allowedFiles = 10
        
        while let url = directoryEnumerator?.nextObject() as? NSURL {
            var isDirectoryValue: AnyObject?
//            do {
                let _ = try? url.getResourceValue(&isDirectoryValue, forKey: isDirectoryValue as! URLResourceKey)
//            }
//            catch let err {
//                print("Error \(err)")
//            }
            
            if let isDirectory = isDirectoryValue as? NSNumber, isDirectory.boolValue == false {
                let image = NSImage(contentsOf: url as URL)
                if let img = image {
                    allowedFiles -= 1
                    if allowedFiles < 0 {
                        break
                    }
                    
                    let thumbImage = thumbImageForImage(img)
                    
                    presentImage(thumbImage)
                    
                    let t1 = Date.timeIntervalSinceReferenceDate
                    let interval = t1 - t0
                    text = String.init(format: "%0.1fs", interval)
                }
            }
            
        }
    }
    
    func presentImage(_ image : NSImage) {
        let superLayerBounds = view.layer?.bounds
        
        let center = CGPoint(x: (superLayerBounds?.midX)!, y: (superLayerBounds?.midY)!)
        
        let imageBounds = CGRect(origin: CGPoint.zero, size: image.size)
        
        let x = CGFloat(arc4random_uniform(UInt32((superLayerBounds?.maxX)!)))
        let y = CGFloat(arc4random_uniform(UInt32((superLayerBounds?.maxY)!)))
        
        let randomPoint : CGPoint = CGPoint(x: x, y: y)
        
        let timingFunctions = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let positionAnimation = CABasicAnimation()
        positionAnimation.fromValue = NSValue(point: center)
        positionAnimation.duration = 1.5
        positionAnimation.timingFunction = timingFunctions
        
        let boundsAnimation = CABasicAnimation()
        boundsAnimation.fromValue = NSValue.init(rect: CGRect.zero)
        boundsAnimation.duration = 1.5
        boundsAnimation.timingFunction = timingFunctions
        
        let layer = CALayer()
        layer.contents = image
        layer.actions = ["position" : positionAnimation, "bounds" : boundsAnimation]
        
        CATransaction.begin()
        view.layer?.addSublayer(layer)
        layer.position = randomPoint
        layer.bounds = imageBounds
        CATransaction.commit()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer = CALayer()
        view.wantsLayer = true
        
        let textContainer = CALayer()
        textContainer.anchorPoint = CGPoint.zero
        textContainer.position = CGPoint(x: 10, y: 10)
        textContainer.zPosition = 100
        textContainer.backgroundColor = NSColor.black.cgColor
        textContainer.borderColor = NSColor.white.cgColor
        textContainer.borderWidth = 2
        textContainer.cornerRadius = 15
        textContainer.shadowOpacity = 0.5
        view.layer?.addSublayer(textContainer)
        
        let textLayer = CATextLayer()
        textLayer.anchorPoint = CGPoint.zero
        textLayer.position = CGPoint(x: 10, y: 6)
        textLayer.zPosition = 100
        textLayer.fontSize = 24
        textLayer.foregroundColor = NSColor.white.cgColor
        self.textLayer = textLayer
        
        textContainer.addSublayer(textLayer)
        
        text = "Loading..."
        
        let picURL = URL(fileURLWithPath: "/Library/Desktop Pictures")
        
        addImagesfromFolrderURL(picURL)
        

    }

}

