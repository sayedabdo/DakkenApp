//
//  OrderCell.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/24/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class subOrderCell: UITableViewCell {

    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderCount: UILabel!
    @IBOutlet weak var priceOrder: UILabel!
    @IBOutlet weak var timeOrder: UILabel!
    @IBOutlet weak var orderImage: UIImageView!
    
    func setSubOrder(requestedOrder: RequestedOrder) {
        orderName.text = requestedOrder.itemname
        orderCount.text = "\(requestedOrder.qty)"
        timeOrder.text  = requestedOrder.date
        priceOrder.text = "\(requestedOrder.price * Double(requestedOrder.qty))"
        download_image(image_url: requestedOrder.itemimg,imagedisplayed: orderImage)

    }
    
}
