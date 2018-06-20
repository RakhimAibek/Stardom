//
//  ResponseTableViewCell.swift
//  Stardom
//
//  Created by Aibek Rakhim on 5/16/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class ResponseTableViewCell: UITableViewCell {
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 50, height: 50)
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "hollywood")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let companyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "ProximaNova-Bold", size: 18)
        return label
    }()
    
    let responceImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    //for avoiding the reusing the each cell
    override func prepareForReuse() {
        super.prepareForReuse()
        self.companyNameLabel.text = ""
        self.companyImageView.backgroundColor = .green
    }
    
    //adding UIs to tableviewCEll`s view
    private func setupViews() {
        [companyImageView, companyNameLabel, responceImageView].forEach {
            self.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        companyImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 4, left: 0, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        companyImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        companyNameLabel.anchor(top: nil, leading: companyImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 40), size: .init(width: 0, height: 20))
        companyNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        responceImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: .init(width: 22, height: 22))
        responceImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
