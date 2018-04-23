//
//  AppDelegate.swift
//  View Controls
//
//  Created by Nasir Ahmed Momin on 23/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

   var window: NSWindow?


    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let flowViewController = NSRImageViewController()
        flowViewController.title = "Flow"
        flowViewController.image = NSImage(imageLiteralResourceName: "flow")
        let window = NSWindow(contentViewController: flowViewController)
        window.makeKeyAndOrderFront(self)
        self.window = window
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

