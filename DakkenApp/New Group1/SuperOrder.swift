//
//  SuperOrder.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/31/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import Foundation

class SuperOrder{
    var id : Int
    var order_number : String
    var order_owner : Int
    var status : Int
    var created_at : String
    init(id : Int , order_number : String , order_owner : Int , status : Int , created_at : String) {
        self.id = id
        self.order_number = order_number
        self.order_owner = order_owner
        self.status = status
        self.created_at = created_at
    }

}
