//
//  MainTabBarController.swift
//  Password
//
//  Created by 辛忠翰 on 10/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
class MainTabBarController: UITabBarController{
    override func viewDidLoad() {
        setupTabBarController()
    }
}

extension MainTabBarController{
    func setupTabBarController(){
        let socialVC = MainController()
        let socialNaviController = setupNavigationController(with: socialVC, tabTitle: "Social", tabImage: #imageLiteral(resourceName: "social").withRenderingMode(.alwaysOriginal))
        
        let bankVC = MainController()
        let bankNaviController = setupNavigationController(with: bankVC, tabTitle: "Bank", tabImage: #imageLiteral(resourceName: "social").withRenderingMode(.alwaysOriginal))
        
        let memberVC = MainController()
        let memberNaviController = setupNavigationController(with: memberVC, tabTitle: "Member", tabImage: #imageLiteral(resourceName: "social").withRenderingMode(.alwaysOriginal))
        
        
        tabBar.tintColor = .red
        viewControllers = [
            socialNaviController,
            bankNaviController,
            memberNaviController
        ]
    }
    

    
    //MARK:- Helper Functions
    func setupNavigationController(with rootVC: UIViewController, tabTitle: String, tabImage: UIImage?) -> UIViewController{
        let naviController = UINavigationController(rootViewController: rootVC)
        rootVC.navigationItem.title = tabTitle
        naviController.tabBarItem.title = tabTitle
        naviController.tabBarItem.image = tabImage
        return naviController
    }
    
}
