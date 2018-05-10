//
//  LoginViewController.swift
//  Password
//
//  Created by 辛忠翰 on 09/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let backgroundView: UIImageView = {
       let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "backgroundView")
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        authenticateWithBiometric()
    }

}


extension LoginViewController{
    fileprivate func setupViews(){
        view.addSubview(backgroundView)
        backgroundView.fullAnchor(superView: view)
        setupBlurEffect()
    }
    fileprivate func setupBlurEffect(){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundView.addSubview(blurEffectView)
    }
}



