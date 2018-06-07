//
//  ViewController.swift
//  Chart Drawing
//
//  Created by Nasir Ahmed Momin on 04/06/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let inputData = [["a","10"],["b","30"],["c","20"],["d","40"],["e","50"]]
        
        let frame = CGRect(x: 20, y: 20, width: self.view.frame.width - 40, height: self.view.frame.height - 40)
        
        let lineChart = LineChart.init(frame: frame)
        lineChart.inputData = inputData        
        self.view.addSubview(lineChart)
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

