//
//  Order.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/24/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import Foundation

class Order{
    var id : Int
    var item_id : Int
    var item_title : String
    var item_img : String
    var order_id : Int
    var owner : Int
    var trader : Int
    var qty : Int
    var price : Double
    var status : Int
    var created_at : String
    init(id : Int , item_id : Int , item_title : String , item_img : String , order_id : Int , owner : Int , trader : Int , qty : Int , price : Double , status : Int , created_at : String) {
        
            self.id = id
            self.item_id = item_id
            self.item_title = item_title
            self.item_img = item_img
            self.order_id = order_id
            self.owner = owner
            self.trader = trader
            self.qty = qty
            self.price = price
            self.status = status
            self.created_at = created_at
    }
}
