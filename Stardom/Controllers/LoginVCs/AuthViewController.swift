//
//  AuthViewController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 4/5/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    var stackView: UIStackView!
    var keyboardHeight: CGFloat!
    var keyboardHeightX: CGFloat?
    
    let defaults = UserDefaults.standard
    
    //MARK: - UI elements
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bg_loginView"))
        imageView.contentMode = .scaleAspectFill
        return imageView
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
    
    let codeTextField: UITextField = {
        let tf = UITextField(placeHolder: "Введите код", fontSize: 20)
        tf.addBottomBorder(UIColor.white, height: 2)
        tf.textAlignment = .center
        tf.backgroundColor = UIColor.clear
        tf.textColor = .white
        tf.keyboardType = .phonePad
        var placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Введите код", attributes: [NSAttributedStringKey.font: UIFont(name: "ProximaNova-Semibold", size: 20)!, .foregroundColor: UIColor.white]))
        tf.attributedPlaceholder = placeholder
        return tf
    }()
    
    let phoneLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .white
        l.numberOfLines = 2
        l.adjustsFontSizeToFitWidth = true
        var mutableString = NSMutableAttributedString(string: "Напишите код, который был отправлен на ", attributes: [NSAttributedStringKey.font: UIFont(name: "ProximaNova-Semibold", size: 16)!])
        var numberString = NSMutableAttributedString(string: "+7 701 035 40 40", attributes: [NSAttributedStringKey.font: UIFont(name: "ProximaNova-Bold", size: 16)!])
        mutableString.append(numberString)
        l.attributedText = mutableString
        return l
    }()
    
    let verifyButton: UIButton = {
        let b = UIButton(title: "ПОДТВЕРДИТЬ", textSize: 20)
        b.addTarget(self, action: #selector(verifyBTNpressed(sender:)), for: .touchUpInside)
        return b
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        codeTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow , object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavBarChild(selectorLeft: #selector(backBTNpressed), title: "Подтверждение кода")
    }
    
    //MARK: - Methods
    private func setupViews() {
        if view.frame.height == 812 {
            keyboardHeightX = -292
        }
        
        self.view.setGradientLayer(to: verifyButton)
        
        stackView = view.createStackViewVertical(views: [codeTextField, phoneLabel], spacingNo: 15, distribution: .fillEqually)
        containerView1.addSubview(stackView)
        
        [backgroundImageView, overLayView, containerView1, verifyButton].forEach {
            self.view.addSubview($0)
        }
        
    }
    
    private func setupConstraints() {
        backgroundImageView.fillSuperView()
        overLayView.fillSuperView()
        
        containerView1.anchor(top: self.view.safeTopAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, size: .init(width: self.view.frame.width, height: self.view.frame.height / 2))
        
        stackView.centerAnchor(to: containerView1)
        stackView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: self.view.frame.width / 1.3992, height: containerView1.frame.height / 4.0180))
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = (defaults.object(forKey: "iphoneX_keyboard") as? CGFloat) ?? (-keyboardSize.height)
            verifyButton.setOnlyAnchorSize(size: .init(width: view.frame.width, height: 50))
            verifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            verifyButton.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: keyboardHeight).isActive = true
        }
    }
    
    //user can type only 6 symbols for verification code
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 6
        let currentString: NSString = codeTextField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
    }
    
    /// IBActions
    @objc private func backBTNpressed() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc private func verifyBTNpressed(sender: UIButton) {
        self.present(MainTabController(), animated: true, completion: nil)
    }

}
