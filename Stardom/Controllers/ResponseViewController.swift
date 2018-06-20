//
//  ResponseViewController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 4/19/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit
import Firebase

class ResponseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var castArr = [Casts]()
    var filtered = [Casts]()
    var responseStatus = [String]()

    var tableView = UITableView()
    var buttonStackView: UIStackView!
    var lineStackView: UIStackView!
    
    var responceCellId = "responceCell"
    
    let myInvitationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Мои отклики", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 18)
//        button.addTarget(self, action: #selector(showMyInvitaton(sender:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()
    
//    let otherInvitationButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Приглашения", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.textAlignment = .center
//        button.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 18)
//        button.alpha = 0.37
//        button.addTarget(self, action: #selector(showMyInvitaton(sender:)), for: .touchUpInside)
//        button.tag = 1
//        return button
//    }()
    
    let viewLine1: UIView = {
        let view1 = UIView()
        view1.backgroundColor = .red
        return view1
    }()
    
    let viewLine2: UIView = {
        let view2 = UIView()
        view2.backgroundColor = UIColor(r: 175, g: 175, b: 175)
        view2.alpha = 0.37
        return view2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        
        //fetching data
        fetchCasts()
    }
    
    //fetching data
    private func fetchCasts() {
        Casts.fetch { (casts, error) in
            guard let casts = casts else {
                print(error ?? "error News.fetch fetching")
                return
            }
            self.castArr.removeAll()
            self.filtered.removeAll()
            self.castArr = casts
            
            for i in self.castArr {
                let separate = i.applyed?.components(separatedBy: ",")
                separate?.forEach({
                    let separatedByStatus = $0.components(separatedBy: "|")
                    if separatedByStatus.contains(Auth.auth().currentUser?.uid ?? "") {
                        self.filtered.append(i)
                    }
                })
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //for seeing responses
//    @objc private func showMyInvitaton(sender: UIButton) {
//        if sender.tag == 0 {
//            viewLine1.alpha = 1
//            viewLine2.alpha = 0.37
//            viewLine1.backgroundColor = .red
//            viewLine2.backgroundColor = UIColor(r: 175, g: 175, b: 175)
//            myInvitationButton.alpha = 1
//            otherInvitationButton.alpha = 0.37
//
//            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
//                self.myInvitationButton.isEnabled = false
//                self.otherInvitationButton.isEnabled = true
//            }, completion: nil)
//
//        } else if sender.tag == 1 {
//            viewLine1.backgroundColor = UIColor(r: 175, g: 175, b: 175)
//            viewLine2.backgroundColor = .red
//            myInvitationButton.alpha = 0.37
//            viewLine1.alpha = 0.37
//            viewLine2.alpha = 1
//            otherInvitationButton.alpha = 1
//
//            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
//                self.myInvitationButton.isEnabled = true
//                self.otherInvitationButton.isEnabled = false
//            }, completion: nil)
//
//        }
//        sender.pulsate()
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: responceCellId, for: indexPath) as! ResponseTableViewCell
        cell.selectionStyle = .none
        
        cell.companyNameLabel.text = "\(filtered[indexPath.row].company ?? "")"
        cell.companyImageView.imageFromURL(urlString: filtered[indexPath.row].imageUrl ?? "")
        if (filtered[indexPath.row].applyed?.contains("0"))! {
            cell.responceImageView.image = UIImage(named: "question_responce_icon")
        } else if (filtered[indexPath.row].applyed?.contains("1"))! {
            cell.responceImageView.image = UIImage(named: "yes_responce_icon")
        } else if (filtered[indexPath.row].applyed?.contains("2"))! {
            cell.responceImageView.image = UIImage(named: "no_responce_icon")
        }
        return cell
    }
    
    //adding UIs to vc`s view
    private func setupViews() {
        view.backgroundColor = UIColor(r: 252, g: 253, b: 255)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(ResponseTableViewCell.self, forCellReuseIdentifier: responceCellId)
        
//        buttonStackView = view.createStackViewHorizontal(views: [myInvitationButton], spacingNo: 28, distribution: .fillEqually)
//        lineStackView = view.createStackViewHorizontal(views: [viewLine1, viewLine2], spacingNo: 28, distribution: .fillEqually)
        

        [myInvitationButton, viewLine1 ,tableView].forEach {
            self.view.addSubview($0)
        }
    }
    
    //setuping constraints
    private func setupConstraints() {
        myInvitationButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myInvitationButton.anchor(top: view.safeTopAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: self.view.frame.width/1.139, height: self.view.frame.height/26.68))

        viewLine1.topAnchor.constraint(equalTo: myInvitationButton.bottomAnchor, constant: 3).isActive = true
        viewLine1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        viewLine1.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: self.view.frame.width/1.139, height: 2))
        
        tableView.anchor(top: viewLine1.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeBottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 40, left: 16, bottom: 10, right: 16), size: .init(width: 0, height: 0))
    
    }
}
