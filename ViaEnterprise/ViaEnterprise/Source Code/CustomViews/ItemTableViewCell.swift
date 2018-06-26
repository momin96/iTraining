//
//  ItemTableViewCell.swift
//  ViaEnterprise
//
//  Created by Nasir Ahmed Momin on 25/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

let ITEM_COLLECTION_VIEW_CELL = "ItemCollectionViewCell"

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemCollectionView: UICollectionView!
    let itemCellIdentifier = "itemCollectionCell"
    
    var items : [Item]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemCollectionView.register(UINib(nibName: ITEM_COLLECTION_VIEW_CELL, bundle: nil), forCellWithReuseIdentifier: itemCellIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension ItemTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if let list = items {
            return list.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell : ItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        let item : Item = items![indexPath.row]
        
        itemCell.configureCellWith(item: item)
        
        return itemCell
    }
}


class TableHeaderView: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var arrowButton: UIButton!

}

