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
    
    func setOrder(subOrder: SubOrder) {
        orderName.text = subOrder.itemname
        orderCount.text = "\(subOrder.qty)"
        timeOrder.text  = subOrder.created_at
        priceOrder.text = "\(subOrder.price * Double(subOrder.qty))"
        download_image(image_url: subOrder.itemimg,imagedisplayed: orderImage)

    }
    
}
