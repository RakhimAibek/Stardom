//
//  MainTabController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 4/19/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: -Setting TabBat ViewControllers
        let layout = UICollectionViewFlowLayout()
        let castVC = UINavigationController(rootViewController: CastingsViewController(collectionViewLayout: layout))
        castVC.tabBarItem.title = "Кастинги"
        castVC.tabBarItem.image = UIImage(named: "castTabBarButton")
        castVC.tabBarItem.selectedImage = UIImage(named: "castTabBarButtonActive")?.withRenderingMode(.alwaysOriginal)
        
        let myResponseVC = ResponseViewController()
        myResponseVC.tabBarItem.title = "Отклики"
        myResponseVC.tabBarItem.image = UIImage(named: "responseTabBarButton")
        myResponseVC.tabBarItem.selectedImage = UIImage(named: "responseTabBarButtonActive")?.withRenderingMode(.alwaysOriginal)
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(named: "profileTabBarButton")
        profileVC.tabBarItem.selectedImage = UIImage(named: "profileTabBarButtonActive")?.withRenderingMode(.alwaysOriginal)
        
        self.viewControllers = [castVC, myResponseVC, profileVC]
        
        self.tabBar.tintColor = UIColor.black
        self.tabBar.layer.borderColor = UIColor(r: 155, g: 155, b: 155).cgColor
        self.tabBar.layer.borderWidth = 0.4
        self.tabBar.isTranslucent = false
    }

}
