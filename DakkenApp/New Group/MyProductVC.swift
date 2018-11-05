//
//  MyProductVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/27/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire

class MyProductVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var products = [Product]()
    @IBOutlet weak var MyProductcollection: UICollectionView!
    override func viewDidLoad() {
        
        MyProductcollection.dataSource = self
        MyProductcollection.delegate = self
        super.viewDidLoad()
        get_My_product()
        // Do any additional setup after loading the view.
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
        guard let cell = MyProductcollection.dequeueReusableCell(withReuseIdentifier: "MyProductCell", for: indexPath) as? MyProductCell
            else { return UICollectionViewCell()
        }
        if(indexPath.row % 2 == 1){
            cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        }
        cell.setMyProduct(product: products[indexPath.row])
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.yellow.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.MyProductcollection.frame.size.width / 2 - 5, height: 175)
    }
    //end collection view
    //start back
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //end back
    //start get_My_product
    func get_My_product(){
        products.removeAll()
        let ProductURL = "https://dkaken.alsalil.net/api/useritems"
        let params: [String : String] =
            [   "trader_id"                  : "\(AppDelegate.global_user.id)",
                "user_hash"                  : "\(AppDelegate.global_user.user_hash)"
            ]
        Alamofire.request(ProductURL, method: .post, parameters: params)
            .responseJSON { response in
                print("the response is : \(response)")
                let result = response.result
                print("the result is : \(result.value)")
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
                    self.MyProductcollection.reloadData()
                }
        }
    }
    //end get_My_product
}
