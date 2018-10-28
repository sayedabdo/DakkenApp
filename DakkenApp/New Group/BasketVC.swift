//
//  BasketVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/27/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire

class BasketVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var basketTableView: UITableView!
    var orders = [Order]()
    override func viewDidLoad() {
        super.viewDidLoad()
        basketTableView.dataSource = self
        basketTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    //start table view jobs
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell") as? BasketCell
        cell?.setOrder(Order: orders[indexPath.row])
        cell?.productDetiles.tag = indexPath.row
        cell?.productDelete.tag = indexPath.row
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //end table view jobs
    //end get_product
    //start getAllItemsFromCard
    func getAllItemsFromCard(){
        orders.removeAll()
        let cartitemsURL = "https://dkaken.alsalil.net/api/cartitems"
        let params: [String : String] =
            [   "user_hash"                  : "$2y$10$8Gra96kkwZ7oOtxrw5IUlesp8DawSKZ.F8hA4.0z0AfFAwRhBhu72",
                "owner"                      : "\(23)",
            ]
        Alamofire.request(cartitemsURL, method: .post, parameters: params)
            .responseJSON { response in
             print("the response is : \(response)")
            let result = response.result
             print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
               if(arrayOfDic["success"] as! Bool == false ){
                    self.displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                             messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "emailOrPassword", comment: ""),
                                             titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
                    return
                }
                var messagedata = arrayOfDic["message"] as? [[String: Any]]
                for aDic1 in messagedata!{
                    self.orders.append(Order(
                        id : aDic1["id"] as! Int,
                        item_id : aDic1["item_id"] as! Int,
                        item_title : aDic1["item_title"] as! String,
                        item_img : aDic1["item_img"] as! String,
                        order_id : aDic1["order_id"] as! Int,
                        owner : aDic1["owner"] as! Int,
                        trader : aDic1["trader"] as! Int,
                        qty : aDic1["qty"] as! Int,
                        price : aDic1["price"] as! Int,
                        status : aDic1["status"] as! Int,
                        created_at : aDic1["created_at"]  as! String
                    ))
                }
                self.basketTableView.reloadData()
            }
        }
    }
    //end getAllItemsFromCard

}
