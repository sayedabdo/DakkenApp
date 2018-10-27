//
//  OrderCell.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/24/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderCount: UILabel!
    @IBOutlet weak var priceOrder: UILabel!
    @IBOutlet weak var timeOrder: UILabel!
    
    func setOrder(Order: Order) {
        orderName.text = Order.Product_Name
        orderCount.text = "\(Order.Price) ريال "
        timeOrder.text  = "\(Order.order_pro_quantity)"
        product_total_cost.text = "\(Order.Price * Double(Order.order_pro_quantity))"
        download_image(image_url: Order.Product_img,imagedisplayed: product_image)

    }
    
}
