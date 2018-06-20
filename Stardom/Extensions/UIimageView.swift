//
//  UIimageView.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/19/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromURL(urlString: String) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                } else {
                    if let image = UIImage(data: data!) {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            }).resume()
        }
    }
}
