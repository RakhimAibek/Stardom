//
//  DetailedCastView.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/1/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class DetailedCastView: UIView {
    
    var additionStackView: UIStackView!
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.backgroundColor = .white
        return sv
    }()
    
    let mainContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        return v
    }()
    
    let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addTopBorderWithColor(color: UIColor(r: 247, g: 247, b: 247), width: 1)
        return view
    }()
    
    var applyAction: (() -> Void)?
    
    let applyButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor(r: 185, g: 13, b: 13)
        button.setTitle("Подать заявку", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(applyBTNpressed), for: .touchUpInside)
        return button
    }()
    
    let deadlineLabel: UILabel = {
        let label = UILabel()
        label.text = "осталось: 3 дня"
        label.font = UIFont(name: "ProximaNova-Bold", size: 14)
        label.textColor = UIColor(r: 146, g: 146, b: 146)
        return label
    }()
    
    let castImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "firstCastImage")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let castingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Кастинг для программы Балапан для показа детской одежды"
        label.textColor = UIColor(r: 50, g: 50, b: 50)
        label.font = UIFont(name: "ProximaNova-Bold", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let locationContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "location_icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let locationAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Алматы"
        label.textColor = UIColor(r: 175, g: 175, b: 175)
        label.font = UIFont(name: "ProximaNova-Bold", size: 13)
        label.textAlignment = .left
        return label
    }()
    
    let moneyContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let moneyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "money_icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let moneyLabel: UILabel = {
        let label = UILabel()
        label.text = "от 50 000 тенге"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(r: 175, g: 175, b: 175)
        label.font = UIFont(name: "ProximaNova-Bold", size: 13)
        label.textAlignment = .left
        return label
    }()
    
    let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "ОПИСАНИЕ"
        label.textColor = UIColor(r: 50, g: 50, b: 50)
        label.font = UIFont(name: "ProximaNova-Bold", size: 18)
        return label
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Нам нужны обаятельные дети для промо видео ролика в программе “Балапан”. Оставьте свое резюме подав заявку. Понравившиеся заявки из других городов, мы пригласим в г.Кызылорда. Расходы на проезд оплачиваются."
        textView.font = UIFont(name: "ProximaNova-Regular", size: 14)
        textView.textContainerInset = UIEdgeInsetsMake(16, 16, 16, 16)
        textView.textAlignment = .left
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.textColor = UIColor(r: 51, g: 51, b: 51)
        return textView
    }()
    
    let requirementsTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "ТРЕБОВАНИЕ"
        label.textColor = UIColor(r: 50, g: 50, b: 50)
        label.font = UIFont(name: "ProximaNova-Bold", size: 18)
        return label
    }()
    
    let requirementsBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let genderAndAgeView: UIView = {
        let view = UIView()
        return view
    }()
    
    let genderAndAgeLabel: UILabel = {
        let label = UILabel()
        label.text = "Пол и возраст:"
        label.textColor = UIColor(r: 50, g: 50, b: 50)
        label.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return label
    }()
    
    let dotImageView1: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "dot_icon")
        return iv
    }()
    
    let maleInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Мужской от 6 до 15"
        label.textColor = UIColor(r: 51, g: 51, b: 51)
        label.textAlignment = .left
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return label
    }()
    
    let dotImageView2: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "dot_icon")
        return iv
    }()
    
    let femaleInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Женский от 10 до 18"
        label.textColor = UIColor(r: 51, g: 51, b: 51)
        label.textAlignment = .left
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return label
    }()
    
    let nationalityLabel: UILabel = {
        let label = UILabel()
        label.text = "Национальность:"
        label.textColor = UIColor(r: 50, g: 50, b: 50)
        label.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return label
    }()
    
    let nationalityView: UIView = {
        let view = UIView()
        return view
    }()
    
    let dotImageView3: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "dot_icon")
        return iv
    }()
    
    let nationalityInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Казах, русский"
        label.textColor = UIColor(r: 51, g: 51, b: 51)
        label.textAlignment = .left
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return label
    }()
    
    let experienceView: UIView = {
        let view = UIView()
        return view
    }()
    
    let experienceLabel: UILabel = {
        let label = UILabel()
        label.text = "Опыт:"
        label.textColor = UIColor(r: 50, g: 50, b: 50)
        label.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return label
    }()

    let dotImageView4: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "dot_icon")
        return iv
    }()
    
    let experienceInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "от 2-х лет"
        label.textColor = UIColor(r: 51, g: 51, b: 51)
        label.textAlignment = .left
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return label
    }()
    
    let bodyHeightView: UIView = {
        let view = UIView()
        return view
    }()
    
    let bodyHeightLabel: UILabel = {
        let label = UILabel()
        label.text = "Рост:"
        label.textColor = UIColor(r: 50, g: 50, b: 50)
        label.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return label
    }()
    
    let dotImageView5: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "dot_icon")
        return iv
    }()
    
    let bodyHeightInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "от 180 до 190 см"
        label.textColor = UIColor(r: 51, g: 51, b: 51)
        label.textAlignment = .left
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        scrollView.contentSize = CGSize(width: self.frame.width, height: 0)
        scrollView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 40, right: 0)
        
        locationContainerView.addSubview(locationImageView)
        locationContainerView.addSubview(locationAddressLabel)
        
        moneyContainerView.addSubview(moneyImageView)
        moneyContainerView.addSubview(moneyLabel)
        
        additionStackView = createStackViewHorizontal(views: [locationContainerView, moneyContainerView], spacingNo: 5, distribution: .fillEqually)
        
        footerView.addSubview(applyButton)
        footerView.addSubview(deadlineLabel)
        
        [mainContainerView].forEach {
            self.scrollView.addSubview($0)
        }
        
        genderAndAgeView.addSubview(genderAndAgeLabel)
        genderAndAgeView.addSubview(dotImageView1)
        genderAndAgeView.addSubview(maleInfoLabel)
        genderAndAgeView.addSubview(dotImageView2)
        genderAndAgeView.addSubview(femaleInfoLabel)
        
        nationalityView.addSubview(nationalityLabel)
        nationalityView.addSubview(dotImageView3)
        nationalityView.addSubview(nationalityInfoLabel)
        
        experienceView.addSubview(experienceLabel)
        experienceView.addSubview(dotImageView4)
        experienceView.addSubview(experienceInfoLabel)
        experienceView.addSubview(bodyHeightLabel)
        
        bodyHeightView.addSubview(bodyHeightLabel)
        bodyHeightView.addSubview(dotImageView5)
        bodyHeightView.addSubview(bodyHeightInfoLabel)
        
        [castImageView, castingTitleLabel, additionStackView, descriptionTitleLabel, descriptionTextView, requirementsTitleLabel, requirementsBackgroundView, genderAndAgeView, nationalityView, experienceView, bodyHeightView, footerView].forEach {
            self.mainContainerView.addSubview($0)
        }
        
        [scrollView].forEach {
            self.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        
        scrollView.anchor(top: safeTopAnchor, leading: leadingAnchor, bottom: safeBottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive =  true
        
        mainContainerView.fillSuperView()
        mainContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        castImageView.anchor(top: mainContainerView.safeTopAnchor, leading: mainContainerView.leadingAnchor, bottom: nil, trailing: mainContainerView.trailingAnchor, padding: .init(top: -45, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 232))
        
        castingTitleLabel.anchor(top: castImageView.bottomAnchor, leading: mainContainerView.leadingAnchor, bottom: nil, trailing: mainContainerView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        
        additionStackView.anchor(top: castingTitleLabel.bottomAnchor, leading: mainContainerView.leadingAnchor, bottom: nil, trailing: mainContainerView.trailingAnchor, padding: .init(top: 8, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 20))
        
        locationImageView.anchor(top: locationContainerView.topAnchor, leading: locationContainerView.leadingAnchor, bottom:nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 20, height: 20))
        
        locationAddressLabel.anchor(top: locationContainerView.topAnchor, leading: locationImageView.trailingAnchor, bottom: locationContainerView.bottomAnchor, trailing: locationContainerView.trailingAnchor, padding: .init(top: 0, left: 2, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        moneyImageView.anchor(top: moneyContainerView.topAnchor, leading: moneyContainerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 20, height: 20))
        
        moneyLabel.anchor(top: moneyContainerView.topAnchor, leading: moneyImageView.trailingAnchor, bottom: moneyContainerView.bottomAnchor, trailing: moneyContainerView.trailingAnchor, padding: .init(top: 0, left: 2, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        descriptionTitleLabel.anchor(top: locationContainerView.bottomAnchor, leading: mainContainerView.leadingAnchor, bottom: nil, trailing: mainContainerView.trailingAnchor, padding: .init(top: 22, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 18))
        
        descriptionTextView.anchor(top: descriptionTitleLabel.bottomAnchor, leading: mainContainerView.leadingAnchor, bottom: nil, trailing: mainContainerView.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        requirementsTitleLabel.anchor(top: descriptionTextView.bottomAnchor, leading: mainContainerView.leadingAnchor, bottom: nil, trailing: mainContainerView.trailingAnchor, padding: .init(top: 22, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 18))
        
        requirementsBackgroundView.anchor(top: requirementsTitleLabel.bottomAnchor, leading: mainContainerView.leadingAnchor, bottom: nil, trailing: mainContainerView.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 30, right: 0), size: .init(width: 0, height: 0))
        
        genderAndAgeView.anchor(top: requirementsBackgroundView.topAnchor, leading: requirementsBackgroundView.leadingAnchor, bottom: nil, trailing: requirementsBackgroundView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 73))
        
        genderAndAgeLabel.anchor(top: genderAndAgeView.topAnchor, leading: genderAndAgeView.leadingAnchor, bottom: nil, trailing: genderAndAgeView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 24))
        
        dotImageView1.anchor(top: genderAndAgeLabel.bottomAnchor, leading: genderAndAgeView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 24, height: 24))
        
        maleInfoLabel.anchor(top: genderAndAgeLabel.bottomAnchor, leading: dotImageView1.trailingAnchor, bottom: nil, trailing: genderAndAgeView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 0, height: 24))
        
        dotImageView2.anchor(top: dotImageView1.bottomAnchor, leading: genderAndAgeView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 24, height: 24))
        
        femaleInfoLabel.anchor(top: maleInfoLabel.bottomAnchor, leading: dotImageView2.trailingAnchor, bottom: nil, trailing: genderAndAgeView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 0, height: 24))
        
        nationalityView.anchor(top: genderAndAgeView.bottomAnchor, leading: requirementsBackgroundView.leadingAnchor, bottom: nil, trailing: requirementsBackgroundView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 48))
        
        nationalityLabel.anchor(top: nationalityView.topAnchor, leading: nationalityView.leadingAnchor, bottom: nil, trailing: nationalityView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 24))
        
        dotImageView3.anchor(top: nationalityLabel.bottomAnchor, leading: nationalityView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 24, height: 24))
        
        nationalityInfoLabel.anchor(top: nationalityLabel.bottomAnchor, leading: dotImageView3.trailingAnchor, bottom: nil, trailing: nationalityView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 0, height: 24))
        
        experienceView.anchor(top: nationalityView.bottomAnchor, leading: requirementsBackgroundView.leadingAnchor, bottom: nil, trailing: requirementsBackgroundView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 48))
        
        experienceLabel.anchor(top: experienceView.topAnchor, leading: experienceView.leadingAnchor, bottom: nil, trailing: experienceLabel.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 24))
        
        dotImageView4.anchor(top: experienceLabel.bottomAnchor, leading: experienceView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 24, height: 24))
        
        experienceInfoLabel.anchor(top: experienceLabel.bottomAnchor, leading: dotImageView4.trailingAnchor, bottom: nil, trailing: experienceView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 0, height: 24))
        
        bodyHeightView.anchor(top: experienceView.bottomAnchor, leading: requirementsBackgroundView.leadingAnchor, bottom: nil, trailing: requirementsBackgroundView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 48))
        
        bodyHeightLabel.anchor(top: bodyHeightView.topAnchor, leading: bodyHeightView.leadingAnchor, bottom: nil, trailing: bodyHeightView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 24))
        
        dotImageView5.anchor(top: bodyHeightLabel.bottomAnchor, leading: bodyHeightView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 24, height: 24))
        
        bodyHeightInfoLabel.anchor(top: bodyHeightLabel.bottomAnchor, leading: dotImageView5.trailingAnchor, bottom: requirementsBackgroundView.bottomAnchor, trailing: bodyHeightView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 0, height: 24))
        
        
        footerView.anchor(top: requirementsBackgroundView.bottomAnchor, leading: mainContainerView.leadingAnchor, bottom: mainContainerView.bottomAnchor, trailing: mainContainerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 50))
        
        applyButton.anchor(top: nil, leading: nil, bottom: nil, trailing: footerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 131, height: 35))
        applyButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        deadlineLabel.anchor(top: nil, leading: footerView.leadingAnchor, bottom: nil, trailing: applyButton.leadingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 10), size: .init(width: 0, height: 17))
        deadlineLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
    }
    
    //MARK: -ibactions
    @objc private func applyBTNpressed() {
        applyAction?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
