//
//  ServiceIconCell.swift
//  Password
//
//  Created by 辛忠翰 on 09/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ServiceIconCell: BasicCell{
    
    lazy var serviceImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "select_photo_empty")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    override func setupViews() {
        addSubview(serviceImageView)
        serviceImageView.centerAnchor(superView: self, width: 50, height: 50)
        serviceImageView.layoutIfNeeded()
        serviceImageView.layer.cornerRadius = serviceImageView.frame.height/2
        serviceImageView.clipsToBounds = true
    }
}
