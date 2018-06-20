//
//  YearTableViewCell.swift
//  Stardom
//
//  Created by Aibek Rakhim on 4/29/18.
//  Copyright © 2018 NextStep Labs. All rights reserved.
//

import UIKit

class YearTableViewCell: UITableViewCell {
    
    let chooseYearLabel: UILabel = {
        let label = UILabel()
        label.text = "выбрать возраст"
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        label.textColor = UIColor(r: 155, g: 155, b: 155)
        return label
    }()
    
    let generalView: UIView = {
        let view = UIView()
        return view
    }()
    
    let justView: UIView = {
        let view = UIView()
        return view
    }()
    
    let fromTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.layer.cornerRadius = 4
        tf.layer.masksToBounds = true
        tf.attributedPlaceholder = NSAttributedString(string: "  от",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        tf.layer.borderColor = UIColor(r: 226, g: 226, b: 266).cgColor
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let beforeTextField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.layer.cornerRadius = 4
        tf.layer.masksToBounds = true
        tf.attributedPlaceholder = NSAttributedString(string: "  до",
                                                      attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        tf.layer.borderColor = UIColor(r: 226, g: 226, b: 266).cgColor
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 74, g: 74, b: 74)
        return view
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    //MARK: -adding ui elements to main view to displaying
    private func setupViews() {
        [fromTextField, lineView, beforeTextField].forEach {
            self.justView.addSubview($0)
        }
        
        generalView.addSubview(chooseYearLabel)
        generalView.addSubview(justView)
        
        [generalView].forEach {
            self.addSubview($0)
        }
    }
    
    //MARK: -adding constraints to UIElements
    private func setupConstraints() {
        generalView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 55))
        generalView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        chooseYearLabel.anchor(top: generalView.topAnchor, leading: generalView.leadingAnchor, bottom: nil, trailing: generalView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 17))
        
        justView.anchor(top: chooseYearLabel.bottomAnchor, leading: chooseYearLabel.leadingAnchor, bottom: generalView.bottomAnchor, trailing: chooseYearLabel.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))

        fromTextField.anchor(top: justView.topAnchor, leading: justView.leadingAnchor, bottom: justView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: self.frame.width/2.5, height: 0))
        
        beforeTextField.anchor(top: justView.topAnchor, leading: nil, bottom: justView.bottomAnchor, trailing: justView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: self.frame.width/2.5, height: 0))
        
        lineView.setOnlyAnchorSize(size: .init(width: self.frame.width/17.8571, height: 1))
        lineView.centerAnchor(to: justView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
