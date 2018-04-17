//
//  AppDelegate.swift
//  Chatter
//
//  Created by Nasir Ahmed Momin on 17/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var windowControllers : [NSRChatWindowController] = []
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        addWindowController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    func addWindowController() {
        let chatWindowController = NSRChatWindowController()
        chatWindowController.showWindow(self)
        windowControllers.append(chatWindowController)
    }
    
    
    @IBAction func addNewWindow(_ sender : NSMenuItem) {
        addWindowController()
    }

}

