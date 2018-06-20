//
//  ResumeView.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/17/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class ResumeView: UIView {
    
    private var nameDataStackView: UIStackView!
    private var heightAndWeightStack: UIStackView!
    private var experienceStack: UIStackView!
    private var additionInfoStackView: UIStackView!
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.backgroundColor = .white
        return sv
    }()
    
    let containerView: UIView = {
        let v = UIView()
        return v
    }()
    
    let titleCVLabel: UILabel = {
        let label = UILabel()
        label.text = "Создание резюме за несколько минут..."
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(r: 50, g: 50, b: 50)
        label.textAlignment = .left
        label.font = UIFont(name: "ProximaNova-Bold", size: 16)
        return label
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "add_profileImage_icon")
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Имя"
        tf.keyboardType = .default
        tf.autocapitalizationType = .words
        tf.layer.borderColor = UIColor(r: 228, g: 228, b: 228).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        tf.font = UIFont(name: "ProximaNova-Bold", size: 14)
        tf.textAlignment = .center
        tf.adjustsFontSizeToFitWidth = true
        tf.textColor = UIColor(r: 175, g: 175, b: 175)
        return tf
    }()
    
    let surnameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Фамилия"
        tf.autocapitalizationType = .words
        tf.adjustsFontSizeToFitWidth = true
        tf.font = UIFont(name: "ProximaNova-Bold", size: 14)
        tf.textAlignment = .center
        tf.textColor = UIColor(r: 175, g: 175, b: 175)
        tf.layer.borderColor = UIColor(r: 228, g: 228, b: 228).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let birthdayTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Возраст"
        tf.keyboardType = .numberPad
        tf.autocapitalizationType = .words
        tf.font = UIFont(name: "ProximaNova-Bold", size: 14)
        tf.textAlignment = .center
        tf.textColor = UIColor(r: 175, g: 175, b: 175)
        tf.layer.borderColor = UIColor(r: 228, g: 228, b: 228).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let genderSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Женский", "Мужской"])
        sc.selectedSegmentIndex = 0
        sc.tintColor = UIColor(r: 206, g: 36, b: 42)
        sc.addTarget(self, action: #selector(genderSelected(sender:)), for: .valueChanged)
        return sc
    }()
    
    let userHeightTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Рост (кг)"
        tf.keyboardType = .numberPad
        tf.font = UIFont(name: "ProximaNova-Bold", size: 14)
        tf.textAlignment = .center
        tf.textColor = UIColor(r: 175, g: 175, b: 175)
        tf.layer.borderColor = UIColor(r: 228, g: 228, b: 228).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let userWeightTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Вес (кг)"
        tf.keyboardType = .numberPad
        tf.font = UIFont(name: "ProximaNova-Bold", size: 14)
        tf.textAlignment = .center
        tf.textColor = UIColor(r: 175, g: 175, b: 175)
        tf.layer.borderColor = UIColor(r: 228, g: 228, b: 228).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let nationalityTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Национальность"
        tf.font = UIFont(name: "ProximaNova-Bold", size: 14)
        tf.adjustsFontSizeToFitWidth = true
        tf.textAlignment = .center
        tf.textColor = UIColor(r: 175, g: 175, b: 175)
        tf.layer.borderColor = UIColor(r: 228, g: 228, b: 228).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let experienceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Опыт работы от"
        tf.font = UIFont(name: "ProximaNova-Bold", size: 14)
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.textColor = UIColor(r: 175, g: 175, b: 175)
        tf.layer.borderColor = UIColor(r: 228, g: 228, b: 228).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let tripView: UIView = {
        let v = UIView()
        return v
    }()
    
    let tripTextField: UITextField = {
        let tf = UITextField()
        tf.text = "Готовность к командировкам"
        tf.font = UIFont(name: "ProximaNova-Bold", size: 14)
        tf.textAlignment = .center
        tf.isUserInteractionEnabled = false
        tf.textColor = UIColor(r: 175, g: 175, b: 175)
        tf.layer.borderColor = UIColor(r: 228, g: 228, b: 228).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let tripSwitcher: UISwitch = {
        let switcher = UISwitch()
        return switcher
    }()
    
    let movingView: UIView = {
        let v = UIView()
        return v
    }()
    
    let movingTextField: UITextField = {
        let tf = UITextField()
        tf.text = "Готовность к переезду"
        tf.font = UIFont(name: "ProximaNova-Bold", size: 14)
        tf.textAlignment = .center
        tf.isUserInteractionEnabled = false
        tf.textColor = UIColor(r: 175, g: 175, b: 175)
        tf.layer.borderColor = UIColor(r: 228, g: 228, b: 228).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let movingSwitcher: UISwitch = {
        let switcher = UISwitch()
        return switcher
    }()
    
    let userPhoneNumberField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Номер телефона"
        tf.font = UIFont(name: "ProximaNova-Bold", size: 14)
        tf.textAlignment = .center
        tf.textColor = UIColor(r: 175, g: 175, b: 175)
        tf.layer.borderColor = UIColor(r: 228, g: 228, b: 228).cgColor
        tf.layer.cornerRadius = 8
        tf.keyboardType = .numberPad
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let userEmailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Электронная почта"
        tf.font = UIFont(name: "ProximaNova-Bold", size: 14)
        tf.textAlignment = .center
        tf.keyboardType = .emailAddress
        tf.textColor = UIColor(r: 175, g: 175, b: 175)
        tf.layer.borderColor = UIColor(r: 228, g: 228, b: 228).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Опишите себя, свой статус (не более 300 символов)"
        textView.font = UIFont(name: "ProximaNova-Bold", size: 14)
        textView.textContainerInset = UIEdgeInsetsMake(16, 16, 16, 16)
        textView.textAlignment = .left
        textView.isScrollEnabled = false
        textView.textColor = UIColor(r: 175, g: 175, b: 175)
        textView.layer.borderColor = UIColor(r: 228, g: 228, b: 228).cgColor
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        return textView
    }()
    
    var saveAction: (() -> Void)?
    
    let saveButton: UIButton = {
        let button = UIButton(title: "Сохранить резюме", textSize: 18)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupViews()
        setupConstraints()
    }
    
    //adding UIs to view
    private func setupViews() {
        
        self.setGradientLayer(to: saveButton)
        scrollView.contentSize = CGSize(width: self.frame.width, height: 0)
        
        nameDataStackView = createStackViewVertical(views: [nameTextField, surnameTextField, birthdayTextField, genderSegmentedControl], spacingNo: 4, distribution: .fillEqually)
        
        heightAndWeightStack = createStackViewHorizontal(views: [userHeightTextField, userWeightTextField], spacingNo: 12, distribution: .fillEqually)
        
        experienceStack = createStackViewHorizontal(views: [nationalityTextField, experienceTextField], spacingNo: 12, distribution: .fillEqually)
        
        tripView.addSubview(tripTextField)
        tripView.addSubview(tripSwitcher)
        movingView.addSubview(movingTextField)
        movingView.addSubview(movingSwitcher)
        
        additionInfoStackView = createStackViewVertical(views: [heightAndWeightStack, experienceStack, tripView, movingView, userPhoneNumberField, userEmailTextField], spacingNo: 6, distribution: .fillEqually)
        
        [titleCVLabel, profileImageView, nameDataStackView, additionInfoStackView, descriptionTextView, saveButton].forEach {
            self.containerView.addSubview($0)
        }
        
        self.scrollView.addSubview(containerView)
        self.addSubview(scrollView)
    }
    
    //setuping constraints for each UIs
    private func setupConstraints() {
        scrollView.fillSuperView()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        
        containerView.fillSuperView()
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        titleCVLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 20))
        
        profileImageView.anchor(top: titleCVLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 13, left: 16, bottom: 0, right: 0), size: .init(width: 121, height: 121))
        
        nameDataStackView.anchor(top: nil, leading: profileImageView.trailingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 16), size: .init(width: 0, height: 132))
        nameDataStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        
        tripTextField.anchor(top: tripView.topAnchor, leading: tripView.leadingAnchor, bottom: tripView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: tripView.frame.width/1.3243, height: tripView.frame.height))
        tripSwitcher.anchor(top: nil, leading: tripTextField.trailingAnchor, bottom: nil, trailing: tripView.trailingAnchor, padding: .init(top: 0, left: 34, bottom: 0, right: 0), size: .init(width: 50, height: 30))
        tripSwitcher.centerYAnchor.constraint(equalTo: self.tripView.centerYAnchor).isActive = true
        
        movingTextField.anchor(top: movingView.topAnchor, leading: movingView.leadingAnchor, bottom: movingView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: movingView.frame.width/1.3243, height: movingView.frame.height))
        movingSwitcher.anchor(top: nil, leading: movingTextField.trailingAnchor, bottom: nil, trailing: movingView.trailingAnchor, padding: .init(top: 0, left: 34, bottom: 0, right: 0), size: .init(width: 50, height: 30))
        movingSwitcher.centerYAnchor.constraint(equalTo: self.movingView.centerYAnchor).isActive = true
        
        additionInfoStackView.anchor(top: nameDataStackView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 230))
        
        descriptionTextView.anchor(top: additionInfoStackView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 6, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 132))
        
        saveButton.anchor(top: descriptionTextView.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 45))
    }
    
    @objc private func genderSelected(sender: UISegmentedControl) {
        
    }
    
    @objc private func saveButtonPressed() {
        saveAction?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
