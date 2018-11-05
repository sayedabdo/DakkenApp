//
//  SignUPVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/17/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire

class SignUPVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    //OutLet
    @IBOutlet weak var imagebtn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var selectLocationBtn: UIButton!
    @IBOutlet weak var mapContinerView: UIView!
    @IBOutlet weak var imageas: UIImageView!
    //Var
    var role : Int!
    var imagedone : Bool = false
    let REGISTER_URL = "https://dkaken.alsalil.net/api/register"
    //Start viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(UIDevice.current.identifierForVendor!.uuidString)")
        // Do any additional setup after loading the view.
        imagebtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "chooseprofileimage", comment: ""), for: .normal)
        nameTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "namePlaceHolder", comment: "")
        emailTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "emailPlaceHolder", comment: "")
        passwordTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "passwordPlaceHolder", comment: "")
        phoneTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "phonePlaceHolder", comment: "")
        confirmTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "confirmpasswordPlaceHolder", comment: "")
        buttonborder(button_outlet_name:signUpBtn)
        self.hideKeyboardWhenTappedAround()
    }
    //End viewDidLoad
    //Start Back Buttton Action
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //End Back Buttton Action
    @IBAction func signUpAction(_ sender: Any) {
        //Start Validation
        //check if the nameTextField textfield is empty or not
        if(nameTextField.text?.isEmpty)!{
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
        //check if the phoneTextField textfield is empty or not
        if(phoneTextField.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "phone", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
                                return
        }
        if(imagedone == false){
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "profile image", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //End Validation
        //Call signUp function
        SignUpWithData()
    }
    //Start choosr image from calary or camera as a Acction Sheet
    @IBAction func trytochosseimage(_ sender: UITapGestureRecognizer) {
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
    //open Camera
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            present(myPickerController, animated: true, completion: nil)
        }
    }
    //open galary photo
    func photoLibrary()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            present(myPickerController, animated: true, completion: nil)
        }
    }
    ////display selected Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageas.image = pickedImage
            imagedone = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    //Start show map Action
    @IBAction func showMap(_ sender: Any) {
        mapContinerView.isHidden = false
    }
    //End show map Action
    ////////
    //Start SignUpWithData
    func SignUpWithData(){
        Alamofire.upload(multipartFormData: { multipartFormData in
            let params =
                [
                    
                    "name"                  : "\(self.nameTextField.text!)",
                    "email"                 : "\(self.emailTextField.text!)",
                    "password"              : "\(self.passwordTextField.text!)",
                    "confirmpass"           : "\(self.confirmTextField.text!)",
                    "phone"                 : "\(self.phoneTextField.text!)",
                    "country"               : "2",
                    "address"               : "b",
                    "firebase_token"        : "b",
                    "device_id"             : "\(UIDevice.current.identifierForVendor!.uuidString)",
                    "role"                  : "\(self.role)",
                    "job"                   : "0",
                    "image"                 : ""
                ]
            
            for (key, value) in params {
                if let data = value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                    multipartFormData.append(data, withName: key)
                }
            }
            let imageData1 = UIImageJPEGRepresentation(self.imageas.image as! UIImage, 0.5)!
            multipartFormData.append(imageData1, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            print("success");
        },
             to: self.REGISTER_URL,method:HTTPMethod.post,
             headers:nil, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload
                        .validate()
                        .responseJSON { response in
                            switch response.result {
                            case .success(let value):
                                print("responseObject: \(value)")
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                                nextViewController.userEmail = self.emailTextField.text!
                                nextViewController.userPassword = self.passwordTextField.text!
                                nextViewController.fromsignUp = true
                                self.present(nextViewController, animated:true, completion:nil)
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
    //End SignUpWithData
}
extension SignUPVC {
    //Hideen Keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(SignUPVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
