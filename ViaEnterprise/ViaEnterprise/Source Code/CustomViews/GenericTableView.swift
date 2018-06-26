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
    
    var dataList : [Category] = [Category]() {
        didSet {
            self.reloadData()
        }
    }
    
    public func initialSetup () {
        register(UINib(nibName: ITEM_TABLE_VIEW_CELL, bundle: nil), forCellReuseIdentifier: itemCellIdentifier)
        self.delegate = self
        self.dataSource = self
    }
    
    
    // MARK: Table View Data source functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemTableCell : ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath) as! ItemTableViewCell
        
        let category: Category = dataList[indexPath.section]
        
        itemTableCell.items = category.items
        
        return itemTableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableHeaderView  = Bundle.main.loadNibNamed("TableHeaderView",
                                                        owner: self,
                                                        options: nil)?.first as! TableHeaderView
        
        var str = ""
        if let name = dataList[section].name {
            tableHeaderView.title.text = name
            
            str = "More " + name
        }
        else{
            tableHeaderView.title.text = ""
        }
        
        tableHeaderView.textButton.setTitle(str, for: .normal)

        tableHeaderView.textButton.addTarget(self,
                                             action: #selector(tappedTableViewHeader(_:)),
                                             for: .touchUpInside)
        
        tableHeaderView.arrowButton.addTarget(self,
                                             action: #selector(tappedTableViewHeader(_:)),
                                             for: .touchUpInside)
        return tableHeaderView
    }
    
    @objc func tappedTableViewHeader (_ sender: Any) {
        print("tappedTableViewHeader")
    }
}

