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
    var superorder = [SuperOrder]()
    var subOrder = [SubOrder]()
    var role = 0
    @IBOutlet weak var subOrderTableView: UITableView!
    @IBOutlet weak var superOrderTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subOrderTableView.dataSource = self
        subOrderTableView.delegate = self
        superOrderTableView.dataSource = self
        superOrderTableView.delegate = self
       // getOrderDetails()
        getOrder()
        superOrderTableView.backgroundView = UIImageView(image: UIImage(named: "bgimage"))
        subOrderTableView.backgroundView = UIImageView(image: UIImage(named: "bgimage"))
    }
    //start table view jobs
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if role == 1{
            print("the subOrder count is : \(subOrder.count)")
            return subOrder.count
        }
         else{
            print("the superOrder count is : \(superorder.count)")
            return superorder.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if role == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "subOrderCell") as? subOrderCell
            if(indexPath.row % 2 == 1){
                cell?.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            }
            cell?.setSubOrder(subOrder: subOrder[indexPath.row])
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "superOrderCell") as? superOrderCell
            if(indexPath.row % 2 == 1){
                cell?.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            }
            cell?.setSuperOrder(superOrder : superorder[indexPath.row])
            cell?.orderDetailes.tag = superorder[indexPath.row].id
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //end table view jobs
    //Start getOrderDetails
    func getOrderDetails(){
        let OrderDetailsURL = "https://dkaken.alsalil.net/api/myorderdetails"
        let params: [String : String] =
            [   "user_hash"              : "\(AppDelegate.global_user.user_hash)",
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
    ////////////
    //start get orders
    func getOrder(){
        let OrderDetailsURL = "https://dkaken.alsalil.net/api/myuserorders"
        let params: [String : String] =
            [   "user_hash"              : "\(AppDelegate.global_user.user_hash)",
                "owner_id"               : "\(2)"
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
                        self.superorder.append(SuperOrder(
                            id : aDic1["id"] as! Int,
                            order_number : aDic1["order_number"] as! String,
                            order_owner : aDic1["order_owner"] as! Int,
                            status : aDic1["status"] as! Int,
                            created_at : aDic1["created_at"] as! String
                        ))
                    }
                    print("superOrder : \(self.superorder.count)")
                    self.superOrderTableView.reloadData()
                }
        }
    }
    //end get orders

}
