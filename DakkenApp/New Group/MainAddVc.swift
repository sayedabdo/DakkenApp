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
    @IBOutlet weak var avilablityLabel: UILabel!
    @IBOutlet weak var hitetochosse: UILabel!
    
    override func viewDidLoad() {
        addFootBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "food", comment: ""), for: .normal)
        addClothesBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Clothes", comment: ""), for: .normal)
        addJobsBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Job", comment: ""), for: .normal)
        addUsedBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "uesedproduct", comment: ""), for: .normal)
        avilablityLabel.text =  "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "onlytotager", comment: ""))"
        hitetochosse.text =  "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "chooseaddingtype", comment: ""))"
        
        super.viewDidLoad()
        buttonborder(button_outlet_name:addFootBtn)
        buttonborder(button_outlet_name:addClothesBtn)
        buttonborder(button_outlet_name:addJobsBtn)
        buttonborder(button_outlet_name:addUsedBtn)
        // Do any additional setup after loading the view.
        if(AppDelegate.global_user.role == "1"){
            avilablityLabel.isHidden = true
        }
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
        nextViewController.addStatus = 2
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
        nextViewController.addStatus = 3
        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        nextViewController.modalTransitionStyle = modalStyle
        self.present(nextViewController, animated:true, completion:nil)
    }
    func tageralert(){
        if(AppDelegate.global_user.role == "0"){
            JSSAlertView().danger(
                self,
                title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Error", comment: ""),
                text:  LocalizationSystem.sharedInstance.localizedStringForKey(key: "onlytotager", comment: ""),
                buttonText: LocalizationSystem.sharedInstance.localizedStringForKey(key: "ok", comment: "")
            )
            return
        }
    }
    
}
