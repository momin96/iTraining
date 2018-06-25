//
//  ItemCollectionViewCell.swift
//  ViaEnterprise
//
//  Created by Nasir Ahmed Momin on 25/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemPackQty: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var itemTotalQty: UILabel!
    @IBOutlet weak var itemIncreamentButton: UIButton!
    @IBOutlet weak var itemDecrementButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    public func configureCellWith (item i: Item) {
        self.itemName.text = i.name
        self.itemPrice.text = String(i.price!)
        self.itemPackQty.text = String(i.quantity!)
    }
    
    @IBAction func decrementItem(_ sender: UIButton) {
    
    }
    
    @IBAction func incrementItem(_ sender: UIButton) {
    
    }
    
}
