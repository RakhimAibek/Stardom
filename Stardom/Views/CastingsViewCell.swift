//
//  CastingsViewCell.swift
//  Stardom
//
//  Created by Aibek Rakhim on 4/21/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class CastingsViewCell: UICollectionViewCell {
    
    // button actions
    var likedCast: (() -> Void)?
    
    private var stackView1: UIStackView!
    
    //declaration of UI views
    let castImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loading_picture")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.45)
        return view
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 155, g: 155, b: 155)
        return view
    }()
    
    let titleCastLabel: UILabel = {
        let label = UILabel()
        label.text = "Заголовок кастинга, который нужен для кастинга балапан от казахфильма"
        label.font = UIFont(name: "ProximaNova-Bold", size: 18)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
//    let favoriteButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "favoriteButton"), for: .normal)
//        button.setImage(UIImage(named: "favoriteButtonActive"), for: .selected)
//        button.addTarget(self, action: #selector(likedBTNpressed(sender:)), for: .touchUpInside)
//        button.tag = 0
//        return button
//    }()
    
    let cityAndDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Алматы | до 30.04."
        label.textColor = .white
        label.font = UIFont(name: "ProximaNova-Regular", size: 16)
        return label
    }()
    
    let companyName: UILabel = {
        let label = UILabel()
        label.text = "ищет Rare Models"
        label.textColor = .white
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return label
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
        self.titleCastLabel.text = ""
        self.cityAndDataLabel.text = ""
        self.companyName.text = ""
        self.castImageView.image = UIImage(named: "loading_picture")
    }
    
    private func setupView() {
        self.backgroundColor = .blue
        
        stackView1 = createStackViewVertical(views: [cityAndDataLabel, companyName], spacingNo: 4, distribution: .fillEqually)
        [castImageView, overlayView, separatorView, titleCastLabel, stackView1].forEach {
            self.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        castImageView.fillSuperView()
        overlayView.fillSuperView()
        
        titleCastLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0), size: .init(width: self.frame.width/1.5625, height: 48))

//        favoriteButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16), size: .init(width: 20, height: 19))
        
        stackView1.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 8, right: 0), size: .init(width: self.frame.width/1.5625, height: 41))
    }
    
    //MARK: ibactions
    @objc private func likedBTNpressed(sender: UIButton) {
        likedCast?()
    }

    
}
