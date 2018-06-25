//
//  GenericTableView.swift
//  ViaEnterprise
//
//  Created by Nasir Ahmed Momin on 25/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

let ITEM_TABLE_VIEW_CELL = "ItemTableViewCell"

class GenericTableView: UITableView {
    
    let itemCellIdentifier = "itemTableViewCell"

    public func initialSetup () {
        self.register(UINib(nibName: ITEM_TABLE_VIEW_CELL, bundle: nil), forCellReuseIdentifier: itemCellIdentifier)
    }
    
}

extension GenericTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemTableCell : ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath) as! ItemTableViewCell
        
        return itemTableCell
    }
}
