//
//  ViewController.swift
//  Internet Connect Demo
//
//  Created by Nasir Ahmed Momin on 08/06/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if NetworkManager.shared.currentConnectionType() == .typeCellular {
            print("typeCellular")
        }
        if NetworkManager.shared.currentConnectionType() == .typeWifi {
            print("typeWifi")
        }
        if NetworkManager.shared.currentConnectionType() == .typeNone {
            print("typeNone")
        }
        
        if NetworkManager.shared.isNetworkAvailable() {
            print("network availalbe")
        }
        
        if NetworkManager.shared.isWifiConnection() {
            print("WIFI")
        }
        
        if NetworkManager.shared.isCellularConnection() {
            print("Cellular")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

