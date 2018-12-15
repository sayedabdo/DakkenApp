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

class FoodsDetailesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var product: Product!

    @IBOutlet weak var VCTitle: UILabel!
    @IBOutlet weak var pricefixd: UILabel!
    @IBOutlet weak var ratefixed: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var descriptionfixed: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var ratingTabelView:UITableView!
    @IBOutlet weak var productrate: CosmosView!
    @IBOutlet weak var addtocardbtn: UIButton!
    @IBOutlet weak var addratebtn: UIButton!
    
    var rating = [Rating]()
    override func viewDidLoad() {
        ratingTabelView.dataSource = self
        ratingTabelView.delegate = self
        super.viewDidLoad()
        print("HHHH : \(product.image)")
        // Do any additional setup after loading the view.
        productName.text = "\(product.title)"
        download_image(image_url: product.image,imagedisplayed: productImage)
        productPrice.text = "\(product.price)"
        productDescription.text = "\(product.desc)"
        getcomments()
        
        VCTitle.text = "\(product.title)"
        descriptionfixed.text =  "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "descriptiondetails", comment: ""))"
        pricefixd.text =  "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "pricedetails", comment: ""))"
        ratefixed.text =  "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "ratedetails", comment: ""))"
        addtocardbtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "addtocard", comment: ""), for: .normal)
        addratebtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "addrate", comment: ""), for: .normal)
    }
    
    @IBAction func closeratingview(_ sender: Any) {
        ratingView.isHidden = true
    }
    //start table view rating
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the rating count is : \(rating.count)")
        return rating.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell") as? RatingCell
        cell?.name.text = "\(rating[indexPath.row].name)"
        cell?.comment.text = "\(rating[indexPath.row].title)"
        cell?.rating.rating = Double(rating[indexPath.row].rate)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //end table view rating
    //Start back Button Action
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //End back Button Action
    @IBAction func writerateAction(_ sender: Any) {
        ratingView.isHidden = false
    }
    
    func getcomments(){
        let RatingURL = "https://dkaken.alsalil.net/api/itemrates"
        let params: [String : String] =
            [   "item_id"                  : "\(product.id)"
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
                    self.ratingTabelView.reloadData()
                    
                    
                }
        }
    }
}
