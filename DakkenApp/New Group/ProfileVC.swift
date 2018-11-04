//
//  ProfileVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/22/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire

class ProfileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var updateDataBtn: UIButton!
    @IBOutlet weak var chooseImageBtn: UIButton!
    @IBOutlet weak var jobBtn: UIButton!
    
    let UPDATEProfile_URL = "https://dkaken.alsalil.net/api/updateprofile"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTextFiled.text  = "\(AppDelegate.global_user.name)"
        emailTextField.text = "\(AppDelegate.global_user.email)"
        PhoneTextField.text = "\(AppDelegate.global_user.phone)"
        download_image(image_url: AppDelegate.global_user.image,imagedisplayed: images)
        buttonborder(button_outlet_name:updateDataBtn)
        buttonborder(button_outlet_name:chooseImageBtn)
    }

    @IBAction func changeimage(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            present(myPickerController, animated: true, completion: nil)
        }
    }
    func photoLibrary()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            present(myPickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            images.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openJobAction(_ sender: Any) {
        if(AppDelegate.global_user.job == 0){
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "password", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateJobsVC") as! UpdateJobsVC
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    @IBAction func openchangePassWord(_ sender: Any) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ChangePassWordVC") as! ChangePassWordVC
            self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func updateAction(_ sender: Any) {
        //check if the nameTextField textfield is empty or not
        if(nameTextFiled.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "username", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if the email textfield is valid or not
        let EmailAddress = emailTextField.text
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: EmailAddress!)
        if isEmailAddressValid
        {} else {
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "email", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if the phoneTextField textfield is empty or not
        if(PhoneTextField.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "phone", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        uplaoddata()
    }
        //Start update Profile
        ////////
        func uplaoddata(){
            Alamofire.upload(multipartFormData: { multipartFormData in
                let params =
                    [   "name"                : "\(self.nameTextFiled.text!)",
                        "image"               : "",
                        "phone"               : "\(self.PhoneTextField.text!)",
                        "email"               : "\(self.emailTextField.text!)",
                        "user_id"             : "\(AppDelegate.global_user.id)",
                        "user_hash"           : "\(AppDelegate.global_user.user_hash)",
                        "address"             : "\(AppDelegate.global_user.address)",
                        "notification"        : "1",
                        "country"             : "\(AppDelegate.global_user.country)",
                    ]
                for (key, value) in params {
                    if let data = value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                        multipartFormData.append(data, withName: key)
                    }
                }
                let imageData1 = UIImageJPEGRepresentation(self.images.image as! UIImage, 0.5)!
                multipartFormData.append(imageData1, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                print("success");
            },
                 to: self.UPDATEProfile_URL,method:HTTPMethod.post,
                 headers:nil, encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload
                            .validate()
                            .responseJSON { response in
                                switch response.result {
                                    case .success(let value):
                                        print("responseObject: \(value)")
                                        if let arrayOfDic = value as? Dictionary<String, AnyObject> {
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
                                        self.upDateDoneAlert(title: "!!@",messageToDisplay: "تم تحديث الداتا بنجاح", titleofaction : "home")
                                case .failure(let responseError):
                                    print("responseError: \(responseError)")
                                    self.displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                                             messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "signuperoor", comment: ""),
                                                             titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
                                    return
                                }
                        }
                    case .failure(let encodingError):
                        print("encodingError: \(encodingError)")
                    }
            })
        }
    //start function to display alert
    func upDateDoneAlert(title: String,messageToDisplay: String, titleofaction : String)
    {
        let alertController = UIAlertController(title: title, message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: titleofaction, style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
            self.present(nextViewController, animated:true, completion:nil)
            return
        }
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion:nil)
    }
        
    }
