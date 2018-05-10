//
//  AppDelegate.swift
//  Password
//
//  Created by 辛忠翰 on 07/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit


//讓statusBar的字變白色，同時要讓didFinishLaunchingWithOptions中的naviController繼承CustomNavigationController
class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

extension UINavigationController{
    open override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    fileprivate func setupNavigationBar() {
        //統一所有navigationBar的appearance
        //一定要放在最上面
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.lightRed
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBar()
        window = UIWindow()
        window?.makeKeyAndVisible()
//        let mainController = MainController()
        let loginController = LoginViewController()
        let naviController = CustomNavigationController(rootViewController: loginController)
        window?.rootViewController = naviController
        return true
    }

}
