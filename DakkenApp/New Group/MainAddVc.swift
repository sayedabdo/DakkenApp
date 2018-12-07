//
//  MainAddVc.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 11/26/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit
import JSSAlertView

class MainAddVc: UIViewController {

    
    @IBOutlet weak var addFootBtn: UIButton!
    @IBOutlet weak var addClothesBtn: UIButton!
    @IBOutlet weak var addJobsBtn: UIButton!
    @IBOutlet weak var addUsedBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonborder(button_outlet_name:addFootBtn)
        buttonborder(button_outlet_name:addClothesBtn)
        buttonborder(button_outlet_name:addJobsBtn)
        buttonborder(button_outlet_name:addUsedBtn)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addFootAction(_ sender: Any) {
        tageralert()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "addFoodVC") as! addFoodVC
        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        nextViewController.modalTransitionStyle = modalStyle
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func addClothesAction(_ sender: Any) {
        tageralert()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UsedProductVC") as! UsedProductVC
        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        nextViewController.modalTransitionStyle = modalStyle
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func addJobsAction(_ sender: Any) {
        tageralert()
        if(AppDelegate.global_user.job == 1){
            JSSAlertView().danger(
                self,
                title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                text:  LocalizationSystem.sharedInstance.localizedStringForKey(key: "youhaveajob", comment: ""),
                buttonText: LocalizationSystem.sharedInstance.localizedStringForKey(key: "ok", comment: "")
            )
            return
        }
        if(AppDelegate.global_user.job == 0){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddJobVC") as! AddJobVC
            let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.flipHorizontal
            nextViewController.modalTransitionStyle = modalStyle
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    @IBAction func addUsedAction(_ sender: Any) {
        tageralert()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UsedProductVC") as! UsedProductVC
        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        nextViewController.modalTransitionStyle = modalStyle
        self.present(nextViewController, animated:true, completion:nil)
    }
    func tageralert(){
        if(AppDelegate.global_user.role == "0"){
            JSSAlertView().danger(
                self,
                title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                text:  LocalizationSystem.sharedInstance.localizedStringForKey(key: "إضافه المنتجات متاحه فقط للتجار", comment: ""),
                buttonText: LocalizationSystem.sharedInstance.localizedStringForKey(key: "ok", comment: "")
            )
            return
        }
    }
    
}
