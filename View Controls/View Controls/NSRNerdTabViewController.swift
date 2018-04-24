//
//  NSRNerdTabViewController.swift
//  View Controls
//
//  Created by Nasir Ahmed Momin on 24/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa


@objc protocol ImageRepresentable {
    var image: NSImage? { get }
}

class NSRNerdTabViewController: NSViewController {
    
    
    var box = NSBox()
    var buttons : [NSButton] = []
    
    
    func selectTabAtIndex(_ index : Int) {
        for i in 0..<buttons.count {
            let button = buttons[i]
            button.state = (index == i) ? NSControl.StateValue.on : .off
        }
        
        let viewController = childViewControllers[index] as! NSViewController
        box.contentView = viewController.view
    }
    
    @objc func selectTab(_ sender: NSButton) {
        let index = sender.tag
        selectTabAtIndex(index)
    }
    
    override func loadView() {
        view = NSView()
        reset()
    }
    
    func reset () {
        view.subviews = []
        
        let buttonWidth : CGFloat = 28
        let buttonHeight : CGFloat = 28
        
        let viewControllers = childViewControllers
        var buttons : [NSButton] = []
        
        for (index, viewController ) in viewControllers.enumerated() {
            let button = NSButton()
            button.setButtonType(NSButton.ButtonType.toggle)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.isBordered = false
            button.target = self
            button.action = #selector(selectTab(_:))
            button.tag = index
//            button.image = NSImage(imageLiteralResourceName: "flow")
            
            if let controller = viewController as? ImageRepresentable {
                button.image = controller.image
            }
            else {
                button.title = viewController.title!
            }
            
            button.addConstraints([
                NSLayoutConstraint( item: button,
                                    attribute: .width,
                                    relatedBy: .equal,
                                    toItem: nil,
                                    attribute: .notAnAttribute,
                                    multiplier: 1.0,
                                    constant: buttonWidth),
                
                NSLayoutConstraint( item: button,
                                    attribute: .height,
                                    relatedBy: .equal,
                                    toItem: nil,
                                    attribute: .notAnAttribute,
                                    multiplier: 1.0,
                                    constant: buttonHeight)
                ])
            buttons.append(button)
        }
        
        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .horizontal
        stackView.spacing = 4
        for button in buttons {
            stackView.addView(button, in: .center)
        }
        
        box.translatesAutoresizingMaskIntoConstraints = false
        box.borderType = .noBorder
        box.boxType = .custom
        
        
        let seperator = NSBox()
        seperator.boxType = .separator
        seperator.translatesAutoresizingMaskIntoConstraints = false
        
        view.subviews = [stackView, seperator, box]
        let views = ["stack" : stackView, "seperator" : seperator, "box" : box]
        let metrics = ["buttonHeight" : buttonHeight]
        
        
        func addVisualFormatConstraints(visualFormat : String) {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat,
                                                               options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
                                                               metrics: metrics as [String : NSNumber],
                                                               views: views))
        }
        
        addVisualFormatConstraints(visualFormat: "H:|[stack]|")
        addVisualFormatConstraints(visualFormat: "H:|[seperator]|")
        addVisualFormatConstraints(visualFormat: "H:|[box(>=100)]|")
        addVisualFormatConstraints(visualFormat: "V:|[stack(buttonHeight)][seperator(==1)][box(>=100)]|")
        
        if childViewControllers.count > 0 {
            selectTabAtIndex(0)
        }
        
        
        
    }
    
    override func insertChildViewController(_ childViewController: NSViewController, at index: Int) {
        super.insertChildViewController(childViewController, at: index)
        
        if isViewLoaded {
            reset()
        }
    }
    
    override func removeChildViewController(at index: Int) {
        super.removeChildViewController(at: index)
        
        if isViewLoaded {
            reset()
        }
    }
    
}
