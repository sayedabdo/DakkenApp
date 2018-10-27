//
//  ItemData.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/27/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import Foundation

class ItemData{
    
    var id : Int
    var category : Int
    var trader_id : Int
    var title : String
    var price : Int
    var desc : String
    var image : String
    var qty : Int
    var productnum : Int
    var size : String
    var color : String
    var suspensed : Int
    var created_at : String
    var tradername : String
    var catname : String
    var rating : Double
    
    init(id : Int , category : Int , trader_id : Int , title : String , price : Int , desc : String
        ,image : String , qty : Int , productnum : Int , size : String , color : String , suspensed : Int
        ,created_at : String , tradername : String , catname : String , rating : Double){
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
        self.tradername = tradername
        self.catname = catname
        self.rating = rating
    }
}
