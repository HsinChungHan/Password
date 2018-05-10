//
//  LoginViewController+AuthenticDelegate.swift
//  Password
//
//  Created by 辛忠翰 on 09/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import LocalAuthentication
protocol AuthenticateWithBiometricDelegate {
    func authenticateWithBiometric()
}


extension LoginViewController: AuthenticateWithBiometricDelegate{
    
    func authenticateWithBiometric(){
        let localAuthContext = LAContext()
        let reasonText = "Authenticaion is required to sign in 😎"
        var authError: NSError?
        
        //這邊的error是個pointer所以要用&
        if !localAuthContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            //無法透過指紋驗證
            if let err = authError{
                print(err.localizedDescription)
            }
            
            return
        }
        
        //可以透過指紋驗證
        authenticWithTouchID(context: localAuthContext, reasonText: reasonText)
        
    }
    
    
    
    func authenticWithTouchID(context: LAContext, reasonText: String){
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonText) { (success, error) in
            if let err = error{
                print(err.localizedDescription)
                OperationQueue.main.addOperation {
                    
                }
                return
            }else{
                print("Successfully authenticated!!")
                OperationQueue.main.addOperation {
                    let mainTabBarController = MainTabBarController()
                    let loginVC = LoginViewController()
                    let naviController = UINavigationController(rootViewController: loginVC)
                    self.present(mainTabBarController, animated: true, completion: nil)
                }
            }
        }
    }
}
