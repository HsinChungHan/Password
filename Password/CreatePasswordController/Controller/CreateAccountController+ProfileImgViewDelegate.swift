//
//  CreatePasswordController+ProfileImgViewDelegate.swift
//  Password
//
//  Created by 辛忠翰 on 08/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension CreateAccountController: ServiceImgViewDelegate{
    func presentImgPicker() {
        let imgPickerController = UIImagePickerController()
        imgPickerController.delegate = self
        imgPickerController.allowsEditing = true
        present(imgPickerController, animated: true, completion: nil)
    }
    
}
