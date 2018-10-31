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
    
    func setOrder(order: Order) {
        orderName.text = order.item_title
        orderCount.text = "\(order.qty)"
        timeOrder.text  = order.created_at
        priceOrder.text = "\(order.price * Double(order.qty))"
        download_image(image_url: order.item_img,imagedisplayed: orderImage)

    }
    
}
