//
//  SubOrder.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/31/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import Foundation

class SubOrder{
    
    var itemname : String
    var itemimg : String
    var itemprice : Int
    var trader : String
    var qty : Int
    var price : Double
    var status : Int
    var created_at : String
    
    init(itemname : String , itemimg : String , itemprice : Int , trader : String , qty : Int , price : Double , status : Int , created_at : String ) {
        self.itemname = itemname
        self.itemimg = itemimg
        self.itemprice = itemprice
        self.trader = trader
        self.qty = qty
        self.price = price
        self.status = status
        self.created_at = created_at
    }
    
    
}
