//
//  HomeproductCell.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/20/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class HomeproductCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var addtToCard: UIButton!
    
    func setProduct(product: Product) {
        if(AppDelegate.global_user.role == "1"){
            addtToCard.isHidden = true
        }
        productName.text = "\(product.title)"
        productPrice.text = "\(product.price)"
        download_image(image_url: product.image,imagedisplayed: productImage)
        buttonborder(button_outlet_name:addtToCard)
        addtToCard.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "addtocard", comment: ""), for: .normal)
    }
}
