//
//  NSRChatWindowController.swift
//  Chatter
//
//  Created by Nasir Ahmed Momin on 17/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa


private let DidSendMessageNotification = "com.chatter.messageNotification"
private let NotificationMessageKey = "messageKey"

class NSRChatWindowController: NSWindowController {

    
    @objc dynamic var log : NSAttributedString = NSAttributedString(string: "")
    @objc dynamic var message : String?
    
    @IBOutlet var textView: NSTextView!
    
    @IBOutlet weak var sendButton: NSButton!
    @IBOutlet weak var textField: NSTextField!
    
    
    
    override func windowDidLoad() {
        super.windowDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(receiveMessageNotification(_:)), name: NSNotification.Name(rawValue: DidSendMessageNotification), object: nil)
    }
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name(rawValue: "NSRChatWindowController")
    }
    
    @IBAction func sendMessage(_ sender: NSButton) {
        
        
        sender.window?.endEditing(for: nil)
        
        if let message = message {
            let userInfo = [NotificationMessageKey : message]
            let notificationCenter = NotificationCenter.default as NotificationCenter
            notificationCenter.post(name: NSNotification.Name(DidSendMessageNotification), object: self, userInfo: userInfo)
        }
        
        message = ""
    }
    
    @objc func receiveMessageNotification(_ notification : NSNotification) {
        let mutableLog = log.mutableCopy() as! NSMutableAttributedString
        
        if mutableLog.length > 0 {
                mutableLog.append(NSAttributedString(string: "\n"))
        }
        
        let userInfo = notification.userInfo as! [String : String]
        let message = userInfo[NotificationMessageKey]
        
        let logLine = NSAttributedString(string: message!)
        mutableLog.append(logLine)
        
        log = mutableLog.copy() as! NSAttributedString
        
        let visibleRange = NSRange(location: log.length, length: 0)
        
        textView.scrollRangeToVisible(visibleRange)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
