//
//  User.swift
//  TonsserChallenge
//
//  Created by Harri on 8/3/20.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import Foundation

struct UserResponse: Decodable {
    
    var response: [User]
}

struct User: Decodable {
    
     var name: String
    
     var profilePicture: String?

     var slug: String
}


