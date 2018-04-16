//
//  NSRWindowController.swift
//  NSRChatter
//
//  Created by Nasir Ahmed Momin on 16/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class NSRWindowController: NSWindowController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.shouldCascadeWindows = true
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
       
    }

    @IBAction func newChatWindow(sender : NSMenuItem) {
        let chatWindow = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "NSRChatWindowController")) as! NSRChatWindowController
        
//        self.showWindow(chatWindow)
        self.contentViewController = chatWindow
    }
    
}
