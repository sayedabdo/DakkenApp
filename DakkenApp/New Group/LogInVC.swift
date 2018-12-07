//
//  LogInVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/16/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//


import UIKit
import Alamofire
import JSSAlertView

class LogInVC: UIViewController {
    
    //outlet
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var VCTitle: UILabel!
    @IBOutlet weak var activityIndi: UIActivityIndicatorView!
    @IBOutlet weak var ViewOfActivityIndi:UIView!
    //var
    var role : Int!
    //start viewDidLoad
    override func viewDidLoad() {
        loginBtn.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowAnimatedContent,
                       animations: { [weak self] in
                        self?.loginBtn.transform = .identity
            },
                       completion: nil)
        self.activityIndi.transform = CGAffineTransform(scaleX: 3, y: 3)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        if(role == 0 ){
            VCTitle.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "VCTitle0", comment: "")
        }
        if(role == 1 ){
           VCTitle.text =  "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "VCTitle1", comment: ""))"
        }
        loginBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "log in", comment: ""), for: .normal)
        emailTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "emailPlaceHolder", comment: "")
        passwordTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "passwordPlaceHolder", comment: "")
        buttonborder(button_outlet_name:loginBtn)

        self.hideKeyboardWhenTappedAround()
    }
    //End viewDidLoad
    //Start back Button Action
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //End back Button Action
    //Start to Sign UP VC with role
    @IBAction func toSignUpAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUPVC") as! SignUPVC
        nextViewController.role = role
        self.present(nextViewController, animated:true, completion:nil)
    }
    //End to Sign UP VC with role
    // function to login
    @IBAction func loginAction(_ sender: Any) {
        //Start Function Validation
        //check if the email textfield is valid or not
        let EmailAddress = emailTextField.text
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: EmailAddress!)
        if isEmailAddressValid
        {} else {
            JSSAlertView().danger(
                self,
                title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "email", comment: ""),
                buttonText: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: "")
            )
            return
        }
        //check if the password textfield is empty or not
        if(passwordTextField.text?.isEmpty)!{
            JSSAlertView().danger(
                self,
                title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "password", comment: ""),
                buttonText: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: "")
                )
            return
        }
        //End Function Validation
        //server Request by Alamofire
        let loginurl = "https://dkaken.alsalil.net/api/login"
        let params: [String : String] =
            [   "email"                  : "\(emailTextField.text!)",
                "password"               : "\(passwordTextField.text!)",
                "firebase_token"         : "b",
                "device_id"              : "\(UIDevice.current.identifierForVendor!.uuidString)"
            ]
        ViewOfActivityIndi.isHidden = false
        Alamofire.request(loginurl, method: .post, parameters: params)
            .responseJSON { response in
                print("the response is : \(response)")
                let result = response.result
                print("the result is : \(String(describing: result.value))")
                if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                    if(arrayOfDic["success"] as! Bool == false ){
                        self.ViewOfActivityIndi.isHidden = true
                        JSSAlertView().danger(
                            self,
                            title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                            text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "emailOrPassword", comment: ""),
                            buttonText: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: "")
                        )
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
                    //got to MainTabBar
                    self.ViewOfActivityIndi.isHidden = true
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
                    self.present(nextViewController, animated:true, completion:nil)
                }
        }
    }
}
extension LogInVC {
    //To Hidden Keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(LogInVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
