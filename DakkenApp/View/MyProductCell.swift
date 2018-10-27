//
//  MyProductCell.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/27/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class MyProductCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func setMyProduct(product: Product) {
        productName.text = "\(product.title)"
        productPrice.text = "\(product.price)"
        download_image(image_url: product.image,imagedisplayed: productImage)
    }
    
}
