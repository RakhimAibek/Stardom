//
//  RegistrationViewController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 3/22/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.

import UIKit
import CountryPickerView
import Firebase
import SVProgressHUD

class RegistrationViewController: UIViewController, CountryPickerViewDelegate, CountryPickerViewDataSource, UITextFieldDelegate {

    private var registrationView: RegistrationView!
    
    let countryPickerView: CountryPickerView = {
        let cpv = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        cpv.showCountryCodeInView = false
        cpv.isUserInteractionEnabled = false
        return cpv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        self.setupNavBarChild(selectorLeft: #selector(backButtonPressed), title: "Регистрация")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registrationView.numberTextField.becomeFirstResponder()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {

    }
    
    private func setupViews() {
        let mainView  = RegistrationView(frame: view.frame)
        self.registrationView = mainView
        self.registrationView.showCountries = showCountriesPressed
        self.registrationView.doValidation = validationUser
        self.registrationView.numberTextField.leftView = countryPickerView
        self.registrationView.numberTextField.leftViewMode = .always
        
        [self.registrationView.emailTextField, self.registrationView.passwordTextField, self.registrationView.confirmPWDtextField].forEach { (textField) in
            textField.delegate = self
        }
        self.registrationView.countriesButton.setTitle(countryPickerView.selectedCountry.name, for: .normal)
        //add to view
        self.view.addSubview(registrationView)
    }
    
    private func setupConstraints() {
        //set constraints
        registrationView.fillSuperView()
    }
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.registrationView.countriesButton.setTitle(country.name, for: .normal)
    }
    
    @objc private func backButtonPressed() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    private func showCountriesPressed() {
        registrationView.numberTextField.resignFirstResponder()
        countryPickerView.showCountriesList(from: self)
        UIApplication.shared.statusBarStyle = .default
    }
    
    private func validationUser() {
        registerWithEmail()
//        if registrationView.currentView == "phone" {
//            registerWithPhone()
//        } else if registrationView.currentView == "email" {
//            registerWithEmail()
//        }
        
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Выберите страну"
    }
    
    func closeButtonNavigationItem(in countryPickerView: CountryPickerView) -> UIBarButtonItem? {
        return UIBarButtonItem(image: UIImage(named: "leftWhiteBackBarBTN")?.withRenderingMode(.automatic), style: .plain, target: self, action: #selector(closeListCountriesBTNpressed))
    }
    
    //close btn pressed / countries list of showing is ending
    @objc private func closeListCountriesBTNpressed() {
//        registrationView.numberTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == registrationView.emailTextField { // Switch focus to other text field
            registrationView.passwordTextField.becomeFirstResponder()
        } else if textField == registrationView.passwordTextField {
            registrationView.confirmPWDtextField.becomeFirstResponder()
        } else {
            registrationView.confirmPWDtextField.becomeFirstResponder()
        }
        return true
    }
    
    private func registerWithEmail() {
        guard let email = registrationView.emailTextField.text, let password = registrationView.passwordTextField.text, let confirm = registrationView.confirmPWDtextField.text else { return }
        if (email.isEmpty || password.isEmpty || confirm.isEmpty || email.count < 6 || password.count < 6 || confirm.count < 6 || password != confirm) {
            registrationView.emailTextField.layer.borderColor = (email.count < 6) ? UIColor.red.cgColor : UIColor.white.cgColor
            registrationView.passwordTextField.layer.borderColor = (password.count < 6) ? UIColor.red.cgColor : UIColor.white.cgColor
            registrationView.confirmPWDtextField.layer.borderColor = (confirm.count < 6) ? UIColor.red.cgColor : UIColor.white.cgColor
            registrationView.confirmPWDtextField.layer.borderColor = (confirm != password) ? UIColor.red.cgColor : UIColor.white.cgColor
        } else {
            SVProgressHUD.show(withStatus: "Loading")
            Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] (user, err) in
                if let error = err {
                    print(error.localizedDescription)
                    let alert = UIAlertController(title: "Ошибка", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    SVProgressHUD.dismiss()
                    self?.present(alert, animated: true, completion: nil)
                } else {
                    guard let userID = user?.uid else { return }
                    let userData = ["userName": "",
                                    "userSurname": "",
                                    "userAge": "",
                                    "userHeight": "",
                                    "userWeight": "",
                                    "userNationality": "",
                                    "userExperience": "",
                                    "phoneNumber": "",
                                    "userEmail": email,
                                    "userDesc": "",
                                    "imgUrl": "",
                                    "role": "user"]
                    
                    Database.database().reference().child("Users").child(userID).setValue(userData, withCompletionBlock: { (err, reference) in
                        if let error = err {
                            print(error.localizedDescription)
                            let alert = UIAlertController(title: "Ошибка", message: "\(error.localizedDescription)", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(ok)
                            SVProgressHUD.dismiss()
                            self?.present(alert, animated: true, completion: nil)
                        } else {
                            let alert = UIAlertController(title: "Поздравляем!", message: "Вы успешно зарегистрированы", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                self?.navigationController?.popToRootViewController(animated: true)
                            })
                            alert.addAction(ok)
                            SVProgressHUD.dismiss()
                            self?.present(alert, animated: true, completion: nil)
                        }
                    })
                }
            })
        }
    }
    
//    private func registerWithPhone() {
//        guard let phone = registrationView.numberTextField.text else { return }
//        if phone.isEmpty {
//            registrationView.numberTextField.layer.borderColor = UIColor.red.cgColor
//        } else {
//            let userNumber = countryPickerView.selectedCountry.phoneCode + registrationView.numberTextField.text!
//            let alert = UIAlertController(title: "Проверьте свои номер в правильности", message: "Это Ваш номер телефона \(userNumber)?", preferredStyle: .alert)
//            let action = UIAlertAction(title: "Да", style: .default, handler: { [weak self] (UIAlertAction) in
//                SVProgressHUD.show(withStatus: "Авторизация...")
//                //PhoneVerification
//                PhoneAuthProvider.provider().verifyPhoneNumber("\(userNumber)", completion: { (verificationCode, error) in
//                    if error != nil {
//                        print(error.debugDescription, "debug error desc")
//                        SVProgressHUD.showError(withStatus: "Ошибка.. Попробуйте еще")
//                        SVProgressHUD.dismiss(withDelay: 1.5)
//                        print("Verification error \(String(describing: error?.localizedDescription))")
//
//                    } else {
//                        //MARK: UserDefaults
//                        let defaults = UserDefaults.standard
//                        defaults.set(verificationCode!, forKey: "verificationId")
//                        print(verificationCode!, "verification code")
//                        SVProgressHUD.dismiss(completion: {
//                            SVProgressHUD.showSuccess(withStatus: "Код успешно отправлен")
//                            SVProgressHUD.dismiss(withDelay: 1.5)
//                            let authVC = AuthViewController()
//                            self?.present(authVC, animated: true, completion: nil)
//                        })
//                    }
//                })
//            })
//
//            let cancel = UIAlertAction(title: "Нет", style: .destructive, handler: nil)
//
//            alert.addAction(action)
//            alert.addAction(cancel)
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
}
