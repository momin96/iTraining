//
//  DatabaseManager.swift
//  ViaEnterprise
//
//  Created by Nasir Ahmed Momin on 26/06/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation
import Firebase

class DatabaseManager: NSObject {
    
    static let shared = DatabaseManager()
    
    private var dbRef = Firestore.firestore()
    
    override init() {
        FirebaseApp.configure()
    }
    
    
}
