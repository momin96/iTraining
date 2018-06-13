//
//  ViewController.swift
//  Reactive Cocoa Demo
//
//  Created by Nasir Ahmed Momin on 12/06/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import UIKit
import ReactiveCocoa


class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        slider.reactive.controlEvents(.valueChanged).observe { (slider) in
            print(slider.value ?? "")
        }
        
        textField.reactive.continuousTextValues.observe { (text) in
            self.label.text = text.value!
            
        }
        
    }

}

