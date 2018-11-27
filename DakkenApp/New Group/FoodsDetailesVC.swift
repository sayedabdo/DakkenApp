//
//  FoodsDetailesVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 11/18/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire
import Cosmos

class FoodsDetailesVC: UIViewController {
    
    
    var product: Product!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    var rating = [Rating]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HHHH : \(product.image)")
        // Do any additional setup after loading the view.
        productName.text = "\(product.title)"
        download_image(image_url: product.image,imagedisplayed: productImage)
        productPrice.text = "\(product.price)"
        productDescription.text = "\(product.desc)"
    }
    func getcomments(){
        let RatingURL = "https://dkaken.alsalil.net/api/itemrates"
        let params: [String : String] =
            [   "item_id"                  : "20"
        ]
        Alamofire.request(RatingURL, method: .post, parameters: params)
            .responseJSON { response in
                print("the response is : \(response)")
                let result = response.result
                print("the result is : \(String(describing: result.value))")
                if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                    if(arrayOfDic["success"] as! Bool == false ){
                        return
                    }
                    let userData  = arrayOfDic["message"]  as? [[String: Any]]
                    for aDic1  in userData!  {
                        self.rating.append(Rating(
                            id: aDic1["id"] as! Int,
                            user_id : aDic1["user_id"] as! Int,
                            item_id : aDic1["item_id"] as! Int,
                            name : aDic1["name"] as! String,
                            image : aDic1["image"] as! String,
                            rate : aDic1["rate"] as! Int,
                            title : aDic1["title"] as! String,
                            created_date : aDic1["created_date"] as! String
                        ))
                        
                        
                    }
                    
                    
                    
                }
        }
    }
}
