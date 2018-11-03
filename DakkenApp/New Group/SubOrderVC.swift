//
//  SubOrderVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/31/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//
import UIKit
import Alamofire

class SubOrderVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    var subOrder = [SubOrder]()
    var order_id : Int!
    var selectedID : Int!
    @IBOutlet weak var subOrderTableView: UITableView!
    @IBOutlet weak var statusView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subOrderTableView.dataSource = self
        subOrderTableView.delegate = self
        getOrderDetails()
    }
    
    @IBAction func closeOrderStatus(_ sender: Any) {
        statusView.isHidden = true
    }
    @IBAction func changeOrderStatus(_ sender: Any) {
        changeOrdersStatus(itemID : 5 , status : "\((sender as AnyObject).tag)")
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
        cell?.setSubOrder(subOrder: subOrder[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        statusView.isHidden = false
        selectedID = subOrder[indexPath.row].status
    }
    //end table view jobs
    //Start getOrderDetails
    func getOrderDetails(){
        let OrderDetailsURL = "https://dkaken.alsalil.net/api/myorderdetails"
        let params: [String : String] =
            [   "user_hash"              : "$2y$10$5L3RGZLjOWXU2gWp7pL6VOXsgV9gFpaGvvlDRFQfgSNySnbLK5GoS",
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
    //start change Order Status func
    func changeOrdersStatus(itemID : Int , status : String){
        let changeOrderStatusURL = "https://dkaken.alsalil.net/api/orderprocess"
        let params: [String : String] =
            [   "user_hash"                 : "$2y$10$opFJGvoUJy7rIEumoz.71.65zcLi7YAaPpNCJyQUfKuk5Da7zCttm",
                "status"                    : "\(9)" ,
                "item_id"                   : "\(2)"
        ]
        Alamofire.request(changeOrderStatusURL, method: .post, parameters: params)
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
                    self.statusView.isHidden = true
                }
        }
    }
    //start change Order Status func
    
}

