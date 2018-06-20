//
//  SettingsViewController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/18/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit
import MessageUI
import Firebase

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    let settingsCellID = "settingsCell"
    
    let stardomDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Stardom - платформа для поиска актуальных кастингов от настоящих модельных агенств, киноиндустрий."
        label.textColor = UIColor(r: 50, g: 50, b: 50)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont(name: "ProximaNova-Bold", size: 16)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 44
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: settingsCellID)
        
        [stardomDescriptionLabel, tableView].forEach {
            self.view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        stardomDescriptionLabel.anchor(top: view.safeTopAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 60))
        
        tableView.anchor(top: stardomDescriptionLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeBottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingsCellID, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.textAlignment = .center
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Позвонить нам"
        case 1:
            cell.textLabel?.text = "Вы компания?"
            cell.textLabel?.textColor = UIColor(r: 206, g: 36, b: 42)
        case 2:
            cell.textLabel?.text = "Выход из профиля"
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if let url = URL(string: "tel://87754844014"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        case 1:
            let alert = UIAlertController(title: "Скоро будет обновление Stardom", message: "И чтобы первым получить доступ к приложению для просмотра моделей, актеров напишите нам - stardom.kz@gmail.com для оформления заявки", preferredStyle: .alert)
            let action = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        case 2:
            do {
                let alert = UIAlertController(title: "Вы хотите выйти из своего профиля?", message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "Да", style: .default, handler: { [weak self] (UIAlertAction) in
                    do {
                        try Auth.auth().signOut()
                        UserDefaults.standard.set(false, forKey: "UserIsLoggedIn")
                        self?.present(UINavigationController(rootViewController: LoginViewController()), animated: true, completion: nil)
                        
                    } catch let signOutError as NSError {
                        print(signOutError.localizedDescription)
                    }
                })
                
                let cancel = UIAlertAction(title: "Нет", style: .destructive, handler: nil)
                
                alert.addAction(action)
                alert.addAction(cancel)
                
                self.present(alert, animated: true, completion: nil)
                
                
            } catch let err {
                print(err.localizedDescription)
            }
        default:
            break
        }
    }
    
}
