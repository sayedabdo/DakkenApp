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
    @IBOutlet weak var logo: UIImageView!
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        asTagerbtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Dealer Sign up", comment: ""), for: .normal)
        as3meal.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "user Sign up", comment: ""), for: .normal)
        
        buttonborder(button_outlet_name:asTagerbtn)
        buttonborder(button_outlet_name:as3meal)
        
        asTagerbtn.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.asTagerbtn.transform = .identity
            },
                       completion: nil)
        
        as3meal.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        timer =  Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(ChooseSignupVC.movess), userInfo: nil, repeats: true)
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.as3meal.transform = .identity
            },
                       completion: nil)
        
    }
   @objc func movess(){
    
        as3meal.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .curveLinear,
                       animations: { [weak self] in
                        self?.as3meal.transform = .identity
            },
                       completion: nil)
    
        asTagerbtn.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.asTagerbtn.transform = .identity
            },
                       completion: nil)
    
        logo.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.logo.transform = .identity
            },
                       completion: nil)
    }
    @IBAction func signUpAsTager(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        nextViewController.modalTransitionStyle = modalStyle
        nextViewController.role = 1
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func signUpAs3amel(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        nextViewController.modalTransitionStyle = modalStyle
        nextViewController.role = 0
        self.present(nextViewController, animated:true, completion:nil)
    }
}
