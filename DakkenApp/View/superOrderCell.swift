//
//  suberOrderCell.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/31/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class superOrderCell: UITableViewCell {
    
    @IBOutlet weak var orderNumer: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderDetailes: UIButton!
    func setSuperOrder(superOrder: SuperOrder){
        orderNumer.text = superOrder.order_number
        orderDate.text = superOrder.created_at
    }
    
}
