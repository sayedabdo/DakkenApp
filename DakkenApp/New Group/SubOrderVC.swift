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
    var selectedstatus : String!
    @IBOutlet weak var subOrderTableView: UITableView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var acceptedOrderLabel: UILabel!
    @IBOutlet weak var orderDoneLabel: UILabel!
    @IBOutlet weak var orderInWayLabel: UILabel!
    @IBOutlet weak var arrivedDoneBtn: UIButton!
    @IBOutlet weak var orderTimelabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subOrderTableView.dataSource = self
        subOrderTableView.delegate = self
        getOrderDetails()
        subOrderTableView.backgroundView = UIImageView(image: UIImage(named: "bgimage"))
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func closeOrderStatus(_ sender: Any) {
        statusView.isHidden = true
    }
    @IBAction func changeOrderStatus(_ sender: Any) {
        //changeOrdersStatus(itemID : 5 , status : "\((sender as AnyObject).tag)")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubOrderCell") as? SubOrderCell
        if(indexPath.row % 2 == 1){
            cell?.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        }
        cell?.setSubOrder(subOrder: subOrder[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        statusView.isHidden = false
        //selectedID = subOrder[indexPath.row].
        orderTimelabel.text = "\(subOrder[indexPath.row].created_at)"
        selectedstatus = subOrder[indexPath.row].status
       // currentStatus(selectedstatus : selectedstatus)
    }
    //end table view jobs
    @IBAction func submitarrive(_ sender: Any) {
        changeOrdersStatus(itemID : selectedstatus , status : "4")
    }
    //Start getOrderDetails
    func getOrderDetails(){
        print("Order : \(AppDelegate.global_user.id)")
        let OrderDetailsURL = "https://dkaken.alsalil.net/api/myorderdetails"
        let params: [String : String] =
            [   "user_hash"              : "\(AppDelegate.global_user.user_hash)",
                "order_id"               : "\(order_id!)" ,
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
                        self.subOrder.append(SubOrder(
                            itemname : aDic1["itemname"] as! String,
                            itemimg : aDic1["itemimg"] as! String,
                            itemprice : aDic1["itemprice"] as! Int,
                            trader : aDic1["trader"] as! String,
                            qty : aDic1["qty"] as! Int,
                            price : aDic1["price"] as! Double,
                            status : aDic1["status"] as! String,
                            created_at : aDic1["created_at"] as! String
                        ))
                    }
                    self.subOrderTableView.reloadData()
                }
        }
    }
    //ENd getOrderDetails
    //start change Order Status func
    func changeOrdersStatus(itemID : String , status : String){
        let changeOrderStatusURL = "https://dkaken.alsalil.net/api/orderprocess"
        let params: [String : String] =
            [   "user_hash"                 : "\(AppDelegate.global_user.user_hash)",
                "status"                    : "\(status)" ,
                "item_id"                   : "\(itemID)"
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
    func currentStatus(selectedstatus : String){
        if(selectedstatus == "0"){
            acceptedOrderLabel.textColor = #colorLiteral(red: 0.9586617351, green: 0.4347025454, blue: 0.2375041842, alpha: 1)
        }
        if(selectedstatus == "1"){
            acceptedOrderLabel.textColor = #colorLiteral(red: 0.9586617351, green: 0.4347025454, blue: 0.2375041842, alpha: 1)
            orderDoneLabel.textColor = #colorLiteral(red: 0.9586617351, green: 0.4347025454, blue: 0.2375041842, alpha: 1)
        }
        if(selectedstatus == "2"){
            acceptedOrderLabel.textColor = #colorLiteral(red: 0.9586617351, green: 0.4347025454, blue: 0.2375041842, alpha: 1)
            orderDoneLabel.textColor = #colorLiteral(red: 0.9586617351, green: 0.4347025454, blue: 0.2375041842, alpha: 1)
            orderInWayLabel.textColor = #colorLiteral(red: 0.9586617351, green: 0.4347025454, blue: 0.2375041842, alpha: 1)
        }
        if(selectedstatus == "3"){
            arrivedDoneBtn.isEnabled = false
        }
            
    }
    
}

