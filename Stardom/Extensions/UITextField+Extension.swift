//
//  UITextField+Extension.swift
//  Stardom
//
//  Created by Aibek Rakhim on 3/18/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

extension UITextField {
    
    public convenience init(placeHolder: String, fontSize: CGFloat) {
        self.init()
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = 6
        self.backgroundColor = .white
        self.textColor = .black
        self.font = UIFont(name: "ProximaNova-Semibold", size: fontSize)
        self.autocorrectionType = .no
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.white.cgColor
        self.clearButtonMode = .whileEditing
        // placeholder
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: placeHolder, attributes: [NSAttributedStringKey.font: UIFont(name: "ProximaNova-Semibold", size: fontSize)!, .foregroundColor: UIColor(red: 147.0/255.0, green: 147.0/255.0, blue: 147.0/255.0, alpha: 1)]))
        self.attributedPlaceholder = placeholder
    }

    func addLeftImage(textField: UITextField, imageName: String, imageWidth: Double, imageHeight: Double) {
        leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 18, y: 0, width: imageWidth, height: imageHeight))
        imageView.image = UIImage(named: imageName)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth+25, height: imageHeight))
        view.addSubview(imageView)
        leftView = view
    }
   
}


