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
        unregisterKVO()
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
        let it2 = Item("Pepsi", imageUrl: "", price: 10.0, quantity: 1)
        let it3 = Item("Limca", imageUrl: "", price: 9.0, quantity: 1)
        
        
        let it4 = Item("Apple", imageUrl: "", price: 19.0, quantity: 1)
        let it5 = Item("Orange", imageUrl: "", price: 13.0, quantity: 1)
        let it6 = Item("Grape", imageUrl: "", price: 15.0, quantity: 1)

        
        let c1 = Category("Drinks", items: [it1, it2, it3, it4, it5, it6])
        let c2 = Category("Fruits", items: [it4, it5, it6])
        
        dataList = [c1, c2]
        
    }
    
    
    // MARK: Private functions
    private func intialSetup () {
        normalItemButton.setBottomLine(thickness: nil, color: nil)
        normalItemButton.bottomLine(ShouldHide: false)
        
        extraPayItemButton.setBottomLine(thickness: nil, color: nil)
        extraPayItemButton.bottomLine(ShouldHide: true)
        
        navigationInitialSetup()
        
        registerKVO ()
        
        tableView.initialSetup()
        
    }
    
    private func navigationInitialSetup () {
        
        let customItemView = Bundle.main.loadNibNamed("CustomNavigationItem", owner: self, options: nil)?.first as! CustomNavigationItem
        
        let rightImage = UIImage(named: "shoppingBag")
        customItemView.navigationItemButton.setImage(rightImage, for: .normal)
        customItemView.itemLabel.text = "0"
        customItemView.navigationItemButton.addTarget(self,
                                                      action: #selector(tappedCheckoutButton(_:)),
                                                      for: .touchUpInside)
        
        let rightItem = UIBarButtonItem(customView: customItemView);
        
        self.navigationItem.rightBarButtonItem = rightItem
        
        let leftImage = UIImage(named: "hamburgerMenu")
        let leftItem = UIBarButtonItem(image: leftImage,
                                    style: UIBarButtonItemStyle.plain,
                                    target: self,
                                    action: #selector(tappedHamburgButton(_:)))

        
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc private func tappedCheckoutButton(_ sender: Any) {
        print("tappedCheckoutButton")
    }
    
    @objc private func tappedHamburgButton(_ sender: Any) {
        print("tappedHamburgButton")
    }
    
    //MARK: KVO functions
    
    private func registerKVO () {
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.addObserver(self, forKeyPath: #keyPath(AppDelegate.globalItemPrice), options: [.old, .new], context: nil)
        appDelegate.addObserver(self, forKeyPath: #keyPath(AppDelegate.globalItemQty), options: [.old, .new], context: nil)
    }
    
    private func unregisterKVO () {
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate

        appDelegate.removeObserver(self, forKeyPath: #keyPath(AppDelegate.globalItemPrice))
        appDelegate.removeObserver(self, forKeyPath: #keyPath(AppDelegate.globalItemQty))
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if keyPath == #keyPath(AppDelegate.globalItemPrice) {
            print(appDelegate.globalItemPrice)
        }
        else if keyPath == #keyPath(AppDelegate.globalItemQty) {
            print(appDelegate.globalItemQty)
            
            if let customView : CustomNavigationItem = navigationItem.rightBarButtonItem?.customView as? CustomNavigationItem {
                customView.itemLabel.text = String(appDelegate.globalItemQty)
            }
        }
    }
    
    
    
    //MARK: Target Action methods
    
    @IBAction func tappedNormalPayButton(_ sender: UIButton) {
        
        sender.bottomLine(ShouldHide: true)
        extraPayItemButton.bottomLine(ShouldHide: false)
        
    }
    
    @IBAction func tappedExtraPayButton(_ sender: UIButton) {
        
        sender.bottomLine(ShouldHide: true)
        normalItemButton.bottomLine(ShouldHide: false)
        
    }
    
    
    
    
    
}

