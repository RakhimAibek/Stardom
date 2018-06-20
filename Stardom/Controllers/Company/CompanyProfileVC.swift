//
//  CompanyProfileVC.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/20/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class CompanyProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        self.setCustomNavBar(leftBarBTNimage: nil, leftSelectorFunc: nil, rightBarBTNimage: "settings_icon", rightSelectorFunc: #selector(settingBTNpressed), title: nil)
    }
    
    private func setupViews() {
        
    }
    
    private func setupConstraints() {
        
    }
    
    //ibactions
    @objc private func settingBTNpressed() {
        
    }

}

