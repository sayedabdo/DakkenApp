//
//  OrderVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/24/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire

class OrderVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    var order = [Order]()
    var subOrder = [SubOrder]()
    @IBOutlet weak var subOrderTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subOrderTableView.dataSource = self
        subOrderTableView.delegate = self
        getOrderDetails()
    }
    //start table view jobs
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the count is : \(subOrder.count)")
        return subOrder.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subOrderCell") as? subOrderCell
        cell?.setOrder(subOrder: SubOrder[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //end table view jobs
    //Start getOrderDetails
    func getOrderDetails(){
        let OrderDetailsURL = "https://dkaken.alsalil.net/api/myorderdetails"
        let params: [String : String] =
            [   "user_hash"              : "$2y$10$opFJGvoUJy7rIEumoz.71.65zcLi7YAaPpNCJyQUfKuk5Da7zCttm",
                "order_id"               :"\(9)" ,
                "owner_id"               :"\(2)"
            ]
        Alamofire.request(OrderDetailsURL, method: .post, parameters: params)
            .responseJSON { response in
                print("the response is : \(response)")
                let result = response.result
                print("the result is : \(String(describing: result.value))")
                if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                    if(arrayOfDic["success"] as! Bool == false ){
                        self.displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                                 messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "emailOrPassword", comment: ""),
                                                 titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
                        return
                    }
                    var messagedata = arrayOfDic["message"] as? [[String: Any]]
                    for aDic1 in messagedata!{
                        self.subOrder.append(SubOrder(
                            itemname : aDic1["itemname"] as! String,
                            itemimg : aDic1["itemimg"] as! String,
                            itemprice : aDic1["itemprice"] as! Int,
                            trader : aDic1["trader"] as! String,
                            qty : aDic1["qty"] as! Int,
                            price : aDic1["price"] as! Double,
                            status : aDic1["status"] as! Int,
                            created_at : aDic1["created_at"] as! String
                        ))
                        
                    }
                    self.subOrderTableView.reloadData()
                }
        }
    }
    //ENd getOrderDetails
    

}
