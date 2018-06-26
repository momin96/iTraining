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
    
    
    private var item: Item?
    
    private var orderedQty : Int = 0 {
        didSet{
            setTotalItemQty()
        }
    }
    
    private var orderedAmount: Double = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()

        itemIncreamentButton.drawBorderOf(thickness: 0.5, color: nil)
        itemDecrementButton.drawBorderOf(thickness: 0.5, color: nil)
        itemTotalQty.drawBorderOf(thickness: 0.5, color: nil)
    }
    
    //MARK: Public functions
    public func configureCellWith (item i: Item) {
        self.itemName.text = i.name
        self.itemPrice.text = "$ " + String(i.price!) + " Per Pack"
        self.itemPackQty.text =  String(i.quantity!) + " Pack(s)"
        
        item = i
    }
    
    //MARK: Private functions
    
    private func setTotalItemQty () {
        
        var qty = 0
        if orderedQty > 0  {
            qty = orderedQty
        }
        else if orderedQty < 0{
            orderedQty = 0
        }
        itemTotalQty.text = String(qty)
        
        orderedAmount = (item?.price)! * Double(qty)
        
    }
    
    private func sendOrderAmount() {
        
    }
    
    
    
    // MARK: Target Action functions
    @IBAction func decrementItem(_ sender: UIButton) {
        orderedQty -= 1
        sendOrderAmount()
    }
    
    @IBAction func incrementItem(_ sender: UIButton) {
        orderedQty += 1
        sendOrderAmount()
    }


    
}
