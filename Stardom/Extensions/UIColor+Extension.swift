//
//  UIColor+Extension.swift
//  Stardom
//
//  Created by Aibek Rakhim on 3/18/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.

import UIKit

public extension UIColor {
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static var greenBorderColor: UIColor = {
        return UIColor(r: 80, g: 227, b: 194)
    }()
    
    static var redBorderColor: UIColor = {
        return UIColor(r: 255, g: 151, b: 164)
    }()
    
}

