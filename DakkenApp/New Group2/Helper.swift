//
//  Helper.swift
//  Dakken
//
//  Created by Sayed Abdo on 10/15/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import Foundation
import Alamofire

extension UIViewController {
   
    //start function to display alert
    func displayAlertMessage(title: String,messageToDisplay: String, titleofaction : String)
    {
        let alertController = UIAlertController(title: title, message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: titleofaction, style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            return
        }
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion:nil)
    }
    //end function to display alert
    func share(text: String) {
        let objectsToShare = ["", text] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        self.present(activityVC, animated: true, completion: nil)
    }
    //function used to check is email valid or not
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
}
//start download image
func download_image(image_url:String,imagedisplayed:UIImageView){
    let remoteImageURL = URL(string: "https://dkaken.alsalil.net/users/images/\(image_url)")!
    Alamofire.request(remoteImageURL).responseData { (response) in
        if response.error == nil {
            print(response.result)
            // Show the downloaded image:
            if let data = response.data {
                imagedisplayed.image = UIImage(data: data)
            }else{
                return
            }
        }
    }
}
//end download image
//start button border
func buttonborder(button_outlet_name:UIButton){
    button_outlet_name.layer.cornerRadius = 8
    //button_outlet_name.layer.borderWidth = 0
   // button_outlet_name.layer.borderColor = UIColor.black.cgColor
}
