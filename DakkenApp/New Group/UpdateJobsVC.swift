//
//  UpdateJobsVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/22/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import Alamofire

class UpdateJobsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var jobTitle: UITextField!
    @IBOutlet weak var certification: UITextField!
    @IBOutlet weak var graduationYear: UITextField!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var statusTableView: UITableView!
    @IBOutlet weak var changeImage: UIButton!
    var cvs : CVS!
    var status = ["متزوج","أعزب"]
    var tableStatus = 0
    var updateStatus : Int = 0
    let UPDATEJOB_URL = "https://dkaken.alsalil.net/api/updatejob"
    override func viewDidLoad() {
        super.viewDidLoad()
        statusTableView.dataSource = self
        statusTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    //start table view status
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return status.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell") as? StatusCell
            if(tableStatus == indexPath.row){
                cell?.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            }
        cell?.statusLabel.text = "\(status[indexPath.row])"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
            selectedCell.contentView.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            tableStatus = indexPath.row
    }
    //end table view status
    //Start change Image
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
    //end change Image
    //Start upDateInfoAction
    @IBAction func upDateInfoAction(_ sender: Any) {
        //check if the nameTextField textfield is empty or not
        if(nameTextField.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "username", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if the ageTextField textfield is empty or not
        if(ageTextField.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "username", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if the jobTitle textfield is empty or not
        if(jobTitle.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "username", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if the certification textfield is empty or not
        if(certification.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "username", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        //check if the graduationYear textfield is empty or not
        if(graduationYear.text?.isEmpty)!{
            displayAlertMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                                messageToDisplay: LocalizationSystem.sharedInstance.localizedStringForKey(key: "username", comment: ""),
                                titleofaction: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Try Again", comment: ""))
            return
        }
        uplaodJobInfo()
    }
    //End upDateInfoAction
    //Start deleteJob
    @IBAction func deleteJob(_ sender: Any) {
        let DELETEJOB_URL = "https://dkaken.alsalil.net/api/deljob"
        let params: [String : String] =
            [   "user_id"        : "\(AppDelegate.global_user.id)",
                "user_hash"      : "\(AppDelegate.global_user.user_hash)",
                "job_id"         : "\(1)"
            ]
        Alamofire.request(DELETEJOB_URL, method: .post, parameters: params)
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
                    }else{
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                }
        }
    }
    //End deleteJob
    //Start update data function
    ////////
    func uplaodJobInfo(){
        Alamofire.upload(multipartFormData: { multipartFormData in
            let params =
                [   "user_id"           : "\(AppDelegate.global_user.id)",
                    "user_hash"         : "\(AppDelegate.global_user.user_hash)",
                    "name"              : "\(self.nameTextField.text!)",
                    "age"               : "\(self.ageTextField.text!)",
                    "social_status"     : "\(self.tableStatus)",
                    "job"               : "\(self.jobTitle.text!)",
                    "certification"     : "\(self.certification.text!)",
                    "graduation_year"   : "\(self.graduationYear.text!)",
                    "job_id"            : "\(5)",
                    "Image"             : ""
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
                 to: self.UPDATEJOB_URL,method:HTTPMethod.post,
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
                                    nextViewController.userEmail = AppDelegate.global_user.email
                                    nextViewController.userPassword = AppDelegate.global_user.password
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
    //End update data function
    //Start Get Job data
    func getJobData(){
        let loginurl = "https://dkaken.alsalil.net/api/userjob"
        let params: [String : String] =
            [   "user_id"                  : "\(AppDelegate.global_user.id)",
                "user_hash"                : "\(AppDelegate.global_user.user_hash)",
            ]
        Alamofire.request(loginurl, method: .post, parameters: params)
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
                    let userData = arrayOfDic["message"]!
                    self.cvs = CVS.init(
                                   id : userData["id"] as! Int,
                                   user_id : userData["user_id"] as! Int,
                                   name : userData["name"] as! String,
                                   country : userData["country"] as! String,
                                   phone : userData["phone"] as! String,
                                   age : userData["age"] as! String,
                                   social_status : userData["social_status"] as! Int,
                                   job : userData["job"] as! String,
                                   certification : userData["certification"] as! String,
                                   graduation_year : userData["graduation_year"] as! String,
                                   suspensed : userData["suspensed"] as! Int,
                                   created_at : userData["created_at"] as! String,
                                   image : ""
                    )
                    self.nameTextField.text = "\(userData["name"] as! String)"
                    self.ageTextField.text = "\(userData["age"] as! String)"
                    self.jobTitle.text = "\(userData["job"] as! String)"
                    self.certification.text = "\(userData["certification"] as! String)"
                    self.graduationYear.text = "\(userData["graduation_year"] as! String)"
                    download_image(image_url:"",imagedisplayed: self.images)
                    self.tableStatus = userData["social_status"] as! Int
                    self.statusTableView.reloadData()
                }
        }
        
    }
    //End Get Job data
}
extension UpdateJobsVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UpdateJobsVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

