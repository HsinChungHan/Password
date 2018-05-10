//
//  PasswordCell.swift
//  Password
//
//  Created by 辛忠翰 on 07/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
enum Constant: CGFloat {
    case padding = 10
    case height = 40
}

class PasswordCell: UITableViewCell {
    var account: Account?{
        didSet{
            titleLabel.text = account?.serviceName
            print("account?.serviceName: ", account?.serviceName)
            if let imgData = account?.serviceImgData{
                let img = UIImage(data: imgData)
                profileImageView.image = img
            }
            passwordLabel.text = account?.password
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "GG"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    //BoldItalic
    //https://stackoverflow.com/questions/28496093/making-text-bold-using-attributed-string-in-swift
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "123455"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-BoldItalic", size: 18.0)
        label.textColor = .white
        return label
    }()
    
    
    
    let profileImageView: UIImageView = {
        let piv = UIImageView()
        piv.image = UIImage(named: "select_photo_empty")
        piv.backgroundColor = UIColor.clear
        piv.contentMode = .scaleAspectFill
        return piv
    }()
    
    
    func setupViews() {
        backgroundColor = UIColor.tealColor
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(passwordLabel)
        profileImageView.anchor(top: nil, bottom: nil, left: leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: Constant.padding.rawValue, rightPadding: 0, width: Constant.height.rawValue, height: Constant.height.rawValue)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        titleLabel.anchor(top: profileImageView.topAnchor, bottom: profileImageView.bottomAnchor, left: profileImageView.rightAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 20, rightPadding: 0, width: 120, height: 0)
        
        passwordLabel.anchor(top: titleLabel.topAnchor, bottom: titleLabel.bottomAnchor, left: titleLabel.rightAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 0)
        
    }
}

extension PasswordCell{
    
}
