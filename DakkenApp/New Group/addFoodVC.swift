//
//  addFoodVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 11/12/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire

class addFoodVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var VCTitle: UILabel!
    @IBOutlet weak var mainProductImage: UIImageView!
    @IBOutlet weak var chooseMainImageBtn: UIButton!
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var productNumberTextField: UITextField!
    @IBOutlet weak var productCountTextField: UITextField!
    @IBOutlet weak var productPriceTextField: UITextField!
    @IBOutlet weak var productDescriptionTextField: UITextField!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var addProductBtn: UIButton!
    var selectedmainimage = false
    var imagedone  = false
    var imageCount = 1
    var ADDITEMURL = "https://dkaken.alsalil.net/api/additem"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    @IBAction func cancelimages(_ sender: Any) {
        if(imageCount == 2){
            image2.image = UIImage(named: "Logo")
            imageCount -= 1
        }
        if(imageCount == 3){
            image3.image = UIImage(named: "Logo")
            imageCount -= 1
        }
        if(imageCount == 4){
           image4.image = UIImage(named: "Logo")
            imageCount -= 1
        }
    }
    @IBAction func addProductAction(_ sender: Any) {
        //check to chosse main Image
        if(selectedmainimage == false){
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "username", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if the productNameTextField textfield is empty or not
        if(productNameTextField.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "username", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if the productNumberextField textfield is empty or not
        if(productNumberTextField.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "username", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if the productCountTextField textfield is empty or not
        if(productCountTextField.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "username", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if the productPriceTextField textfield is empty or not
        if(productPriceTextField.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "username", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if the producDescriptionTextField textfield is empty or not
        if(productDescriptionTextField.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "username", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        addItemRequest()
    }
    //chosse image
    @IBAction func changeimage(_ sender: Any) {
        if((sender as AnyObject).tag == 2){
            if(imageCount == 4){
                displayAlertMessage(title: "تنبيه!", messageToDisplay: "تم اختيار الحد الاقصى من الصور 😞😞😞", titleofaction: "موافق")
                return
            }
        }
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            if((sender as AnyObject).tag == 1){
                self.imagedone = false
            }
            if((sender as AnyObject).tag == 2){
                self.imagedone = true
            }
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            if((sender as AnyObject).tag == 1){
                self.imagedone = false
            }
            if((sender as AnyObject).tag == 2){
                self.imagedone = true
            }
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
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
            if(imagedone == false){
                mainProductImage.image = pickedImage
                imagedone = true
                selectedmainimage = true
                picker.dismiss(animated: true, completion: nil)
                return
            }
            if(imageCount != 4){
                imageCount += 1
            }
            if(imageCount == 2){
                image2.image=pickedImage
            }
            if(imageCount == 3){
                image3.image=pickedImage
            }
            if(imageCount == 4){
                image4.image=pickedImage
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    //Start function to post request to add new food
    func addItemRequest(){
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            let params =
                [   "category"       : "\(1)",
                    "trader_id"      : "\(AppDelegate.global_user.id)",
                    "user_hash"      : "\(AppDelegate.global_user.user_hash)",
                    "title"          : "\(self.productNameTextField.text!)",
                    "price"          : "\(self.productPriceTextField.text!)",
                    "qty"            : "\(self.productCountTextField.text!)",
                    "desc"           : "\(self.productDescriptionTextField.text!)",
                    "image"          : "",
                    "itemimgs[]"     : "",
                    "productnum"     : "\(self.productNumberTextField.text!)",
                    "size"           : "",
                    "color "         : "",
                    ]
            
            for (key, value) in params {
                if let data = value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                    multipartFormData.append(data, withName: key)
                    
                }
            }
            
            let imageData1 = UIImageJPEGRepresentation(self.mainProductImage.image as! UIImage, 0.5)!
            multipartFormData.append(imageData1, withName: "image", fileName: "mainImage.jpg", mimeType: "image/jpeg")
            print("success");
            
            for i in 2..<self.imageCount + 1{
                print("i == \(i)")
                if (i == 2){
                    let imageData1 = UIImageJPEGRepresentation(self.image2.image as! UIImage, 0.5)!
                    multipartFormData.append(imageData1, withName: "itemimgs[]", fileName: "image1.jpg", mimeType: "image/jpeg")
                    print("success");
                }
                if (i == 3){
                    let imageData1 = UIImageJPEGRepresentation(self.image3.image as! UIImage, 0.5)!
                    multipartFormData.append(imageData1, withName: "itemimgs[]", fileName: "image1.jpg", mimeType: "image/jpeg")
                    print("success");
                }
                if (i == 4){
                    let imageData1 = UIImageJPEGRepresentation(self.image4.image as! UIImage, 0.5)!
                    multipartFormData.append(imageData1, withName: "itemimgs[]", fileName: "image1.jpg", mimeType: "image/jpeg")
                    print("success");
                }
                
            }
            //                        for i in 1..<self.imageDataArray.count{
            //                            if self.imageFlagArray[i] as! Bool == true{
            //                                let imageData1 = UIImageJPEGRepresentation(self.imageDataArray[i] as! UIImage, 0.5)!
            //                                multipartFormData.append(imageData1, withName: "image"+String(format:"%d",i), fileName: "image.jpg", mimeType: "image/jpeg")
            //                                print("success");
            //                            }
            //                        }
            
        },
                         to: self.ADDITEMURL,method:HTTPMethod.post,
                         headers:nil, encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload
                                    .validate()
                                    .responseJSON { response in
                                        switch response.result {
                                        case .success(let value):
                                            print("responseObject: \(value)")
                                            self.displayAlertMessage(title: "تنبيه",messageToDisplay: "تم اضافه المنتج😍 بنجاح", titleofaction : "الرئيسيه")
                                        case .failure(let responseError):
                                            print("responseError: \(responseError)")
                                        }
                                }
                            case .failure(let encodingError):
                                print("encodingError: \(encodingError)")
                            }
        })
        
        
        
        
    }
}
extension addFoodVC {
    //Hideen Keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(addFoodVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
