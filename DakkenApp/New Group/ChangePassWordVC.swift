//
//  ChangePassWordVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/19/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire

class ChangePassWordVC: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hhhh : \(AppDelegate.global_user.user_hash)")
        // Do any additional setup after loading the view.
        confirmTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "confirmpasswordPlaceHolder", comment: "")
        passwordTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "passwordPlaceHolder", comment: "")
    }
    
    @IBAction func changePassWord(_ sender: Any) {
        //check if the password textfield is empty or not
        if(passwordTextField.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "password", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check password lenght
        let pass = passwordTextField.text!
        if(Int(pass.count) < 6){
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "passwordlenght", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if the confirm password textfield is empty or not
        if(confirmTextField.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "confirmpassword", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if password and confirm is matched
        if(confirmTextField.text! != passwordTextField.text!){
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "password", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        let ChangePassWordURL = "https://dkaken.alsalil.net/api/changepassword"
        let params: [String : String] =
            [   "old_password"        : "\(AppDelegate.global_user.password)",
                "new_password"        : "\(passwordTextField.text!)",
                "confirmpassword"     : "\(confirmTextField.text!)",
                "user_hash"           : "\(AppDelegate.global_user.user_hash)",
                "user_id"             : "\(AppDelegate.global_user.id)"
            ]
        Alamofire.request(ChangePassWordURL, method: .post, parameters: params)
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
                    if(arrayOfDic["success"] as! Bool == true ){
                        self.displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                                 messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "emailOrPassword", comment: ""),
                                                 titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
                        return
                    }
                }
        }
    }
}
    



