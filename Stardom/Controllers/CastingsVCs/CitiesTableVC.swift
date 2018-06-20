//
//  CitiesTableVC.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/1/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class CitiesTableVC: UITableViewController {
    
    let citiesCellID = "myCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: citiesCellID)
        self.setCustomNavBar(leftBarBTNimage: "leftBlackBarButton", leftSelectorFunc: #selector(leftBackBTNpressed), rightBarBTNimage: nil, rightSelectorFunc: nil, title: "Казахстан")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc private func leftBackBTNpressed() {
        _ = navigationController?.popViewController(animated: true)
    }

    //MARK: -UITextFieldDelegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: citiesCellID, for: indexPath)
        cell.textLabel?.text = "Cities \(indexPath.row)"
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //selecting or unselecting the row of tableview cells
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark{
                cell.accessoryType = .none
            }
            else{
                cell.accessoryType = .checkmark
            }
        }
    }
 
}
