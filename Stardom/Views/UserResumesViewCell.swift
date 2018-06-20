//
//  UserResumeViewCell.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/20/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class UserResumesViewCell: UICollectionViewCell {
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 155, g: 155, b: 155)
        view.alpha = 0.4
        return view
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = "Имя и Фамилия"
        label.textColor = UIColor(r: 3, g: 3, b: 3)
        label.textAlignment = .left
        label.font = UIFont(name: "ProximaNova-SemiBold", size: 16)
        return label
    }()
    
    let userAge: UILabel = {
        let label = UILabel()
        label.text = "возраст: 20"
        label.textColor = UIColor(r: 200, g: 200, b: 200)
        label.textAlignment = .left
        label.font = UIFont(name: "ProximaNova-SemiBold", size: 14)
        return label
    }()
    
    let userLocation: UILabel = {
        let label = UILabel()
        label.text = "г.Алматы"
        label.textColor = UIColor(r: 200, g: 200, b: 200)
        label.textAlignment = .left
        label.font = UIFont(name: "ProximaNova-SemiBold", size: 12)
        return label
    }()
    
    let detailedArrowButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "shape_arrow"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //for avoiding the reusing the each cell
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userImageView.image = UIImage(named: "no_userResumeImage")
        userName.text = ""
        userAge.text = ""
    }
    
    private func setupView() {
        [userImageView, separatorView, userName, userAge, userLocation, detailedArrowButton].forEach {
            self.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        userImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 60, height: 60))
        userImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        separatorView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        
        userName.anchor(top: separatorView.bottomAnchor, leading: userImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 8, bottom: 0, right: 50), size: .init(width: 0, height: 20))
        
        userAge.anchor(top: userName.bottomAnchor, leading: userImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 8, bottom: 0, right: 50), size: .init(width: 0, height: 17))
        userLocation.anchor(top: userAge.bottomAnchor, leading: userImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 2, left: 8, bottom: 0, right: 50), size: .init(width: 0, height: 15))
        
        detailedArrowButton.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 20, height: 20))
        detailedArrowButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}


