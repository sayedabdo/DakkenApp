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
    @IBOutlet weak var totalPriceLabel: UILabel!
    var orders = [Order]()
    var count_before = 0
    var count_after = 0
    var total_price = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        basketTableView.dataSource = self
        basketTableView.delegate = self
        // Do any additional setup after loading the view.
        getAllItemsFromCard(item : 23)
    }
    //start deleteItemAction
    @IBAction func deleteItemAction(_ sender: Any) {
        orders.remove(at: (sender as AnyObject).tag)
        print( orders[(sender as AnyObject).tag].id)
        deleteItemFromCard(deleteitem : orders[(sender as AnyObject).tag].id)
    }
    //end deleteItemAction
    @IBAction func showDetiles(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        // nextViewController.product = products[indexPath.row]
        self.present(nextViewController, animated:true, completion:nil)
    }
    // start stepper
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        count_before = orders[sender.tag].qty
        count_after = Int(sender.value)
        orders[sender.tag].qty = Int(sender.value)
        if (count_after > count_before){
            self.total_price =  self.total_price + orders[sender.tag].price
        }else{
            self.total_price =  self.total_price - orders[sender.tag].price
        }
        self.totalPriceLabel.text = " \(self.total_price) درهم"
        basketTableView.reloadData()
    }
    //Steper
    //start table view jobs
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the count is : \(orders.count)")
        return orders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = basketTableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as? BasketCell
            else { return UITableViewCell()
        }
        cell.setOrder(Order: orders[indexPath.row])
        cell.productDetiles.tag = indexPath.row
        cell.productDelete.tag = indexPath.row
        cell.stepper.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    //end table view jobs
    //start getAllItemsFromCard
    func getAllItemsFromCard(item : Int){
        orders.removeAll()
        self.total_price = 0
        let cartitemsURL = "https://dkaken.alsalil.net/api/cartitems"
        let params: [String : String] =
            [   "user_hash"                  : "$2y$10$mimFE9.sE/tvPdx9nqmya.JOjbOlnFcTECiUZNAxKEspzLC2KOOzq",
                "owner"                      : "\(item)"
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
                        order_id : 0,
                        owner : aDic1["owner"] as! Int,
                        trader : aDic1["trader"] as! Int,
                        qty : aDic1["qty"] as! Int,
                        price : aDic1["price"] as! Double,
                        status : aDic1["status"] as! Int,
                        created_at : aDic1["created_at"]  as! String
                    ))
                    self.total_price =  self.total_price + Double(aDic1["price"]  as! Double)
                }
                self.totalPriceLabel.text = " \(self.total_price) درهم"
                self.basketTableView.reloadData()
            }
        }
    }
    //end getAllItemsFromCard
    //start Delete Item From Card
    func deleteItemFromCard(deleteitem : Int){
        let deleteitemsURL = "https://dkaken.alsalil.net/api/delcartitem"
        let params: [String : String] =
            [   "user_hash"                  : "$2y$10$mimFE9.sE/tvPdx9nqmya.JOjbOlnFcTECiUZNAxKEspzLC2KOOzq",
                "cart_id"                    : "\(deleteitem)"
            ]
        Alamofire.request(deleteitemsURL, method: .post, parameters: params)
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
                    self.basketTableView.reloadData()
                }
        }
    }
    //end Delete Item From Card

}