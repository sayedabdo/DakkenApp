//
//  User.swift
//  Dakken
//
//  Created by Sayed Abdo on 10/15/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import Foundation


class User{
    var id : String
    var name : String
    var email : String
    var password : String
    var phone : String
    var address : String
    var country : String
    var image : String
    var role : String
    var device_id : String
    var firebase_token : String
    var forgetcode : String
    var suspensed : String
    var notification : String
    var user_hash : String
    var countryname : String
    
    init(id : String , name : String , email : String , password : String ,phone : String,
        address : String , country : String , image : String , role : String , device_id : String,
        firebase_token  : String , forgetcode : String , suspensed : String ,notification : String,
        user_hash : String , countryname : String){
        
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.phone = phone
        self.address = address
        self.country = country
        self.image = image
        self.role = role
        self.device_id = device_id
        self.firebase_token = firebase_token
        self.forgetcode = forgetcode
        self.suspensed = suspensed
        self.notification = notification
        self.user_hash = user_hash
        self.countryname = countryname
    }
}
