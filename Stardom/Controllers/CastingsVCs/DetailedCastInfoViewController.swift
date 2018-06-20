//
//  DetailedCastInfoViewController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 4/25/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit
import Firebase

class DetailedCastInfoViewController: UIViewController {
    
    private var detailedView: DetailedCastView!
    var bottomConstraintsVar:CGFloat = -50
    var selectedCasting: Casts?
    var favCasting: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        calculateBottomAnchor()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        let mainView = DetailedCastView(frame: view.frame)
        detailedView = mainView
        detailedView.applyAction = applyBtnTapped
        self.view.addSubview(detailedView)
    }
    
    private func setupConstraints() {
        detailedView.anchor(top: view.safeTopAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: -bottomConstraintsVar, right: 0), size: .init(width: 0, height: 0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        
        guard let cast = selectedCasting else { return }
        detailedView.castingTitleLabel.text = cast.title
        detailedView.moneyLabel.text = cast.paymentMoney
        detailedView.locationAddressLabel.text = cast.city
        detailedView.descriptionTextView.text = cast.descriptionCast
        detailedView.bodyHeightInfoLabel.text = cast.height
        detailedView.experienceInfoLabel.text = cast.experience
        detailedView.nationalityInfoLabel.text = cast.nationality
        
        let maleArray = (cast.male ?? "").components(separatedBy: ",")
        detailedView.maleInfoLabel.text = cast.male != "" ? maleArray[0] + " от " + maleArray[1] + " до " + maleArray[2] : "Мужчины -"
        let femaleArray = (cast.female ?? "").components(separatedBy: ",")
        detailedView.femaleInfoLabel.text = cast.female != "" ? (femaleArray[0] + " от " + femaleArray[1] + " до " + femaleArray[2]) : "Женщины -"
        
        detailedView.deadlineLabel.text = "до " + cast.deadline!
        detailedView.bodyHeightInfoLabel.text = cast.height
        
        self.setCustomNavBar(leftBarBTNimage: "leftBlackBarButton", leftSelectorFunc: #selector(backBTNpressed), rightBarBTNimage: nil, rightSelectorFunc: nil, title: cast.company ?? "Подробнее")
        
        //for asynchronic downloading the image
        guard let castImage = cast.imageUrl else { return }
        DispatchQueue.main.async {
            self.detailedView.castImageView.imageFromURL(urlString: castImage)
        }
        
        let applyedCasting = cast.applyed?.components(separatedBy: ",")
        
        applyedCasting?.forEach({
            let separatedByStatus = $0.components(separatedBy: "|")
            if separatedByStatus.contains(Auth.auth().currentUser?.uid ?? "") {
                detailedView.applyButton.setTitle("Отправлено", for: .normal)
                detailedView.applyButton.backgroundColor = UIColor(r: 167, g: 167, b: 167)
                detailedView.applyButton.isUserInteractionEnabled = false
            }
        })
    }
    
    private func calculateBottomAnchor() {
        bottomConstraintsVar = view.frame.height == 812 ? 82 : 50
    }
    
    //MARK: -Actions after UIBarButtons are pressed
    @objc private func backBTNpressed() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc private func shareBTNpressed() {
        /*TODO: -not important function, but dont forget to do
        */
        print("SHARE BUTTON PRESSED")
    }

    @objc func applyBtnTapped() {
        guard let castID = selectedCasting?.id else { return }
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        var applied = ""

        if selectedCasting?.applyed == "" {
            applied = "\(userID)|0"
        } else {
            applied = (selectedCasting?.applyed)! + "," + userID + "|" + "0"
        }
        
        let updateData = ["applyed": applied]
        Database.database().reference().child("Casts").child(castID).updateChildValues(updateData) { (err, reference) in
            if err != nil {
                print(err?.localizedDescription ?? "")
            } else {
                print("succes send your CV")
                self.detailedView.applyButton.setTitle("Отправлено", for: .normal)
                self.detailedView.applyButton.backgroundColor = UIColor(r: 167, g: 167, b: 167)
                self.detailedView.applyButton.isUserInteractionEnabled = false
            }
        }
    }
}
