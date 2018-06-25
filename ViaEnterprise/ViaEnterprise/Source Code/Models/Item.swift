//
//  Item.swift
//  ViaEnterprise
//
//  Created by Nasir Ahmed Momin on 25/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

struct Item {
    var name: String?
    var imageUrl: String?
    var price: Double?
    var quantity: Int?
    
    var totalQty: Int?
    
    init(_ name: String, imageUrl: String, price: Double, quantity: Int) {
        self.name = name
        self.imageUrl = imageUrl
        self.price = price
        self.quantity = quantity
    }
    
}


struct Category {
    var name: String?
    var items: [Item]?
    
    init(_ name: String, items: [Item]) {
        self.name = name
        self.items = items
    }
}
