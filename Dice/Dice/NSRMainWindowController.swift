//
//  NSRMainWindowController.swift
//  Dice
//
//  Created by Nasir Ahmed Momin on 18/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class NSRMainWindowController: NSWindowController {

    
    var configurationWindowController : ConfigurationWindowController?
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
    }

    @IBAction func showDieConfiguration(_ sender: Any) {
        if let window = window, let dieView = window.firstResponder as? NSRDieView {
            let windowController = ConfigurationWindowController()
            windowController.configuration = DieConfiguration(color: dieView.color, rolls: dieView.numberOfTimesToRoll)
            
            window.beginSheet(windowController.window!, completionHandler: { (response) in
                if response == .OK {
                    let configuration = self.configurationWindowController?.configuration
                    dieView.color = (configuration?.color)!
                    dieView.numberOfTimesToRoll = (configuration?.rolls)!
                }
                self.configurationWindowController = nil
            })
            configurationWindowController = windowController
        }
    }
    
}
