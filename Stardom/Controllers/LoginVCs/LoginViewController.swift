//
//  ViewController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 3/14/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class LoginViewController: UIViewController {

    private var loginView: LoginView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.isHidden = true
        loginView.loginTextField.layer.borderColor = UIColor.white.cgColor
        loginView.passwordTextField.layer.borderColor = UIColor.white.cgColor
    }

    //MARK: setuping views
    private func setupViews() {
        let mainView  = LoginView(frame: view.frame)
        self.loginView = mainView
        self.loginView.loginAction = loginPressed
        self.loginView.signupAction = signupPressed
        //add to view
        self.view.addSubview(loginView)
    }
    
    private func setupConstraints() {
        //set constraints
        loginView.fillSuperView()
    }
    
    private func loginPressed() {
        guard let email = loginView.loginTextField.text, let password = loginView.passwordTextField.text else { return }
        if (email.isEmpty || password.isEmpty || email.count < 6 || password.count < 6) {
            loginView.loginTextField.layer.borderColor = (email.count < 6) ? UIColor.red.cgColor : UIColor.white.cgColor
            loginView.passwordTextField.layer.borderColor = (password.count < 6) ? UIColor.red.cgColor : UIColor.white.cgColor
        } else {
            SVProgressHUD.show(withStatus: "Loading")
            Auth.auth().signIn(withEmail: email, password: password) {[weak self] (user, err) in
                if let error = err {
                    print(error.localizedDescription)
                    let alert = UIAlertController(title: "Ошибка", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    SVProgressHUD.dismiss()
                    self?.present(alert, animated: true, completion: nil)
                } else {
                    print("User: \(user?.uid ?? "") signed in")
                    //checking
                    let myref = Database.database().reference().child("Users")
                    myref.child((user?.uid)!).child("role").observeSingleEvent(of: .value, with: { (snapshot) in
                        if let userRole = snapshot.value as? String {
                            if userRole == "user" {
                                self?.defaults.set(true, forKey: "UserIsLoggedIn")
                                SVProgressHUD.dismiss()
                                // show main controller
                                let mainController = MainTabController()
                                self?.present(mainController, animated: true, completion: nil)
                                
                            } else if userRole == "company" {
                                self?.defaults.set(true, forKey: "CompanyIsLoggedIn")
                                SVProgressHUD.dismiss()
                                // show company controller
                                let companyController = CompanyTabController()
                                self?.present(companyController, animated: true, completion: nil)
                            }
                        }
                    })
                }
            }
        }
    }
    private func signupPressed() {
        let registrationVC = RegistrationViewController()
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    
}
