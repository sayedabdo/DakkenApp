//
//  trymnueVC.swift
//  DakkenApp
//
//  Created by Sayed Abdo on 12/4/18.
//  Copyright © 2018 sayedAbdo. All rights reserved.
//

import UIKit

class trymnueVC: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var mnuecollection: UICollectionView!
    @IBOutlet weak var mnue2collection: UICollectionView!
    var firstMune = ["منتجات مستعمله","الملابس","الأكلات","المزيد","المجتمع","وظائف"]
    var secondMune = ["الطلبات","اتصل بنا","الأعدادات","عن التطبيق"]
    var firstMuneColor = [#colorLiteral(red: 0, green: 0.7417340875, blue: 0.6716778874, alpha: 1),#colorLiteral(red: 0.8823529412, green: 0.6509803922, blue: 0.2980392157, alpha: 1),#colorLiteral(red: 0.8509803922, green: 0.368627451, blue: 0.2352941176, alpha: 1),#colorLiteral(red: 0.4666666667, green: 0.5254901961, blue: 0.5529411765, alpha: 1),#colorLiteral(red: 0.7254901961, green: 0.7568627451, blue: 0.2901960784, alpha: 1),#colorLiteral(red: 0.2901960784, green: 0.6235294118, blue: 0.768627451, alpha: 1)]
    var secondMuneColor = [#colorLiteral(red: 0.7254901961, green: 0.7568627451, blue: 0.2901960784, alpha: 1),#colorLiteral(red: 0.2901960784, green: 0.6235294118, blue: 0.768627451, alpha: 1),#colorLiteral(red: 0.8823529412, green: 0.6509803922, blue: 0.2980392157, alpha: 1),#colorLiteral(red: 0.8509803922, green: 0.368627451, blue: 0.2352941176, alpha: 1)]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mnuecollection.dataSource = self
        mnuecollection.delegate = self
        mnue2collection.dataSource = self
        mnue2collection.delegate = self
    }
    //start collection view to display product
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == mnuecollection){
            print("the count is : ", firstMune.count)
            return firstMune.count
        }
        if(collectionView == mnue2collection){
            print("the count is : ", secondMuneColor.count)
            return secondMuneColor.count
        }
        return firstMune.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FoodsDetailesVC") as! FoodsDetailesVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mnuecollection.dequeueReusableCell(withReuseIdentifier: "oneMuneCell", for: indexPath) as? oneMuneCell
            else { return UICollectionViewCell()
        }
        if(collectionView == mnuecollection){
            guard let cell = mnuecollection.dequeueReusableCell(withReuseIdentifier: "oneMuneCell", for: indexPath) as? oneMuneCell
                else { return UICollectionViewCell()
            }
            cell.muneTitle.text = "\(firstMune[indexPath.row])"
            cell.backgroundColor = firstMuneColor[indexPath.row]
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return cell
        }
        if(collectionView == mnue2collection){
            guard let cell = mnue2collection.dequeueReusableCell(withReuseIdentifier: "twoMuneCell", for: indexPath) as? twoMuneCell
                else { return UICollectionViewCell()
            }
            cell.muneTitle.text = "\(secondMune[indexPath.row])"
            cell.backgroundColor = secondMuneColor[indexPath.row]
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return cell
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == mnuecollection){
             return CGSize(width: (self.mnuecollection.frame.size.width / 3) - 10, height: 80)
        }
        if(collectionView == mnue2collection){
             return CGSize(width: (self.mnuecollection.frame.size.width / 2) - 10, height: 80)
        }
        return CGSize(width: (self.mnuecollection.frame.size.width / 3) - 10, height: 80)
    }
    //End collection view to display product

}
