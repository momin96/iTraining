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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell : ItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        return itemCell
    }
    
    
}
