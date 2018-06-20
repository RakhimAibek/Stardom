//
//  FilterViewCell.swift
//  Stardom
//
//  Created by Aibek Rakhim on 4/28/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    let locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locationImageView")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let chooseCountryLabel: UILabel = {
        let label = UILabel()
        label.text = "выбрать расположение"
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        label.textColor = UIColor(r: 155, g: 155, b: 155)
        return label
    }()
    
    let openImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "open_indicator_icon")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupConst()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        [locationImage, chooseCountryLabel, openImage].forEach {
            self.addSubview($0)
        }
    }

    private func setupConst() {
        locationImage.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 17, height: 25))
        locationImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        chooseCountryLabel.anchor(top: nil, leading: locationImage.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 158, height: 17))
        chooseCountryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        openImage.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 8, height: 13))
        openImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

}
