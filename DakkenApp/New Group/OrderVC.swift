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
    var requestedOrder = [RequestedOrder]()
    var selectedID : String!
    @IBOutlet weak var requestedOrderTableView: UITableView!
    @IBOutlet weak var superOrderTableView: UITableView!
    @IBOutlet weak var statusView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestedOrderTableView.dataSource = self
        requestedOrderTableView.delegate = self
        superOrderTableView.dataSource = self
        superOrderTableView.delegate = self
        
//        if(AppDelegate.global_user.role == "1"){
//            requestedOrderTableView.isHidden = false
//            superOrderTableView.isHidden = true
//            getOrderDetails()
//        }else{
//            requestedOrderTableView.isHidden = true
//            superOrderTableView.isHidden = false
//            getOrder()
//        }
        superOrderTableView.backgroundView = UIImageView(image: UIImage(named: "bgimage"))
        requestedOrderTableView.backgroundView = UIImageView(image: UIImage(named: "bgimage"))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
        
    }
    
    
    func viewLoadSetup(){
        // setup view did load here
        if(AppDelegate.global_user.role == "1"){
            requestedOrderTableView.isHidden = false
            superOrderTableView.isHidden = true
            getOrderDetails()
        }else{
            requestedOrderTableView.isHidden = true
            superOrderTableView.isHidden = false
            getOrder()
        }
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
        if AppDelegate.global_user.role == "1"{
            print("the requestedOrder count is : \(requestedOrder.count)")
            return requestedOrder.count
        }
         else{
            print("the superOrder count is : \(superorder.count)")
            return superorder.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if AppDelegate.global_user.role == "1" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "requestedOrderCell") as? requestedOrderCell
            if(indexPath.row % 2 == 1){
                cell?.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            }
            cell?.setSubOrder(requestedOrder: requestedOrder[indexPath.row])
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
        if AppDelegate.global_user.role == "1" {
             statusView.isHidden = false
             selectedID = "\(requestedOrder[indexPath.row].status)"
        }
        else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SubOrderVC") as! SubOrderVC
            nextViewController.order_id = Int(superorder[indexPath.row].id)
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    //end table view jobs
    //Start getOrderDetails
    func getOrderDetails(){
        requestedOrder.removeAll()
        let OrderDetailsURL = "https://dkaken.alsalil.net/api/mytraderorders"
        let params: [String : String] =
            [   "user_hash"              : "\(AppDelegate.global_user.user_hash)",
                "trader_id"               : "\(AppDelegate.global_user.id)"
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
                    let messagedata = arrayOfDic["message"] as? [[String: Any]]
                    for aDic1 in messagedata!{
                        self.requestedOrder.append(RequestedOrder(
                            date : aDic1["date"] as! String,
                            id : aDic1["id"] as! Int,
                            itemimg : aDic1["itemimg"] as! String,
                            itemname : aDic1["itemname"] as! String,
                            itemprice : aDic1["itemprice"] as! Int,
                            owner : aDic1["owner"] as! String,
                            price : aDic1["price"] as! Double,
                            qty : aDic1["qty"] as! Int,
                            status : aDic1["status"] as! String
                        ))
                    }
                    self.requestedOrderTableView.reloadData()
                }
        }
    }
    //ENd getOrderDetails
    ////////////
    //start get orders
    func getOrder(){
        superorder.removeAll()
        let OrderDetailsURL = "https://dkaken.alsalil.net/api/myuserorders"
        let params: [String : String] =
            [   "user_hash"              : "\(AppDelegate.global_user.user_hash)",
                "owner_id"               : "\(AppDelegate.global_user.id)"
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
    //start change Order Status func
    func changeOrdersStatus(itemID : Int , status : String){
        let changeOrderStatusURL = "https://dkaken.alsalil.net/api/orderprocess"
        let params: [String : String] =
            [   "user_hash"                 : "\(AppDelegate.global_user.user_hash)",
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
