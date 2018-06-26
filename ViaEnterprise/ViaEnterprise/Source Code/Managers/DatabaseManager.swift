//
//  DatabaseManager.swift
//  ViaEnterprise
//
//  Created by Nasir Ahmed Momin on 26/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class DatabaseManager: NSObject {
    
    static let shared = DatabaseManager()
    var dbRef : Firestore?
    
    override init() {
        FirebaseApp.configure()
        dbRef = Firestore.firestore()
    }
    
    func fetch() {
        
    }
    
    
    
}
