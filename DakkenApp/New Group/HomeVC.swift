//
//  HomeVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/19/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire
import ScrollableSegmentedControl

class HomeVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    var userEmail : String! = ""
    var userPassword : String! = ""
    var fromsignUp : Bool = false
    var tab_data : [String] = ["المجتمع","وظائف","منتجات مستعمله","الملابس","الأكلات"]
    var tab_data_count = 0
    var products = [Product]()
    var cvs = [CVS]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        jobsTableView.dataSource = self
        jobsTableView.delegate = self
        // Do any additional setup after loading the view.
        get_product()
        for tabDataCounter in tab_data{
            self.segmentedControl.insertSegment(withTitle: "\(tabDataCounter)", at: self.tab_data_count)
            self.tab_data_count = self.tab_data_count + 1
        }
        if(fromsignUp == true){
            getUserData()
        }
        //start segmentedControl
        segmentedControl.segmentStyle = .textOnly
        segmentedControl.underlineSelected = true
        
        // change some colors
        segmentedControl.segmentContentColor = UIColor.white
        segmentedControl.selectedSegmentContentColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        segmentedControl.backgroundColor = #colorLiteral(red: 1, green: 0.8256774545, blue: 0, alpha: 1)
        //end segmentedControl
    }
    //start collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("the count is : ", products.count)
        return products.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
       // nextViewController.product = products[indexPath.row]
        self.present(nextViewController, animated:true, completion:nil)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: "HomeproductCell", for: indexPath) as? HomeproductCell
            else { return UICollectionViewCell()
        }
        cell.setProduct(product: products[indexPath.row])
       // cell.product_customer_name.tag = indexPath.row
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.yellow.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection.frame.size.width / 2 - 5, height: 240)
    }
    //end collection view
    
    //start table view jobs
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cvs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell") as? JobCell
        cell?.setCvs(cvs: cvs[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //end table view jobs
    //start custom segement
    @IBAction func segmentSelected(sender:ScrollableSegmentedControl) {
     //   products.removeAll()
       /// self.collection.reloadData()
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
//        let text_filtter = "\(tab_data[sender.selectedSegmentIndex])"
//        if(sender.selectedSegmentIndex == 0){
//            get_product()
//        }
    }
    //end custom segement
    //start get user data when sign up
    func getUserData(){
        let loginurl = "https://dkaken.alsalil.net/api/login"
        let params: [String : String] =
            [   "email"                  : "\(userEmail!)",
                "password"               : "\(userPassword!)",
                "firebase_token"         : "b",
                "device_id"              : "\(UIDevice.current.identifierForVendor!.uuidString)"
            ]
        Alamofire.request(loginurl, method: .post, parameters: params)
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
                    let userData = arrayOfDic["message"]!
                    let forgetcode : String!
                    if("\(userData["forgetcode"] as! NSNull)" == "<null>"){
                        forgetcode = "null"
                    }else{
                        forgetcode = "\(userData["forgetcode"] as! String)"
                    }
                    AppDelegate.global_user = User(
                        id : "\(userData["id"] as! Int)",
                        name : userData["name"] as! String,
                        email : userData["email"] as! String,
                        password : userData["password"] as! String,
                        phone : userData["phone"] as! String,
                        address : userData["address"] as! String,
                        country : "\(userData["country"] as! Int)",
                        image : userData["image"] as! String,
                        role : "\(userData["role"] as! Int)",
                        device_id : userData["device_id"] as! String,
                        firebase_token : userData["firebase_token"] as! String,
                        forgetcode : "\(forgetcode)",
                        suspensed : "\(userData["suspensed"] as! Int)",
                        notification : "\(userData["notification"] as! Int)",
                        user_hash : userData["user_hash"] as! String,
                        countryname : userData["countryname"] as! String
                    )
                }
        }
    }
    //end get user data when sign up
    //start get_product
    func get_product(){
        products.removeAll()
        let ProductURL = "https://dkaken.alsalil.net/api/allitems"
        let params: [String : String] =
            [   "category"                  : "\(1)",
        ]
        Alamofire.request(ProductURL, method: .post, parameters: params)
            .responseJSON { response in
          //  print("the response is : \(response)")
            let result = response.result
          //  print("the result is : \(result.value)")
                var productnum : String = ""
                var size : String = ""
                var color : String = ""
                if let arrayOfDic  = result.value as? [String:Any]{
                    print("out : \(arrayOfDic["message"])")
                    let userData  = arrayOfDic["message"]  as? [[String: Any]]
                    print("userData : \(userData)")
                    for aDic1  in userData!  {
                        ///
//                        if("\(aDic1["productnum"]!)" == "<null>"){
//                            print("3!")
//                            productnum = "null"
//                        }else{
//                            print("3")
//                        }
//                        ////
//                        if("\(aDic1["size"]!)" == "<null>"){
//                            print("1!")
//                            size = "null"
//                        }else{
//                            print("1")
//                        }
//                        /////
//                        if("\(aDic1["color"]!)" == "<null>"){
//                            print("2!")
//                            color = "null"
//                        }else{
//                            print("2!")
//                        }
                    self.products.append(Product(
                        id : aDic1["id"] as! Int,
                        category : aDic1["category"] as! Int,
                        trader_id : aDic1["trader_id"] as! Int,
                        title : aDic1["title"] as! String,
                        price : aDic1["price"] as! Double,
                        desc : aDic1["desc"] as! String,
                        image : " ",
                        qty : aDic1["qty"] as! Int,
                        productnum : productnum,
                        size : size,
                        color : color,
                        suspensed : aDic1["suspensed"] as! Int,
                        created_at : aDic1["created_at"] as! String
                    ))
                }
                //  }
                self.collection.reloadData()
            }
        }
    }
    //end get_product
    //start getCvinfo
    func getCvinfo(){
        let alljobsURL = "https://dkaken.alsalil.net/api/alljobs"
        Alamofire.request(alljobsURL).responseJSON { response in
            // print("the response is : \(response)")
            let result = response.result
            // print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                // print("out : \(arrayOfDic)")
                if(arrayOfDic["success"] as! Bool == false ){
                    self.displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                             messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "emailOrPassword", comment: ""),
                                             titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
                    return
                }
                var messagedata = arrayOfDic["message"] as? [[String: Any]]
                for aDic1 in messagedata!{
                    self.cvs.append(CVS(
                        id: aDic1["id"] as! Int,
                        user_id: aDic1["user_id"] as! Int,
                        name: aDic1["name"] as! String,
                        country: aDic1["country"] as! String,
                        phone: aDic1["phone"] as! String,
                        age: aDic1["age"] as! String,
                        social_status:aDic1["social_status"] as! Int,
                        job:aDic1["job"] as! String,
                        certification: aDic1["certification"] as! String,
                        graduation_year: aDic1["graduation_year"] as! String,
                        suspensed: aDic1["suspensed"] as! Int,
                        created_at: aDic1["created_at"] as! String
                    ))
                    
                }
                self.jobsTableView.reloadData()
            }
        }
    }
    //end getCvinfo
 
    
}
    

