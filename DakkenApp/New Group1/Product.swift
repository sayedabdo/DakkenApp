//
//  Product.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/20/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import Foundation

class Product{
    var id : Int
    var category : Int
    var trader_id : Int
    var title : String
    var price : Double
    var desc : String
    var image : String
    var qty : Int
    var productnum : String
    var size : String
    var color : String
    var suspensed : Int
    var created_at : String
    
    
    init(id : Int , category : Int ,trader_id : Int ,title : String ,price : Double
        ,desc : String , image : String , qty : Int ,productnum : String ,size : String
        ,color : String , suspensed : Int , created_at : String ){
        
        self.id = id
        self.category = category
        self.trader_id = trader_id
        self.title = title
        self.price = price
        self.desc = desc
        self.image = image
        self.qty = qty
        self.productnum = productnum
        self.size = size
        self.color = color
        self.suspensed = suspensed
        self.created_at = created_at
    }
}
