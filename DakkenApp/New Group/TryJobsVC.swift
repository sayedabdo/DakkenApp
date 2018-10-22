//
//  TryJobsVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/21/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire
class TryJobsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var jobsTableView: UITableView!
    var cvs = [CVS]()
    override func viewDidLoad() {
        super.viewDidLoad()
        jobsTableView.dataSource = self
        jobsTableView.delegate = self
        // Do any additional setup after loading the view.
        getCvinfo()
    }
    

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

}
