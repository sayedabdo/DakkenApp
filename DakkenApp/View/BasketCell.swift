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
    @IBOutlet weak var fixedPrice: UILabel!
    @IBOutlet weak var fixedtotal: UILabel!
    
    func setOrder(Order: Order) {
        productName.text = Order.item_title
        productPrice.text = "\(Order.price) درهم"
        ProductCount.text  = "\(Order.qty)"
        productTotalPrice.text = "\(Order.price * Double(Order.qty))"
        download_image(image_url: Order.item_img,imagedisplayed: productImage)
        buttonborder(button_outlet_name:productDelete)
        buttonborder(button_outlet_name:productDetiles)
        productDetiles.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "display", comment: ""), for: .normal)
        productDelete.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Delete", comment: ""), for: .normal)
        fixedPrice.text =  "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "productprice", comment: ""))"
        fixedtotal.text =  "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "producttotalprice", comment: ""))"
    }
}
