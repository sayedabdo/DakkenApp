//
//  ViewController.swift
//  Dakken
//
//  Created by Sayed Abdo on 10/15/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lebleltexttry: UILabel!
    @IBOutlet weak var btntry: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lebleltexttry.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "headertext", comment: "")
        lebleltexttry.text = LocalizationSystem.sharedInstance.getLanguage()
    }
    
    
    @IBAction func btnAction(_ sender: Any) {
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            print("ar")
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        } else {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
            print("en")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        viewDidLoad()
    }
    
    
}

