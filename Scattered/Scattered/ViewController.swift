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
    
    var text : String?
    
    func addImagesfromFolrderURL(_ folderURL: URL) {
        
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

