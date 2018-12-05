//
//  CallusVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 11/28/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire
import JSSAlertView

class CallusVC: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var msgTextView: UITextView!
    @IBOutlet weak var msgTitleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        msgTextView.delegate = self
        msgTextView.text = "نص الرساله"
        msgTextView.textColor = UIColor.lightGray
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if msgTextView.textColor == UIColor.lightGray {
            msgTextView.text = ""
           // msgTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if msgTextView.text == "" {
            
            msgTextView.text = "نص الرساله"
            msgTextView.textColor = UIColor.lightGray
        }
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sendAction(_ sender: Any) {
        let CALLUSURL = "https://dkaken.alsalil.net/api/contactus"
        let params: [String : String] =
            [   "name"                  : "\(AppDelegate.global_user.name)",
                "email"                 : "\(AppDelegate.global_user.email)",
                "subject"               : "\(msgTitleTextField.text!)",
                "message"               : "\(msgTextView.text!)"
            ]
        Alamofire.request(CALLUSURL, method: .post, parameters: params)
            .responseJSON { response in
                print("the response is : \(response)")
                let result = response.result
                print("the result is : \(String(describing: result.value))")
                if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                    if(arrayOfDic["success"] as! Bool == false ){
                        JSSAlertView().danger(
                            self,
                            title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                            text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "emailOrPassword", comment: ""),
                            buttonText: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: "")
                        )
                        return
                    }else{
                        self.displayAlerttomovetohome(title: "تهنينا",messageToDisplay: "تم ارسال رسالتك بنجاح😍")
                    }
                }
        }
    }
    
    func displayAlerttomovetohome(title: String,messageToDisplay: String)
    {
        let alertController = UIAlertController(title: title, message: messageToDisplay, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
            self.present(nextViewController, animated:true, completion:nil)
            return
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion:nil)
    }
    
}
