//
//  RegistrationView.swift
//  Stardom
//
//  Created by Aibek Rakhim on 3/22/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.

import UIKit

class RegistrationView: UIView, UITextFieldDelegate {
    
    var buttonStackView: UIStackView!
    var lineStackView: UIStackView!
    var numberFieldsStackView: UIStackView!
    var keyboardHeight: CGFloat!
    var emailFieldsStackView: UIStackView!
    
    var currentView = "phone"
    
    private var moveDistance: CGFloat = 0
    
    let defaults = UserDefaults.standard
    
    //check frame of iphone 5s
    var sizeHeight: CGFloat!
    var isIphone5: Bool!
    var topAnchorFrame: CGFloat!
    var keyboardHeightX: CGFloat?
    
    //functions
    var showCountries: (() -> Void)?
    var doValidation: (() -> Void)?
    
    //ui views
    let backgroundImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "bg_loginView"))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let overLayView: UIView = {
        let overView = UIView()
        overView.backgroundColor = .black
        overView.alpha = 0.55
        return overView
    }()
    
    let phoneNumberButton: UIButton = {
        let button = UIButton(title: "Номер", textSize: 20)
//        button.addTarget(self, action: #selector(showPhoneOrEmailView(sender:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()
    
    let emailButton: UIButton = {
        let button = UIButton(title: "через email", textSize: 20)
        button.alpha = 0.37
//        button.addTarget(self, action: #selector(showPhoneOrEmailView(sender:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    let viewLine1: UIView = {
        let view1 = UIView()
        view1.backgroundColor = .red
        return view1
    }()
    
    let viewLine2: UIView = {
        let view2 = UIView()
        view2.backgroundColor = .white
        view2.alpha = 0.37
        return view2
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        return containerView
    }()
    
    let countriesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выберите страну", for: .normal)
        button.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 18)
        button.setTitleColor(UIColor(r: 29, g: 29, b: 38), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addBottomBorder(UIColor(r: 219, g: 219, b: 219), height: 1)
        button.addTarget(self, action: #selector(showCountriesBTNpressed), for: .touchUpInside)
        return button
    }()
    
    let numberTextField: UITextField = {
        let tf = UITextField(placeHolder: "ваш номер телефона", fontSize: 16)
        tf.borderStyle = .none
        tf.keyboardType = .numberPad
        tf.returnKeyType = .done
        tf.addBottomBorder(UIColor(r: 219, g: 219, b: 219), height: 1)
        tf.adjustsFontSizeToFitWidth = true
        tf.tag = 0
        return tf
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправим Вам 6-ти значный код через SMS для подтверждения номера"
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        label.textColor = UIColor(r: 147, g: 147, b: 147)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField(placeHolder: "введите email", fontSize: 16)
        tf.addLeftImage(textField: tf, imageName: "leftMessageIcon", imageWidth: 24, imageHeight: 24)
        tf.returnKeyType = .next
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.adjustsFontSizeToFitWidth = true
        tf.tag = 1
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField(placeHolder: "придумайте пароль", fontSize: 16)
        tf.addLeftImage(textField: tf, imageName: "leftBlockIcon", imageWidth: 24, imageHeight: 24)
        tf.returnKeyType = .next
        tf.isSecureTextEntry = true
        tf.adjustsFontSizeToFitWidth = true
        tf.autocapitalizationType = .none
        tf.tag = 2
        return tf
    }()
    
    let confirmPWDtextField: UITextField = {
        let tf = UITextField(placeHolder: "повторите пароль", fontSize: 16)
        tf.addLeftImage(textField: tf, imageName: "leftBlockIcon", imageWidth: 24, imageHeight: 24)
        tf.returnKeyType = .done
        tf.isSecureTextEntry = true
        tf.adjustsFontSizeToFitWidth = true
        tf.autocapitalizationType = .none
        tf.tag = 3
        return tf
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(title: "ДАЛЬШЕ", textSize: 20)
        button.layer.cornerRadius = 0
        button.addTarget(self, action: #selector(nextBTNpressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        checkSizeOfFrame()
        setupViews()
        setupConstraints()
        numberTextField.delegate = self
//        emailFieldsStackView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide , object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        emailTextField.becomeFirstResponder()
//        containerView.roundCorners([.topLeft, .bottomRight], radius: 20)
    }
    
    private func checkSizeOfFrame() {
        if self.frame.width == 320 {
            sizeHeight = 160
            topAnchorFrame = 20
            isIphone5 = true
        } else {
            sizeHeight = 200
            topAnchorFrame = 34
            isIphone5 = false
        }
        
        if frame.height == 812 {
            keyboardHeightX = -292
            self.defaults.set(keyboardHeightX, forKey: "iphoneX_keyboard")
        }
    }
    
//    @objc private func showPhoneOrEmailView(sender: UIButton) {
//
//        if sender.tag == 0 {
//            viewLine1.alpha = 1
//            viewLine2.alpha = 0.37
//            emailButton.alpha = 0.37
//            phoneNumberButton.alpha = 1
//            viewLine1.backgroundColor = .red
//            viewLine2.backgroundColor = .white
//            currentView = "phone"
//
//            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
//                self.containerView.isHidden = false
//                self.emailFieldsStackView.isHidden = true
//                self.numberTextField.becomeFirstResponder()
//                self.phoneNumberButton.isEnabled = false
//                self.emailButton.isEnabled = true
//            }, completion: nil)
//
//        } else if sender.tag == 1 {
//            viewLine1.backgroundColor = .white
//            viewLine2.backgroundColor = .red
//            phoneNumberButton.alpha = 0.37
//            viewLine1.alpha = 0.37
//            emailButton.alpha = 1
//            viewLine2.alpha = 1
//            currentView = "email"
//
//            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
//                self.containerView.isHidden = true
//                self.emailFieldsStackView.isHidden = false
//                self.emailTextField.becomeFirstResponder()
//                self.phoneNumberButton.isEnabled = true
//                self.emailButton.isEnabled = false
//            }, completion: nil)
//
//        }
//        sender.pulsate()
//    }
    
    //to present all list of countries
    @objc private func showCountriesBTNpressed() {
        showCountries?()
    }
    
    //next buttonPressed
    @objc private func nextBTNpressed() {
        doValidation?()
    }
    
    //user can type only 15 symbols by format of typing Number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = numberTextField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    //MARK: UITextFieldDelegate methods
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {

    }
    
    //MARK: NSNotifications
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            guard let keyboardHeight = keyboardHeight else { return }
        
            nextButton.setOnlyAnchorSize(size: .init(width: frame.width, height: isIphone5 ? 41 : 50))
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            nextButton.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: keyboardHeightX ?? (-keyboardHeight)).isActive = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
    }
    
    //setuping views
    private func setupViews() {
        containerView.isHidden = true
        self.setGradientLayer(to: nextButton)
        
//        buttonStackView = createStackViewHorizontal(views: [phoneNumberButton, emailButton], spacingNo: 29, distribution: .fillEqually)
//        lineStackView = createStackViewHorizontal(views: [viewLine1, viewLine2], spacingNo: 29, distribution: .fillEqually)
        numberFieldsStackView = createStackViewVertical(views: [countriesButton, numberTextField, infoLabel], spacingNo: 15, distribution: .fillEqually)
        emailFieldsStackView = createStackViewVertical(views: [emailTextField, passwordTextField, confirmPWDtextField], spacingNo: 15, distribution: .fillEqually)
        
        containerView.addSubview(numberFieldsStackView)
        
        [backgroundImage, overLayView, emailButton, viewLine2, containerView, nextButton, emailFieldsStackView].forEach {
            self.addSubview($0)
        }
    }
    
    //adding constraints
    private func setupConstraints() {
        
        backgroundImage.fillSuperView()
        overLayView.fillSuperView()
        
        if #available(iOS 11.0, *) {
            emailButton.safeTopAnchor.constraint(equalTo: self.safeTopAnchor, constant: 10).isActive = true
        } else {
            viewLine2.topAnchor.constraint(equalTo: self.topAnchor, constant: 70).isActive = true
        }
        
        emailButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        emailButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: self.frame.width/1.139, height: self.frame.height/26.68))
        
        viewLine2.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 3).isActive = true
        viewLine2.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        viewLine2.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: self.frame.width/1.139, height: 2))
        
        containerView.topAnchor.constraint(equalTo: viewLine2.bottomAnchor, constant: topAnchorFrame).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        containerView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: self.frame.width/1.1329, height: self.frame.height/3.2536))
        
        numberFieldsStackView.centerAnchor(to: self.containerView)
        numberFieldsStackView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: self.frame.width/1.2886, height: self.frame.height/5.2936))
    
        emailFieldsStackView.topAnchor.constraint(equalTo: viewLine2.bottomAnchor, constant: topAnchorFrame).isActive = true
        emailFieldsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        emailFieldsStackView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: self.frame.width/1.1329, height: sizeHeight))
    }
}
