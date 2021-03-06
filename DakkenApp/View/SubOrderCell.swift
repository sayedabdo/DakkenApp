//
//  SubOrderCell.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 11/6/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class SubOrderCell: UITableViewCell {

    @IBOutlet weak var orderNamefixed: UILabel!
    @IBOutlet weak var orderCountfixed: UILabel!
    @IBOutlet weak var priceOrderfixed: UILabel!
    @IBOutlet weak var timeOrderfixed: UILabel!
    
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderCount: UILabel!
    @IBOutlet weak var priceOrder: UILabel!
    @IBOutlet weak var timeOrder: UILabel!
    @IBOutlet weak var orderImage: UIImageView!
    
    
    func setSubOrder(subOrder: SubOrder) {
        orderName.text = subOrder.itemname
        orderCount.text = "\(subOrder.qty)"
        timeOrder.text  = subOrder.created_at
        priceOrder.text = "\(subOrder.price * Double(subOrder.qty))"
        download_image(image_url: subOrder.itemimg,imagedisplayed: orderImage)
        orderNamefixed.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "orderNamefixed", comment: "")
        orderCountfixed.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "orderCountfixed", comment: "")
        priceOrderfixed.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "priceOrderfixed", comment: "")
        timeOrderfixed.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "timeOrderfixed", comment: "")
    }

}
