//
//  CompanyTabController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/20/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class CompanyTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: -Setting TabBar ViewControllers
        let layout = UICollectionViewFlowLayout()
        let resumesVC = UINavigationController(rootViewController: UserResumesVC(collectionViewLayout: layout))
        resumesVC.tabBarItem.title = "Резюме"
        resumesVC.tabBarItem.image = UIImage(named: "castTabBarButton")
        resumesVC.tabBarItem.selectedImage = UIImage(named: "castTabBarButtonActive")?.withRenderingMode(.alwaysOriginal)

        let companyProfileVC = UINavigationController(rootViewController: CompanyProfileVC())
        companyProfileVC.tabBarItem.title = "Профиль"
        companyProfileVC.tabBarItem.image = UIImage(named: "profileTabBarButton")
        companyProfileVC.tabBarItem.selectedImage = UIImage(named: "profileTabBarButtonActive")?.withRenderingMode(.alwaysOriginal)
        
        self.viewControllers = [resumesVC, companyProfileVC]

        self.tabBar.tintColor = UIColor.black
        self.tabBar.layer.borderColor = UIColor(r: 155, g: 155, b: 155).cgColor
        self.tabBar.layer.borderWidth = 0.4
        self.tabBar.isTranslucent = false
        
    }
}

