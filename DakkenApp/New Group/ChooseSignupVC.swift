//
//  ChooseSignupVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 10/16/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class ChooseSignupVC: UIViewController {

    @IBOutlet weak var asTagerbtn: UIButton!
    @IBOutlet weak var as3meal: UIButton!
    @IBOutlet weak var loginbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        asTagerbtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Dealer Sign up", comment: ""), for: .normal)
        as3meal.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "user Sign up", comment: ""), for: .normal)
        loginbtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "log in", comment: ""), for: .normal)
        buttonborder(button_outlet_name:asTagerbtn)
        buttonborder(button_outlet_name:as3meal)
        buttonborder(button_outlet_name:loginbtn)
    }
    @IBAction func signUpAsTager(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        nextViewController.type = 0
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func signUpAs3amel(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        nextViewController.type = 1
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func toLoginAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
        self.present(nextViewController, animated:true, completion:nil)
    }
}
