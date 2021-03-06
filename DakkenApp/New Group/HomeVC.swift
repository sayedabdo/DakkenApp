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

class HomeVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource{
    //Outlet
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var mnuecollection: UICollectionView!
    @IBOutlet weak var mnue2collection: UICollectionView!
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    @IBOutlet weak var menusView: UIView!
    @IBOutlet weak var menubtn: UIButton!
    @IBOutlet weak var activityIndi: UIActivityIndicatorView!
    @IBOutlet weak var VCtitle: UILabel!
    
    //Var
    var userEmail : String! = ""
    var userPassword : String! = ""
    var fromsignUp : Bool = false
    var tab_data : [String] = ["الأكلات","الملابس","منتجات مستعمله","وظائف","المجتمع"]
    var tab_data_English : [String] = ["Foods" , "clothes" , "used product" , "jobs" , "socity"]
    var firstMune = ["منتجات مستعمله","الملابس","الأكلات","المزيد","المجتمع","وظائف"]
    var firstMuneEnglish = ["Used","clothes","Food","More","Socity","Jobs"]
    var secondMune = ["الطلبات","اتصل بنا","الأعدادات","عن التطبيق"]
    var secondMuneEnglish = ["Orders","Call us","Setting","About App"]
    var firstMuneColor = [#colorLiteral(red: 0, green: 0.7417340875, blue: 0.6716778874, alpha: 1),#colorLiteral(red: 0.8823529412, green: 0.6509803922, blue: 0.2980392157, alpha: 1),#colorLiteral(red: 0.8509803922, green: 0.368627451, blue: 0.2352941176, alpha: 1),#colorLiteral(red: 0.4666666667, green: 0.5254901961, blue: 0.5529411765, alpha: 1),#colorLiteral(red: 0.7254901961, green: 0.7568627451, blue: 0.2901960784, alpha: 1),#colorLiteral(red: 0.2901960784, green: 0.6235294118, blue: 0.768627451, alpha: 1)]
    var secondMuneColor = [#colorLiteral(red: 0.7254901961, green: 0.7568627451, blue: 0.2901960784, alpha: 1),#colorLiteral(red: 0.2901960784, green: 0.6235294118, blue: 0.768627451, alpha: 1),#colorLiteral(red: 0.8823529412, green: 0.6509803922, blue: 0.2980392157, alpha: 1),#colorLiteral(red: 0.8509803922, green: 0.368627451, blue: 0.2352941176, alpha: 1)]
    var firstmenuimage = ["natrl","shrt","food","add","grop","caric"]
    var secondmenuimage = ["phone","food","aboutapp","usere"]
    var tab_data_count = 0
    var products = [Product]()
    var cvs = [CVS]()
    
    //Start viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        mnuecollection.dataSource = self
        mnuecollection.delegate = self
        mnue2collection.dataSource = self
        mnue2collection.delegate = self
        jobsTableView.dataSource = self
        jobsTableView.delegate = self
        // Do any additional setup after loading the view.
        menubtn.isHidden = true
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            for tabDataCounter in tab_data{
                self.segmentedControl.insertSegment(withTitle: "\(tabDataCounter)", at: self.tab_data_count)
                self.tab_data_count = self.tab_data_count + 1
            }
        }else{
            for tabDataCounter in tab_data_English{
                self.segmentedControl.insertSegment(withTitle: "\(tabDataCounter)", at: self.tab_data_count)
                self.tab_data_count = self.tab_data_count + 1
            }
        }
        //start segmentedControl
        segmentedControl.segmentStyle = .textOnly
        segmentedControl.underlineSelected = true
        // change some colors in segmentedControl
        segmentedControl.segmentContentColor = UIColor.black
        segmentedControl.selectedSegmentContentColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.backgroundColor = #colorLiteral(red: 0.9586617351, green: 0.4347025454, blue: 0.2375041842, alpha: 1)
        segmentedControl.selectedSegmentIndex = AppDelegate.selectedsegment
        //end segmentedControl
        jobsTableView.backgroundView = UIImageView(image: UIImage(named: "bgimage"))
        VCtitle.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "home", comment: ""))"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
    func viewLoadSetup(){
        // setup view did load here
        //get_product(category: 1)
        //get user data after sign up
        if(fromsignUp == true){
            getUserData()
        }
    }
    //End viewDidLoad
    //start collection view to display product
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collection){
            print("the count is : ", products.count)
            return products.count
        }
        if(collectionView == mnuecollection){
            print("the count is : ", firstMune.count)
            return firstMune.count
        }
        if(collectionView == mnue2collection){
            print("the count is : ", secondMuneColor.count)
            return secondMuneColor.count
        }
        return products.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == collection){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FoodsDetailesVC") as! FoodsDetailesVC
            nextViewController.product = products[indexPath.row]
            self.present(nextViewController, animated:true, completion:nil)
        }
        if(collectionView == mnuecollection){
            if(indexPath.row == 0){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
                AppDelegate.selectedsegment = 2
                self.present(nextViewController, animated:true, completion:nil)
            }
            if(indexPath.row == 1){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
                AppDelegate.selectedsegment = 1
                self.present(nextViewController, animated:true, completion:nil)
            }
            if(indexPath.row == 2){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
                AppDelegate.selectedsegment = 0
                self.present(nextViewController, animated:true, completion:nil)
            }
            if(indexPath.row == 3){
                mnue2collection.isHidden = false
                menubtn.isHidden = false
            }
            if(indexPath.row == 4){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
                AppDelegate.selectedsegment = 4
                self.present(nextViewController, animated:true, completion:nil)
            }
            if(indexPath.row == 5){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
                AppDelegate.selectedsegment = 3
                self.present(nextViewController, animated:true, completion:nil)
            }
        }
        if(collectionView == mnue2collection){
            if(indexPath.row == 0){
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CallusVC") as! CallusVC
//                AppDelegate.selectedsegment = 0
//                self.present(nextViewController, animated:true, completion:nil)
            }
            if(indexPath.row == 1){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CallusVC") as! CallusVC
                AppDelegate.selectedsegment = 0
                self.present(nextViewController, animated:true, completion:nil)
            }
            if(indexPath.row == 2){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
                self.present(nextViewController, animated:true, completion:nil)
            }
            if(indexPath.row == 3){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AboutusVC") as! AboutusVC
                AppDelegate.selectedsegment = 0
                self.present(nextViewController, animated:true, completion:nil)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if(collectionView == collection){
            guard let cell = collection.dequeueReusableCell(withReuseIdentifier: "HomeproductCell", for: indexPath) as? HomeproductCell
                else { return UICollectionViewCell()
            }
            cell.setProduct(product: products[indexPath.row])
            cell.addtToCard.tag = indexPath.row
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return cell
        }
        if(collectionView == mnuecollection){
            guard let cell = mnuecollection.dequeueReusableCell(withReuseIdentifier: "oneMuneCell", for: indexPath) as? oneMuneCell
                else { return UICollectionViewCell()
            }
            if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
                cell.muneTitle.text = "\(firstMune[indexPath.row])"
            }else{
                cell.muneTitle.text = "\(firstMuneEnglish[indexPath.row])"
            }
            cell.muneimage.image = UIImage(named: "\(firstmenuimage[indexPath.row])")
            cell.backgroundColor = firstMuneColor[indexPath.row]
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return cell
        }
     //   if(collectionView == mnue2collection){
        else{
            guard let cell = mnue2collection.dequeueReusableCell(withReuseIdentifier: "twoMuneCell", for: indexPath) as? twoMuneCell
                else { return UICollectionViewCell()
            }
            if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
                cell.muneTitle.text = "\(secondMune[indexPath.row])"
            }else{
                cell.muneTitle.text = "\(secondMuneEnglish[indexPath.row])"
            }
            cell.backgroundColor = secondMuneColor[indexPath.row]
            cell.muneimage.image = UIImage(named: "\(secondmenuimage[indexPath.row])")
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return cell
        }
      //  return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == collection){
            if(AppDelegate.global_user.role == "1"){
                return CGSize(width: self.collection.frame.size.width / 2 - 5, height: 180)
            }else
            {
                return CGSize(width: self.collection.frame.size.width / 2 - 5, height: 200)
            }
        }
        if(collectionView == mnuecollection){
            return CGSize(width: (self.mnuecollection.frame.size.width / 3) - 10, height: 80)
        }
        if(collectionView == mnue2collection){
            return CGSize(width: (self.mnuecollection.frame.size.width / 2) - 10, height: 80)
        }
        return CGSize(width: (self.mnuecollection.frame.size.width / 3) - 10, height: 80)
    }
    //End collection view to display product
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
    
    @IBAction func showMuneAction(_ sender: Any) {
        menusView.isHidden = false
    }
    @IBAction func cloesMenuAction(_ sender: Any) {
        menusView.isHidden = true
        mnue2collection.isHidden = true
        menubtn.isHidden = true
    }
    @IBAction func menubackAction(_ sender: Any) {
        mnue2collection.isHidden = true
        menubtn.isHidden = true
    }
    
    //start custom segement
    @IBAction func segmentSelected(sender:ScrollableSegmentedControl) {
        
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
        if(sender.selectedSegmentIndex == 0){
            get_product(category: 1)
            collection.isHidden = false
            jobsTableView.isHidden = true
        }
        if(sender.selectedSegmentIndex == 1){
            get_product(category: 2)
            collection.isHidden = false
            jobsTableView.isHidden = true
        }
        if(sender.selectedSegmentIndex == 2){
            get_product(category: 3)
            collection.isHidden = false
            jobsTableView.isHidden = true
        }
        if(sender.selectedSegmentIndex == 3){
            getCvinfo()
            collection.isHidden = true
            jobsTableView.isHidden = false
        }
        if(sender.selectedSegmentIndex == 4){
            get_product(category: 5)
            collection.isHidden = false
            jobsTableView.isHidden = true
        }
    }
    //end custom segement
    //Start Add To Card Action
    @IBAction func AddtocardAction(_ sender: Any) {
        AddToCard(thisProduct : products[(sender as AnyObject).tag])
    }
    //End Add To Card Action
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
                        countryname : userData["countryname"] as! String,
                        job : userData["job"] as! Int
                    )
                }
        }
    }
    //end get user data when sign up
    //start get_product
    func get_product(category : Int){
        self.activityIndi.startAnimating()
        products.removeAll()
        let ProductURL = "https://dkaken.alsalil.net/api/allitems"
        let params: [String : String] =
            [   "category"                  : "\(category)",
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
                    let userData  = arrayOfDic["message"]  as? [[String: Any]]
                    for aDic1  in userData!  {
                        ///
                        if("\(aDic1["productnum"]!)" == "<null>"){
                            productnum = "null"
                        }else{
                            productnum = "\(aDic1["productnum"]!)"
                        }
                        ////
                        if("\(aDic1["size"]!)" == "<null>"){
                            size = "null"
                        }else{
                            size = "\(aDic1["size"]!)"
                        }
                        /////
                        if("\(aDic1["color"]!)" == "<null>"){
                            color = "null"
                        }else{
                            color = "\(aDic1["color"]!)"
                        }
                    self.products.append(Product(
                        id : aDic1["id"] as! Int,
                        category : aDic1["category"] as! Int,
                        trader_id : aDic1["trader_id"] as! Int,
                        title : aDic1["title"] as! String,
                        price : aDic1["price"] as! Double,
                        desc : aDic1["desc"] as! String,
                        image : aDic1["image"] as! String,
                        qty : aDic1["qty"] as! Int,
                        productnum : productnum,
                        size : size,
                        color : color,
                        suspensed : aDic1["suspensed"] as! Int,
                        created_at : aDic1["created_at"] as! String
                    ))
                }
                //  }
                    self.activityIndi.stopAnimating()
                    self.collection.reloadData()
            }
        }
    }
    //end get_product
    //start getCvinfo
    func getCvinfo(){
        self.activityIndi.startAnimating()
        cvs.removeAll()
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
                        country: aDic1["country"] as! Int,
                        phone: aDic1["phone"] as! String,
                        age: aDic1["age"] as! String,
                        social_status:aDic1["social_status"] as! Int,
                        job:aDic1["job"] as! String,
                        certification: aDic1["certification"] as! String,
                        graduation_year: aDic1["graduation_year"] as! String,
                        suspensed: aDic1["suspensed"] as! Int,
                        created_at: aDic1["created_at"] as! String,
                        image : aDic1["image"] as! String
                    ))
                }
                self.activityIndi.stopAnimating()
                self.jobsTableView.reloadData()
            }
        }
    }
    //end getCvinfo
    //Start Add To Card
    func AddToCard(thisProduct : Product){
        let AddToCardURL = "https://dkaken.alsalil.net/api/addtocart"
        let params: [String : String] =
            [   "user_hash"            : "\(AppDelegate.global_user.user_hash)",
                "item_id"              : "\(thisProduct.id)",
                "owner"                : "\(AppDelegate.global_user.id)",
                "trader"               : "\(thisProduct.trader_id)",
                "qty"                  : "\(1)",
                "price"                : "\(thisProduct.price)"
        ]
        Alamofire.request(AddToCardURL, method: .post, parameters: params)
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
                    self.displayAlertMessage(title : "Done",
                                             messageToDisplay: "product Add to card",
                                             titleofaction: "OK")
                }
        }
    }
    //end Add To Card
}
    


