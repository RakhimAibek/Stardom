//
//  FilterParameterViewController.swift
//  Stardom
//
//  Created by Aibek Rakhim on 4/25/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class FilterParameterViewController: UITableViewController, UITextFieldDelegate {
    
    let locationCellID = "locationCellID"
    let yearCellID = "yearCellID"
    let bodyHeightCellID = "bodyCellID"
    let tripCellID = "tripCellID"
    let experienceCellID = "experienceCellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: locationCellID)
        tableView.register(YearTableViewCell.self, forCellReuseIdentifier: yearCellID)
        tableView.register(BodyHeightTableViewCell.self, forCellReuseIdentifier: bodyHeightCellID)
        tableView.register(TripTableViewCell.self, forCellReuseIdentifier: tripCellID)
        tableView.register(ExperienceTableViewCell.self, forCellReuseIdentifier: experienceCellID)
        tableView.backgroundColor = UIColor(r: 249, g: 249, b: 250)
        self.setCustomNavBar(leftBarBTNimage: "leftBlackBarButton", leftSelectorFunc: #selector(backBTNpressed), rightBarBTNimage: "doneBarBTNimage", rightSelectorFunc: #selector(doneBTNpressed), title: "Параметры поиска")
    }
    
    @objc private func backBTNpressed() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc private func doneBTNpressed() {
        print("pressed")
    }
    
    //MARK: -UITableViewDelegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 80
        } else if indexPath.row == 2 {
            return 80
        }
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: locationCellID, for: indexPath) as! LocationTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            // set the data here
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: yearCellID, for: indexPath) as! YearTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            // set the data here
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: bodyHeightCellID, for: indexPath) as! BodyHeightTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            // set the data here
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: tripCellID, for: indexPath) as! TripTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            // set the data here
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: experienceCellID, for: indexPath) as! ExperienceTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            // set the data here
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let countriesVC = CountriesTableVC()
            navigationController?.pushViewController(countriesVC, animated: true)
        }
    }
    
    
}
