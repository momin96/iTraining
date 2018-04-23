//
//  NSRImageViewController.swift
//  View Controls
//
//  Created by Nasir Ahmed Momin on 23/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

@objc class NSRImageViewController: NSViewController {

    @objc dynamic var image: NSImage?
    
    override var nibName: NSNib.Name? {
        return NSNib.Name(rawValue: "NSRImageViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
