//
//  PasswordGenerator.swift
//  NSRPasswordGenerator
//
//  Created by Nasir Ahmed Momin on 19/03/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Foundation


private let charaters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

var passwordString = "";

func generateRandomString(_ length : Int) -> String? {
    passwordString = ""
    for _ in 0..<length {
        passwordString.append(generateRandomCharacters())
    }
    return passwordString;
}


func generateRandomCharacters () -> Character {
    let index = Int(arc4random_uniform(UInt32(charaters.count)))
    
    let singleCharacter = Array(charaters)[index] //charaters.index(charaters.startIndex, offsetBy: index)
    
    print("singleCharacter : \(singleCharacter)")
    
    return singleCharacter
}
