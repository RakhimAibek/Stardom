//
//  UserData.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/18/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit
import Firebase

class UserData: NSObject {
    var userName: String!
    var userSurname: String!
    var userAge: String!
    var userHeight: String!
    var userWeight: String!
    var userNationality: String!
    var userExperience: String!
    var phoneNumber: String!
    var userEmail: String!
    var userDesc: String!
    var imgUrl: String!
    var tripValue: String!
    var movingValue: String!
    var gender: String!
    var id: String?
    var role: String?
    
    init(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? NSDictionary else { return }
        self.userName = value["userName"] as? String
        self.userSurname = value["userSurname"] as? String
        self.userAge = value["userAge"] as? String
        self.userHeight = value["userHeight"] as? String
        self.userWeight = value["userWeight"] as? String
        self.userNationality = value["userNationality"] as? String
        self.userExperience = value["userExperience"] as? String
        self.phoneNumber = value["phoneNumber"] as? String
        self.userEmail = value["userEmail"] as? String
        self.userDesc = value["userDesc"] as? String
        self.imgUrl = value["imgUrl"] as? String
        self.tripValue = value["canTrip"] as? String
        self.movingValue = value["canMove"] as? String
        self.gender = value["gender"] as? String
    }
    
    init(dictionary: [String: String]) {
        self.userName = dictionary["userName"]
        self.userSurname = dictionary["userSurname"]
        self.userAge = dictionary["userAge"]
        self.userHeight = dictionary["userHeight"]
        self.userWeight = dictionary["userWeight"]
        self.userNationality = dictionary["userNationality"]
        self.userExperience = dictionary["userExperience"]
        self.phoneNumber = dictionary["userEmail"]
        self.userDesc = dictionary["userDesc"]
        self.imgUrl = dictionary["imgUrl"]
        self.tripValue = dictionary["canTrip"]
        self.movingValue = dictionary["canMove"]
        self.gender = dictionary["gender"]
        self.role = dictionary["role"]
        super.init()
    }
    
    //function for fetching data from Database
    static func fetch(completion: @escaping (([UserData]?, String?) -> Void)) {
        Database.database().reference().child("Users").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String: [String: String]] {
                var userArr = [UserData]()
                for i in data {
                    let users = UserData(dictionary: i.value)
                    users.id = i.key
                    userArr.append(users)
                }
                completion(userArr, nil)
                return
            }
            completion(nil, "News fetching error occured")
        })
    }
    
}
