//
//  Casts.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/19/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Casts: NSObject {
    
    //properties of the class News
    var title: String?
    var imageUrl: String?
    var deadline: String?
    var descriptionCast: String?
    var company: String?
    var height: String?
    var experience: String?
    var paymentMoney: String?
    var nationality: String?
    var male: String?
    var female: String?
    var city: String?
    var publicationDate: String?
    var favorite: Bool?
    var id: String?
    var applyed: String?
    
    init(title: String, imageUrl: String, deadline: String, descriptionCast: String, company: String, height: String, experience: String, paymentMoney: String, nationality: String, male: String, female: String, city: String, publicationDate: String, favorite: Bool) {
        self.title = title
        self.imageUrl = imageUrl
        self.deadline = deadline
        self.descriptionCast = descriptionCast
        self.company = company
        self.height = height
        self.experience = experience
        self.paymentMoney = paymentMoney
        self.nationality = nationality
        self.male = male
        self.female = female
        self.city = city
        self.publicationDate = publicationDate
        self.favorite = favorite
        self.applyed = ""
    }
    
    //Firebase init snapshot
//    init(snapshot: DataSnapshot) {
//        let data = snapshot.value as? NSDictionary
//        self.title = data?["title"] as? String ?? ""
//        self.infoSource = data?["infoSource"] as? String ?? ""
//        self.datePublication = data?["datePublication"] as? String ?? ""
//        self.descriptionNews = data?["description"] as? String ?? ""
//        self.imageLink = data?["imageLink"] as? String ?? ""
//        self.link = data?["link"] as? String ?? ""
//    }

    init(dictionary: [String: String]) {
        self.title = dictionary["title"]
        self.imageUrl = dictionary["castImage"]
        self.deadline = dictionary["deadlineDate"]
        self.descriptionCast = dictionary["description"]
        self.company = dictionary["company"]
        self.height = dictionary["height"]
        self.experience = dictionary["experience"]
        self.paymentMoney = dictionary["paymentMoney"]
        self.nationality = dictionary["nationality"]
        self.male = dictionary["male"]
        self.female = dictionary["female"]
        self.city = dictionary["city"]
        self.publicationDate = dictionary["publicationDate"]
        self.applyed = dictionary["applyed"]
        super.init()
    }

    //function for fetching data from Database
    static func fetch(completion: @escaping (([Casts]?, String?) -> Void)) {
        Database.database().reference().child("Casts").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String: [String: String]] {
                var castsArr = [Casts]()
                for i in data {
                    let casts = Casts(dictionary: i.value)
                    casts.id = i.key
                    castsArr.append(casts)
                }
                completion(castsArr, nil)
                return
            }
            completion(nil, "News fetching error occured")
        })
    }
    
}

