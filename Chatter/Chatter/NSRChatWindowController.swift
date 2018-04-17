//
//  NSRChatWindowController.swift
//  Chatter
//
//  Created by Nasir Ahmed Momin on 17/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class NSRChatWindowController: NSWindowController {

    
    @objc dynamic var log : NSAttributedString = NSAttributedString(string: "")
    @objc dynamic var message : String?
    
    @IBOutlet var textView: NSTextView!
    
    @IBOutlet weak var sendButton: NSButton!
    @IBOutlet weak var textField: NSTextField!
    override func windowDidLoad() {
        super.windowDidLoad()

    }
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name(rawValue: "NSRChatWindowController")
    }
    
    @IBAction func sendMessage(_ sender: NSButton) {
    }
}
