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
    var subOrder = [Order]()
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
        print("the count is : \(order.count)")
        return order.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subOrderCell") as? subOrderCell
        cell?.setOrder(order: order[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //end table view jobs
    //Start getOrderDetails
    func getOrderDetails(){
        let OrderDetailsURL = "https://dkaken.alsalil.net/api/myorderdetails"
        let params: [String : String] =
            [   "user_hash"              : "$2y$10$mimFE9.sE/tvPdx9nqmya.JOjbOlnFcTECiUZNAxKEspzLC2KOOzq",
                "order_id"               :"\(11)" ,
                "owner_id"               :"\(23)"
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
                        self.subOrder.append(Order(
                            id : aDic1["id"] as! Int,
                            item_id : aDic1["item_id"] as! Int,
                            item_title : aDic1["item_title"] as! String,
                            item_img : aDic1["item_img"] as! String,
                            order_id : aDic1["order_id"] as! Int,
                            owner : aDic1["owner"] as! Int,
                            trader : aDic1["trader"] as! Int,
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
