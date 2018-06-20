//
//  ExtensionFuncsVC.swift
//  Stardom
//
//  Created by Aibek Rakhim on 3/28/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // to know all fonts uploaded in xcode
    func printAllFontsName() {
        
        UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            print(familyName, fontNames)
        })
        
    }
    
    //MARK: - for child view controllers
    func setupNavBarChild(selectorLeft: Selector, title: String?) {
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "leftWhiteBackBarBTN")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: selectorLeft)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        if title != nil {
            navigationItem.title = title!
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "ProximaNova-Bold", size: 20.0)!, NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }
    
    //MARK: - for UIViewControllers: cast, response, profile VC
    func setCustomNavBar(leftBarBTNimage: String?, leftSelectorFunc: Selector?, rightBarBTNimage: String?, rightSelectorFunc: Selector?, title: String?) {
        
        if leftBarBTNimage != nil && leftSelectorFunc != nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: leftBarBTNimage!)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: leftSelectorFunc!)
        }
        
        if rightBarBTNimage != nil && rightSelectorFunc != nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: rightBarBTNimage!)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: rightSelectorFunc!)
        }
        
        if title != nil {
            navigationItem.title = title!
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "ProximaNova-Bold", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor(r: 3, g: 3, b: 3)]
        }
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor(r: 249, g: 249, b: 250)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
