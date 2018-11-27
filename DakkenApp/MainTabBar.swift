//
//  MainTabBar.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 11/3/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController, UITabBarControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self

    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if viewController is BasketVC {
            print("First tab")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUPVC") as! SignUPVC
        }
    }



}
