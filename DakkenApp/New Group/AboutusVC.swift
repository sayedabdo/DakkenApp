//
//  AboutusVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 12/4/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire

class AboutusVC: UIViewController {

    @IBOutlet weak var aboutUsLabel: UILabel!
    @IBOutlet weak var syastTheApp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData()
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func getData(){
        let project_url = "https://dkaken.alsalil.net/api/settings"
        Alamofire.request(project_url).responseJSON { response in
            print("the response is : \(response)")
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
            let userData = arrayOfDic["message"]! as? [[String: Any]]
                for aDic1 in userData!{
                    self.aboutUsLabel.text = "\(aDic1["enabout"])"
                    self.syastTheApp.text = "\(aDic1["enpolicy"])"
                }
            }
            
        }
    }
}
