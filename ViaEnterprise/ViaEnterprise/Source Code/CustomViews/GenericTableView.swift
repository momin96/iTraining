//
//  GenericTableView.swift
//  ViaEnterprise
//
//  Created by Nasir Ahmed Momin on 25/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

let ITEM_TABLE_VIEW_CELL = "ItemTableViewCell"

class GenericTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    let itemCellIdentifier = "itemTableViewCell"
    
    var dataList : [Category]? = {
        willSet {
            self.reload()
        }
    }
    
    public func initialSetup () {
        register(UINib(nibName: ITEM_TABLE_VIEW_CELL, bundle: nil), forCellReuseIdentifier: itemCellIdentifier)
        self.delegate = self
        self.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = dataList {
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemTableCell : ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath) as! ItemTableViewCell
        
        let category: Category = dataList![indexPath.row]
        
        itemTableCell.items = category.items
        
        return itemTableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

