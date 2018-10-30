//
//  BasketCell.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/27/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class BasketCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productTotalPrice: UILabel!
    @IBOutlet weak var ProductCount: UITextField!
    @IBOutlet weak var productDetiles: UIButton!
    @IBOutlet weak var productDelete: UIButton!
    @IBOutlet weak var stepper: UIStepper!
    
    func setOrder(Order: Order) {
        productName.text = Order.item_title
        productPrice.text = "\(Order.price) ريال "
        ProductCount.text  = "\(Order.qty)"
        productTotalPrice.text = "\(Order.price * Double(Order.qty))"
        download_image(image_url: Order.item_img,imagedisplayed: productImage)
    }


}
