//
//  ProfileViewController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 4/19/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    var profileView: ProfileView!

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Загрузка")
        setupViews()
        setupConstraints()
        self.setCustomNavBar(leftBarBTNimage: nil, leftSelectorFunc: nil, rightBarBTNimage: "settings_icon", rightSelectorFunc: #selector(settingBTNpressed), title: nil)
        fetchData()
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    private func setupViews() {
        let mainView = ProfileView(frame: self.view.frame)
        profileView = mainView
        profileView.editAction = editBtnPressed
        profileView.scrollView.delegate = self
        profileView.scrollView.keyboardDismissMode = .onDrag
        self.view.addSubview(profileView)
    }
    
    private func setupConstraints() {
        profileView.fillSuperView()
    }
    
    
    @objc private func settingBTNpressed() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }

    private func fetchData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("Users").child(userID).observe(.value) { (snapshot) in
            let userData = UserData(snapshot: snapshot)
            
            self.profileView.nameTextField.text = userData.userName ?? ""
            self.profileView.surnameTextField.text = userData.userSurname ?? ""
            self.profileView.birthdayTextField.text = userData.userAge ?? ""
            self.profileView.genderSegmentedControl.selectedSegmentIndex = (userData.gender == "female") ? 0 : 1
            self.profileView.userHeightTextField.text = userData.userHeight.contains("cm") ? userData.userHeight : userData.userHeight + "cm"
            self.profileView.userWeightTextField.text = userData.userWeight.contains("kg") ? userData.userWeight : userData.userWeight + "kg"
            self.profileView.nationalityTextField.text = userData.userNationality ?? ""
            self.profileView.experienceTextField.text = userData.userExperience ?? ""
            self.profileView.tripSwitcher.isOn = (userData.tripValue == "1") ? true : false
            self.profileView.movingSwitcher.isOn = (userData.movingValue == "1") ? true : false
            self.profileView.userEmailTextField.text = userData.userEmail ?? ""
            self.profileView.userPhoneNumberField.text = userData.phoneNumber ?? ""
            self.profileView.descriptionTextView.text = userData.userDesc ?? ""
            self.profileView.profileImageView.imageFromURL(urlString: userData.imgUrl ?? "")
            
            if userData.userName == "" || userData.userSurname == "" || userData.userAge == "" || userData.userHeight == "" || userData.userWeight == "" || userData.userNationality == "" {
                let alert = UIAlertController(title: "Заполните данные", message: "Нажмите на кнопку редактировать резюме", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Хорошо", style: .default, handler: { (action) in
                    self.navigationController?.popToRootViewController(animated: true)
                })
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }

        }
    }
    
    @objc private func editBtnPressed() {
        self.navigationController?.pushViewController(CreatingResumeViewController(), animated: true)
    }
}
