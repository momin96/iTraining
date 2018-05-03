//
//  ViewController.swift
//  Interview Demo App
//
//  Created by Nasir Ahmed Momin on 03/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @objc dynamic var persons : [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataFetcher.shared.getPersonList { (persons) in
            
            let sortedPerson = persons.sorted(by: { (p1, p2) -> Bool in
                return p1 > p2
            })
            
            self.persons = sortedPerson
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

