
//  CastingsViewController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 4/19/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.

import UIKit
import SVProgressHUD
import FirebaseDatabase

class UserResumesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var usersArr = [UserData]()
    var filteredArray = [UserData]()
    
    let menuBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let genderSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Все", "Девушки", "Парни", "Дети"])
        sc.selectedSegmentIndex = 0
        sc.tintColor = UIColor.black
        sc.addTarget(self, action: #selector(genderSortChanged(_:)), for: .valueChanged)
        return sc
    }()
    
    //collectionView reuseIdentifier
    let cellId = "allResumes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show(withStatus: "Загрузка...")
        collectionView?.backgroundColor = .white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UserResumesViewCell.self, forCellWithReuseIdentifier: cellId)
        self.setCustomNavBar(leftBarBTNimage: nil, leftSelectorFunc: nil, rightBarBTNimage: nil, rightSelectorFunc: nil, title: "Резюме")
        setupViews()
        //fetching data
        fetchCasts()
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    private func setupViews() {
        // for correct displaying
        collectionView?.frame = CGRect(x: 0, y: 45, width: self.view.frame.width, height: self.view.frame.height-40)
        menuBar.addSubview(genderSegmentedControl)
        self.view.addSubview(menuBar)
        
        menuBar.anchor(top: self.view.safeTopAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: self.view.frame.width, height: 45))
        
        genderSegmentedControl.anchor(top: nil, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 29))
        genderSegmentedControl.centerYAnchor.constraint(equalTo: self.menuBar.centerYAnchor).isActive = true
    }
    
    //fetching data
    private func fetchCasts() {
        UserData.fetch { (users, error) in
            guard let users = users else {
                print(error ?? "error of users fetching")
                return
            }
            self.usersArr.removeAll()
            self.usersArr = users
            
            self.usersArr = self.usersArr.filter({ (user1) -> Bool in
                if user1.userName != "" && user1.userSurname != "" && user1.userAge != "" && user1.userWeight != "" && user1.userHeight != "" && user1.userNationality != "" && user1.userEmail != "" && user1.phoneNumber != "" && user1.role != "company" {
                    return true
                }
                return false
            })
            
            self.filteredArray = self.usersArr
            self.collectionView?.reloadData()
        }
    }
    
    //sort by gender is tapped
    @objc private func genderSortChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.filteredArray = usersArr
        case 1:
            self.filteredArray = usersArr.filter({ (users) -> Bool in
                return (users.gender ?? "") == "female" })
        case 2:
            self.filteredArray = usersArr.filter({ (users) -> Bool in
                return (users.gender ?? "") == "male" })
        case 3: self.filteredArray = usersArr.filter({ (users) -> Bool in
            var state = false
            if users.userAge != "" {
                let age = Int(users.userAge) ?? 0
                if age > 0 && age < 16{
                    state = true
                }
            }
            return state
        })
        default:
            break
        }
        
        collectionView?.reloadData()
    }
}

extension UserResumesVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserResumesViewCell
        
        cell.userName.text = "\(filteredArray[indexPath.row].userName ?? "") \(filteredArray[indexPath.row].userSurname ?? "")"
        cell.userAge.text = "возраст: \(filteredArray[indexPath.row].userAge ?? "")"
        
        DispatchQueue.main.async {
            cell.userImageView.imageFromURL(urlString: self.filteredArray[indexPath.row].imgUrl)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 106)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cast = filteredArray[indexPath.row]
//        let detailedVC = DetailedCastInfoViewController()
//        detailedVC.selectedCasting = cast
//        navigationController?.pushViewController(detailedVC, animated: true)
    }
}
