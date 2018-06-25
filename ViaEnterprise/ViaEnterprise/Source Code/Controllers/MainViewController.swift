//
//  MainViewController.swift
//  ViaEnterprise
//
//  Created by Nasir Ahmed Momin on 25/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

let ITEM_TABLE_VIEW_CELL = "ItemTableViewCell"

class MainViewController: UIViewController {

    @IBOutlet weak var itemTableView: UITableView!
    
    let itemCellIdentifier = "itemTableViewCell"
    
    
    //MARK: Life cycle
    deinit {
        print("deinit MainViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //MARK: Private functions
    
    private func initialSetup () {
        itemTableView.register(UINib(nibName: ITEM_TABLE_VIEW_CELL, bundle: nil), forCellReuseIdentifier: itemCellIdentifier)
    }
    
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemTableCell : ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath) as! ItemTableViewCell
        
        return itemTableCell
    }
    
    
}
