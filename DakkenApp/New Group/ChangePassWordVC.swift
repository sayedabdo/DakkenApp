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
    @IBOutlet weak var changeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hhhh : \(AppDelegate.global_user.user_hash)")
        // Do any additional setup after loading the view.
        confirmTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "confirmpasswordPlaceHolder", comment: "")
        passwordTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "passwordPlaceHolder", comment: "")
        self.hideKeyboardWhenTappedAround()
        buttonborder(button_outlet_name:changeBtn)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        let ReChangePassURL = "https://dkaken.alsalil.net/api/rechangepass"
        let params: [String : String] =
            [
                "new_password"        : "\(passwordTextField.text!)",
                "confirmpassword"     : "\(confirmTextField.text!)",
                "user_hash"           : "\(AppDelegate.global_user.user_hash)",
            ]
        Alamofire.request(ReChangePassURL, method: .post, parameters: params)
            .responseJSON { response in
                print("the response is : \(response)")
                let result = response.result
                print("the result is : \(String(describing: result.value))")
                if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                    if(arrayOfDic["success"] as! Bool == false ){
                        self.displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                                 messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "some_error", comment: ""),
                                                 titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
                        return
                    }
                    if(arrayOfDic["success"] as! Bool == true ){
                        self.displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Done", comment: ""),
                                                 messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "passwordchanged", comment: ""),
                                                 titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "home", comment: ""))
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                }
        }
    }
}
extension ChangePassWordVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(ChangePassWordVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



