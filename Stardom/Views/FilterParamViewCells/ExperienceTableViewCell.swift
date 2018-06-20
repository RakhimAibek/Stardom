//
//  ExperienceTableViewCell.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/1/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {
    
    let experienceLabel: UILabel = {
        let label = UILabel()
        label.text = "Есть опыт работы*"
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        label.textColor = UIColor(r: 155, g: 155, b: 155)
        return label
    }()
    
    let decisionSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        return switcher
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    private func setupViews() {
        [experienceLabel, decisionSwitch].forEach {
            self.addSubview($0)
        }   
        
        experienceLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 169, height: 17))
        experienceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        decisionSwitch.anchor(top: nil, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 29), size: .init(width: 39, height: 24))
        decisionSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

