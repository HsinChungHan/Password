//
//  CreatePasswordView.swift
//  Password
//
//  Created by 辛忠翰 on 08/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
enum Services: String{
    case google = "Google"
    case facebook = "Facebook"
    case instagram = "Instagram"
    case twitter = "Twitter"
    case spotify = "Spotify"
}


protocol ServiceImgViewDelegate {
    func presentImgPicker()
}

class CreateAccountView: UIView {
    var services = [Services.google.rawValue,
                    Services.facebook.rawValue,
                    Services.instagram.rawValue,
                    Services.spotify.rawValue,
                    Services.twitter.rawValue
                    ]
    var cellID = "ServiceIconCellID"
    var serviceImgViewDelegate: ServiceImgViewDelegate?
    var account: Account?{
        didSet{
            guard let account = account else {return}
            guard let imgData = account.serviceImgData else {return}
            guard let img = UIImage(data: imgData)  else {
                return
            }
            serviceImageView.image = img
            passwordTextField.text = account.password
            serviceTextField.text = account.serviceName
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
        return cv
    }()
    
    
    public var profileImg: UIImage?{
        didSet{
            serviceImageView.image = profileImg
        }
    }
    
    lazy var serviceImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "select_photo_empty")
        imgView.contentMode = .scaleAspectFill
        //為了讓imgView可以被使用者點選
        imgView.isUserInteractionEnabled = true // imgViews by default are not interactive with user
        imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapImageView)))
        return imgView
    }()
    
    @objc fileprivate func handleTapImageView(){
        print("U tap the imgView...")
        serviceImgViewDelegate?.presentImgPicker()
    }
    
    var serviceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type the service here 😎"
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftViewMode = .always
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.text = "Service"
        textField.leftView = label
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type ur password here 😀"
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftViewMode = .always
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.text = "Password"
        textField.leftView = label
        return textField
    }()
    
    
    public func fetchNameTextFieldText() -> String{
        guard let name = serviceTextField.text else {return ""}
        return name
    }
    
    public func fetchProfileImg() -> UIImage {
        guard let img = serviceImageView.image else{ return UIImage()}
        return img
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightBlue
        setupViews()
        registerCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension CreateAccountView{
    internal func setupViews(){
        addSubview(collectionView)
        addSubview(serviceImageView)
        addSubview(serviceTextField)
        addSubview(passwordTextField)

        serviceImageView.anchor(top: topAnchor, bottom: nil, left: nil, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 150, height: 150)
        serviceImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        serviceImageView.layoutIfNeeded()
        serviceImageView.layer.cornerRadius = serviceImageView.frame.height/2
        serviceImageView.clipsToBounds = true
        
        collectionView.anchor(top: serviceImageView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 40, rightPadding: 40, width: 0, height: 50)
        collectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        serviceTextField.anchor(top: collectionView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 30)
        
        serviceTextField.layoutIfNeeded()
       
        passwordTextField.anchor(top: serviceTextField.bottomAnchor, bottom: nil, left: serviceTextField.leftAnchor, right: serviceTextField.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: serviceTextField.frame.height)
    }
    
    func fetchAllValues() -> (serviceName: String, password: String, serviceImage: UIImage){
        guard let serviceName = serviceTextField.text,
        let password = passwordTextField.text,
            let serviceImage = serviceImageView.image else{
                return ("", "", #imageLiteral(resourceName: "select_photo_empty"))
        }
        return (serviceName, password, serviceImage)
    }
    
    func registerCell(){
        collectionView.register(ServiceIconCell.self, forCellWithReuseIdentifier: cellID)
    }
}
