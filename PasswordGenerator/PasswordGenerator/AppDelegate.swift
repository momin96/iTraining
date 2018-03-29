//
//  AppDelegate.swift
//  PasswordGenerator
//
//  Created by Nasir Ahmed Momin on 19/03/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    var mainController : NSRMainWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let mainLocalController = NSRMainWindowController()
        mainLocalController.showWindow(self)
        self.mainController = mainLocalController;
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

