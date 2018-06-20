//
//  Date.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/19/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import Foundation

extension String {
    var toDate: Date {
        return Date.Formatter.customDate.date(from: self)!
    }
}

extension Date {
    struct Formatter {
        static let customDate: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter
        }()
    }
}
