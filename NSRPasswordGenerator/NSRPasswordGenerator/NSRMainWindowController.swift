//
//  NSRMainWindowController.swift
//  NSRPasswordGenerator
//
//  Created by Nasir Ahmed Momin on 19/03/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class NSRMainWindowController: NSWindowController {

    
    @IBOutlet weak var passwordTextField : NSTextField?
    @IBOutlet weak var generatePasswordButton : NSButton?
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name(rawValue: "NSRMainWindowController")
    }
    
    
    @IBAction func generatePassword (_ sender : NSButton) {
        let password = generateRandomString(8);
        if let pwd = password {
            passwordTextField?.stringValue = pwd;
        }
    }
    
}
