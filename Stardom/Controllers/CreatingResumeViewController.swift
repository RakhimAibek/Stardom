//
//  CreatingResumeViewController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/17/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit
import Fusuma
import Firebase

class CreatingResumeViewController: UIViewController, UIScrollViewDelegate, FusumaDelegate {
    
    var imageLink: String?
    var checkImageLoad = true
    let avatarTap = UITapGestureRecognizer()
    
    private var resumeView: ResumeView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        self.setCustomNavBar(leftBarBTNimage: nil, leftSelectorFunc: nil, rightBarBTNimage: nil, rightSelectorFunc: nil, title: nil)
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    //adding UIs to CV view
    private func setupViews() {
        avatarTap.addTarget(self, action: #selector(fusumaMethod))
        
        let mainView  = ResumeView(frame: self.view.frame)
        resumeView = mainView
        resumeView.scrollView.delegate = self
        resumeView.saveAction = saveBtnPressed
        resumeView.profileImageView.addGestureRecognizer(avatarTap)
        resumeView.scrollView.keyboardDismissMode = .onDrag
        //add to view
        self.view.addSubview(resumeView)
    }
    
    //setuping constraints
    private func setupConstraints() {
        resumeView.fillSuperView()
    }    

    // MARK: - Keyboard Delegates
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = resumeView.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        resumeView.scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        resumeView.scrollView.contentInset = contentInset
    }
    
    private func saveBtnPressed() {
        checkAllFields()
    }
    
    //for fetching FirebaseDatabase
    private func fetchData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("Users").child(userID).observe(.value) { (snapshot) in
            let userData = UserData(snapshot: snapshot)
            
            self.resumeView.nameTextField.text = userData.userName ?? ""
            self.resumeView.surnameTextField.text = userData.userSurname ?? ""
            self.resumeView.birthdayTextField.text = userData.userAge ?? ""
            self.resumeView.genderSegmentedControl.selectedSegmentIndex = (userData.gender == "female") ? 0 : 1
            self.resumeView.userHeightTextField.text = userData.userHeight.contains("cm") ? userData.userHeight : userData.userHeight + "cm"
            self.resumeView.userWeightTextField.text = userData.userWeight.contains("kg") ? userData.userWeight : userData.userWeight + "kg"
            self.resumeView.nationalityTextField.text = userData.userNationality ?? ""
            self.resumeView.experienceTextField.text = userData.userExperience ?? ""
            self.resumeView.tripSwitcher.isOn = (userData.tripValue == "1") ? true : false
            self.resumeView.movingSwitcher.isOn = (userData.movingValue == "1") ? true : false
            self.resumeView.userEmailTextField.text = userData.userEmail ?? ""
            self.resumeView.userPhoneNumberField.text = userData.phoneNumber ?? ""
            self.resumeView.descriptionTextView.text = userData.userDesc ?? ""
            self.resumeView.profileImageView.imageFromURL(urlString: userData.imgUrl ?? "")
            self.imageLink = userData.imgUrl
        }
    }
    
    //for checking each textField for isEmpty or no?
    private func checkAllFields() {
        
        var count = 0
        
        let textFieldArray = [resumeView.nameTextField, resumeView.surnameTextField, resumeView.birthdayTextField, resumeView.userHeightTextField, resumeView.userWeightTextField, resumeView.nationalityTextField, resumeView.experienceTextField ,resumeView.userPhoneNumberField, resumeView.userEmailTextField]
        
        textFieldArray.forEach { (textField) in
            count = count + ((textField.text?.isEmpty ?? false) ? 0 : 1)
            textField.layer.borderColor = (textField.text?.isEmpty)! ? UIColor.red.cgColor : UIColor(r: 228, g: 228, b: 228).cgColor
        }
        resumeView.descriptionTextView.layer.borderColor = (resumeView.descriptionTextView.text.isEmpty) ? UIColor.red.cgColor : UIColor(r: 228, g: 228, b: 228).cgColor
        
        if textFieldArray.count == count && !resumeView.descriptionTextView.text.isEmpty {
            guard let userName = resumeView.nameTextField.text, let userSurname = resumeView.surnameTextField.text, let userAge = resumeView.birthdayTextField.text, let userHeight = resumeView.userHeightTextField.text, let userWeight = resumeView.userWeightTextField.text, let userNationality = resumeView.nationalityTextField.text, let userExperience = resumeView.experienceTextField.text, let phoneNumber = resumeView.userPhoneNumberField.text, let userEmail = resumeView.userEmailTextField.text, let userDesc = resumeView.descriptionTextView.text else { return }
            
            var tripValue = ""
            var movingValue = ""
            let genderValue = (resumeView.genderSegmentedControl.selectedSegmentIndex == 0) ? "female" : "male"
            
            if resumeView.tripSwitcher.isOn {
                tripValue = "1"
            } else if resumeView.tripSwitcher.isOn == false {
                tripValue = "0"
            }
            
            if resumeView.movingSwitcher.isOn {
                movingValue = "1"
            } else if !resumeView.movingSwitcher.isOn {
                movingValue = "0"
            }
            
            let userData: [String: String] = ["userName": userName,
                            "userSurname": userSurname,
                            "userAge": userAge,
                            "userHeight": userHeight,
                            "userWeight": userWeight,
                            "userNationality": userNationality,
                            "userExperience": userExperience,
                            "canTrip": tripValue,
                            "userRole":"user",
                            "gender": genderValue,
                            "canMove": movingValue,
                            "phoneNumber": phoneNumber,
                            "userEmail": userEmail,
                            "userDesc": userDesc,
                            "imgUrl": imageLink != "" ? imageLink! : ""]
            
            guard let userID = Auth.auth().currentUser?.uid else { return }
            Database.database().reference().child("Users").child(userID).updateChildValues(userData) { [weak self] (err, reference) in
                if let error = err {
                    print(error.localizedDescription)
                } else {
                    let alert = UIAlertController(title: "Ваши данные успешно обновлены", message: nil, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self?.navigationController?.popToRootViewController(animated: true)
                    })
                    alert.addAction(ok)
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func fusumaMethod() {
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        fusumaCameraTitle = "Photo"
        fusumaCameraRollTitle = "Библиотека"
        fusumaTitleFont = UIFont(name: "ProximaNova-SemiBold", size: 14)
        fusumaSavesImage = true
        
        self.present(fusuma, animated: true, completion: nil)
        
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        self.resumeView.profileImageView.image = image
        self.checkImageLoad = false
        let userId = Auth.auth().currentUser?.uid
        var data = Data()
        data = UIImageJPEGRepresentation(image, 0.9)!
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        Storage.storage().reference().child("avatar").child((userId)! + ".jpg").putData(data, metadata: metadata, completion: { (metaData, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.imageLink = metaData?.downloadURL()?.absoluteString
                Database.database().reference().child("Users").child(userId ?? "").child("imgUrl").setValue(self.imageLink)
                self.checkImageLoad = true
            }
        })
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("Called just after a video has been selected.")
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
    }
}
