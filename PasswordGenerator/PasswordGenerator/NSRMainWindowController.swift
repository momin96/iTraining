//
//  NSRMainWindowController.swift
//  PasswordGenerator
//
//  Created by Nasir Ahmed Momin on 19/03/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class NSRMainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name(rawValue: "NSRMainWindowController");
    }
    
}
