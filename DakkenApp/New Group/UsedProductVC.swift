//
//  UsedProductVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 11/12/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class UsedProductVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

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
    var imagedone = false
    var imageCount = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
                selectedmainimage = false
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

