//
//  MainViewController.swift
//  ViaEnterprise
//
//  Created by Nasir Ahmed Momin on 25/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var normalItemButton: UIButton!
    @IBOutlet weak var extraPayItemButton: UIButton!
    
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var tableView: GenericTableView!
    
    var dataList : [Category]? {
        didSet{
            if let list = dataList {
                tableView.dataList = list
            }
        }
    }
    
    //MARK: Life cycle
    deinit {
        print("deinit MainViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
        intialSetup()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func prepareData() {
        
        let it1 = Item("Coca Cola", imageUrl: "", price: 12.0, quantity: 1)
        let it2 = Item("Coca Cola", imageUrl: "", price: 10.0, quantity: 1)
        let it3 = Item("Coca Cola", imageUrl: "", price: 9.0, quantity: 1)
        
        
        let it4 = Item("Apple", imageUrl: "", price: 19.0, quantity: 1)
        let it5 = Item("Orange", imageUrl: "", price: 13.0, quantity: 1)
        let it6 = Item("Grape", imageUrl: "", price: 15.0, quantity: 1)

        
        let c1 = Category("Drinks", items: [it1, it2, it3])
        let c2 = Category("Fruits", items: [it4, it5, it6])
        
        dataList = [c1, c2]
        
    }
    
    
    // MARK: Privat
    private func intialSetup () {
        normalItemButton.setBottomLine(thickness: nil, color: nil)
        normalItemButton.bottomLine(ShouldHide: false)
        
        extraPayItemButton.setBottomLine(thickness: nil, color: nil)
        extraPayItemButton.bottomLine(ShouldHide: true)
        
        tableView.initialSetup()
        
    }
    
    //MARK: Target Action methods
    
    @IBAction func tappedNormalPayButton(_ sender: UIButton) {
        
    }
    
    @IBAction func tappedExtraPayButton(_ sender: UIButton) {
    }
    
}

