//
//  MainViewController.swift
//  ViaEnterprise
//
//  Created by Nasir Ahmed Momin on 25/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    @IBOutlet weak var normalItemButton: UIButton!
    
    @IBOutlet weak var extraPayItemButton: UIButton!
    
    
    
    //MARK: Life cycle
    deinit {
        print("deinit MainViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intialSetup()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    
    // MARK: Privat
    private func intialSetup () {
        normalItemButton.setBottomLine(thickness: nil, color: nil)
        normalItemButton.bottomLine(ShouldHide: false)
        
        extraPayItemButton.setBottomLine(thickness: nil, color: nil)
        extraPayItemButton.bottomLine(ShouldHide: true)
    }
    
}

