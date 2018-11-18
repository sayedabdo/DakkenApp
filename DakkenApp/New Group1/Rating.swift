//
//  Rating.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 11/18/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import Foundation

class Rating{
    var id : Int
    var user_id : Int
    var item_id : Int
    var name : String
    var image : String
    var rate : Int
    var title : String
    var created_date : String
    
    init(id : Int , user_id : Int ,item_id : Int , name : String , image : String , rate : Int , title : String,created_date : String) {
        self.id = id
        self.user_id = user_id
        self.item_id = item_id
        self.name = name
        self.image = image
        self.rate = rate
        self.title = title
        self.created_date = created_date
    }
}
