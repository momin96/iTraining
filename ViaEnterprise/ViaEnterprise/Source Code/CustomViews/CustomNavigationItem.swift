//
//  CustomNavigationItem.swift
//  ViaEnterprise
//
//  Created by Nasir Ahmed Momin on 26/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

class CustomNavigationItem: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navigationItemButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomNavigationItem", owner: self, options: nil)
        navigationItemButton.titleLabel?.textColor = UIColor.blue
        navigationItemButton.backgroundColor = .red
        self.backgroundColor = .yellow
    }
}
