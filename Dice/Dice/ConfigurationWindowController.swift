//
//  ConfigurationWindowController.swift
//  Dice
//
//  Created by Nasir Ahmed Momin on 18/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

struct DieConfiguration {
    let color : NSColor
    let rolls : Int
    
    init(color : NSColor, rolls : Int) {
        self.color = color
        self.rolls = rolls
    }
}


class ConfigurationWindowController: NSWindowController {

    
    @objc private dynamic var color : NSColor = NSColor.white
    @objc private dynamic var rolls : Int = 10
    
    @IBOutlet weak var dieConfurationItem : NSMenuItem!
    
    var configuration : DieConfiguration {
        set {
            color = newValue.color
            rolls = newValue.rolls
        }
        get {
            return DieConfiguration(color: color, rolls: rolls)
        }
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
    }
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name(rawValue : "ConfigurationWindowController")
    }
    
    
    @IBAction func okayButtonClicked(_ button : NSButton) {
        window?.endEditing(for: nil)
        self.dismissWithModalResponse(.OK)
    }
    @IBAction func cancelButtonClicked(_ button : NSButton) {
        self.dismissWithModalResponse(.cancel)
    }
    
    
    func dismissWithModalResponse(_ response : NSApplication.ModalResponse) {
        window?.sheetParent?.endSheet(window!, returnCode: response)
    }
    
}



