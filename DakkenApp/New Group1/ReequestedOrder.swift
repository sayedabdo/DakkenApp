//
//  ReequestedOrder.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 11/5/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import Foundation


class  ReequestedOrder{
    var date : String
    var id : Int
    var itemimg : String
    var itemname : String
    var itemprice : Int
    var owner : String
    var price : Int
    var qty : Int
    var status : String
    init(date : String , id : Int , itemimg : String , itemname : String , itemprice : Int
         ,owner : String , price : Int , qty : Int , status : String) {
        self.date = date
        self.id = id
        self.itemimg = itemimg
        self.itemname = itemname
        self.itemprice = itemprice
        self.owner = owner
        self.price = price
        self.qty = qty
        self.status  = status

    }
}
