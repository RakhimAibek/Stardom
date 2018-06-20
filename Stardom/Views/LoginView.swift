//
//  LoginView.swift
//  Stardom
//
//  Created by Aibek Rakhim on 3/15/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.

import UIKit

class LoginView: UIView, UITextFieldDelegate {
    
    // button actions
    var loginAction: (() -> Void)?
    var signupAction: (() -> Void)?
    
    // properties
    private var moveDistance = 0
    private var stackView: UIStackView!
    
    //properties to hold iphone 5s frame, if it is
    var sizeHeight: CGFloat!
    var heightOfTextFields: CGFloat!
    var topAnchorFrame: CGFloat!
    
    //UI Views
    let backgroundImageView: UIImageView = {
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
    
    let containerView1: UIView = {
        let view1 = UIView()
        return view1
    }()
    
    let logoImageView: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "logo_stardom"))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let loginTextField: UITextField = {
        let tf = UITextField(placeHolder: "email или номер телефона", fontSize: 16)
        tf.tag = 0
        tf.returnKeyType = .next
        tf.autocapitalizationType = .none
        tf.adjustsFontForContentSizeCategory = true
        tf.addLeftImage(textField: tf, imageName: "leftMessageIcon", imageWidth: 26, imageHeight: 26)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField(placeHolder: "введите пароль", fontSize: 16)
        tf.tag = 1
        tf.isSecureTextEntry = true
        tf.adjustsFontForContentSizeCategory = true
        tf.returnKeyType = .done
        tf.addLeftImage(textField: tf, imageName: "leftBlockIcon", imageWidth: 26, imageHeight: 26)
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(title: "Войти", textSize: 20)
        if #available(iOS 11.0, *) {
            button.isSpringLoaded = true
        }
        button.addTarget(self, action: #selector(loginBTNpressed), for: .touchUpInside)
        return button
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль?", for: .normal)
        button.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 16)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Нет аккаунта? Зарегистрируйтесь", for: .normal)
        button.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 16)
        button.addTarget(self, action: #selector(signupBTNpressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        checkSizeOfFrame()
        setupConstraints()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow , object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func loginBTNpressed() {
        loginAction?()
    }
    
    @objc func signupBTNpressed() {
        signupAction?()
    }
    
    //setuping views
    private func setupViews() {
        self.setGradientLayer(to: loginButton)
        
        stackView = createStackViewVertical(views: [loginTextField, passwordTextField, loginButton], spacingNo: 15, distribution: .fillEqually)
        self.containerView1.addSubview(logoImageView)
        
        [backgroundImageView, overLayView, containerView1, stackView, forgotPasswordButton, registerButton].forEach {
            self.addSubview($0)
        }
    
    }
    
    private func checkSizeOfFrame() {
        if self.frame.width == 320 {
            sizeHeight = 160
            topAnchorFrame = 20
            heightOfTextFields = 160
        } else {
            sizeHeight = 200
            topAnchorFrame = 34
            heightOfTextFields = 180
        }
    }
    
    //adding constraints
    private func setupConstraints() {
        
        backgroundImageView.fillSuperView()
        overLayView.fillSuperView()
        containerView1.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, size: .init(width: self.frame.width, height: self.frame.height / 2))
        
        logoImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: containerView1.frame.width/1.6, height: containerView1.frame.height/4.6))
        logoImageView.centerXAnchor.constraint(equalTo: containerView1.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: containerView1.centerYAnchor, constant: -20).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50).isActive = true
        stackView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: self.frame.width/1.126, height: heightOfTextFields))
        
        forgotPasswordButton.anchor(top: stackView.bottomAnchor, leading: nil, bottom: nil, trailing: stackView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 123, height: 21))
        
        registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        registerButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 285, height: 16))
        registerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25).isActive = true
        
    }
}

extension LoginView {
    
    //MARK: UITextFieldDelegate methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(moveDistance: self.moveDistance, up: true)
        forgotPasswordButton.alpha = 0
        if self.frame.width == 320 {
            logoImageView.alpha = 0
        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(moveDistance: self.moveDistance, up: false)
        forgotPasswordButton.alpha = 1
        logoImageView.alpha = 1
    }
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        moveTextField(moveDistance: self.moveDistance, up: false)
        forgotPasswordButton.alpha = 1
        logoImageView.alpha = 1
    }
    
    //MARK: MoveTextField when keyboard appears
    func moveTextField(moveDistance: Int, up: Bool) {
        let moveDuration = 0.35
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        stackView.frame = stackView.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    //user can type only 25 symbols by format of typing Number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        loginTextField.layer.borderColor = UIColor.white.cgColor
//        passwordTextField.layer.borderColor = UIColor.white.cgColor
        let maxLength = 25
        let currentString: NSString = loginTextField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    //Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    //Hide keyboard when return pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight : Int = Int(keyboardSize.height)
            let viewHeight : Int = Int(frame.height)
            let btnPosition: Int = Int(stackView.frame.origin.y + loginButton.frame.origin.y + 52)
            if (moveDistance == 0) {
                moveDistance = (viewHeight - keyboardHeight) - btnPosition
                moveTextField(moveDistance: self.moveDistance, up: true)
            }
        }
    
    }
    
    
}
