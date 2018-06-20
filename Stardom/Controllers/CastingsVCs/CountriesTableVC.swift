//
//  CountriesTableVC.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/1/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class CountriesTableVC: UITableViewController {
    
    let countryCellId = "myCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: countryCellId)
        self.setCustomNavBar(leftBarBTNimage: "leftBlackBarButton", leftSelectorFunc: #selector(leftBackBTNpressed), rightBarBTNimage: nil, rightSelectorFunc: nil, title: "Страны в Stardom")
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    @objc private func leftBackBTNpressed() {
        _ = navigationController?.popViewController(animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: countryCellId, for: indexPath)
        cell.textLabel?.text = "Country \(indexPath.row)"
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .blue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let citiesVC = CitiesTableVC()
            navigationController?.pushViewController(citiesVC, animated: true)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

}
