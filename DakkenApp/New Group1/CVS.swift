//
//  CVs.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/21/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import Foundation

class CVS{
    var id : Int
    var user_id : Int
    var name : String
    var country : String
    var phone : String
    var age : String
    var social_status : Int
    var job : String
    var certification : String
    var graduation_year : String
    var suspensed : Int
    var created_at : String
    
    init(id : Int , user_id : Int , name : String , country : String , phone : String
        ,age : String , social_status : Int , job : String , certification : String
        ,graduation_year : String , suspensed : Int , created_at : String){
        
        self.id = id
        self.user_id = user_id
        self.name = name
        self.country = country
        self.phone = phone
        self.age = age
        self.social_status = social_status
        self.job = job
        self.certification = certification
        self.graduation_year = graduation_year
        self.suspensed = suspensed
        self.created_at = created_at

    }
}
