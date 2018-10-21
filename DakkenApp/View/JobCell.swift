//
//  JobCell.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/21/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {
        
        @IBOutlet weak var name: UILabel!
        @IBOutlet weak var jobTitle: UILabel!
        @IBOutlet weak var country: UILabel!
        @IBOutlet weak var phone: UILabel!
        
        
        func setCvs(cvs: CVS) {
            name.text = "\(cvs.name)"
            jobTitle.text = "\(cvs.job)"
            country.text = "\(cvs.country)"
            phone.text = "\(cvs.phone)"
            
            // download_image(image_url: product.image,imagedisplayed: productImage)
            //buttonborder(button_outlet_name:addtToCard)
        }

}
