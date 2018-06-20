//
//  CastingsViewController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 4/19/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.

import UIKit
import SVProgressHUD
import FirebaseDatabase

class CastingsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var castArr = [Casts]()
    var filteredArray = [Casts]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show(withStatus: "Загрузка кастингов")
        collectionView?.backgroundColor = .white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(CastingsViewCell.self, forCellWithReuseIdentifier: "cellId")
        self.setCustomNavBar(leftBarBTNimage: nil, leftSelectorFunc: nil, rightBarBTNimage: nil, rightSelectorFunc: nil, title: "Актуальные кастинги")
        setupViews()
        //fetching data
        fetchCasts()
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        
        tabBarController?.tabBar.isHidden = false
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
            Casts.fetch { (casts, error) in
            guard let casts = casts else {
                print(error ?? "error News.fetch fetching")
                return
            }
            self.castArr.removeAll()
            self.castArr = casts
            //sorting by date
            self.castArr = self.castArr.sorted(by: {(cast1, cast2) in
                let sortedValue = cast1.publicationDate?.toDate.compare((cast2.publicationDate?.toDate)!) == .orderedDescending
                return sortedValue
            })
            self.filteredArray = self.castArr
            self.collectionView?.reloadData()
        }
    }
    
    //MARK: -IBactions
    @objc private func searchButtonPressed() {
        
    }
    
    @objc private func filterBarButtonPressed() {
        let filterVC = FilterParameterViewController()
        navigationController?.pushViewController(filterVC, animated: true)
    }
}

extension CastingsViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CastingsViewCell
        let casts = filteredArray[indexPath.row]
        
        cell.titleCastLabel.text = "\(casts.title ?? "")"
        cell.cityAndDataLabel.text = "\(casts.city ?? "") | до \(casts.deadline ?? "")"
        cell.companyName.text = "ищет \(casts.company ?? "")"
        
        DispatchQueue.main.async {
            cell.castImageView.imageFromURL(urlString: casts.imageUrl ?? "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 168)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cast = filteredArray[indexPath.row]
        let detailedVC = DetailedCastInfoViewController()
        detailedVC.selectedCasting = cast
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    @objc private func genderSortChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.filteredArray = castArr
        case 1:
            self.filteredArray = castArr.filter({ (cast) -> Bool in
                return (cast.female ?? "") != "" })
        case 2:
            self.filteredArray = castArr.filter({ (cast) -> Bool in
                return (cast.male ?? "") != "" })
        case 3: self.filteredArray = castArr.filter({ (cast) -> Bool in
            var state = false
            if cast.male != "" {
                let maleArray = (cast.male ?? "").components(separatedBy: ",")
                let maleFirst = Int(maleArray[1]) ?? 0
                let maleSecond = Int(maleArray[2]) ?? 0
                if (maleFirst > 0 && maleSecond < 16) {
                    state = true
                }
            }
            if cast.female != "" {
                let femaleArray = (cast.female ?? "").components(separatedBy: ",")
                let femaleFirst = Int(femaleArray[1]) ?? 0
                let femaleSecond = Int(femaleArray[2]) ?? 0
                if (femaleFirst > 0 && femaleSecond < 16) {
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
