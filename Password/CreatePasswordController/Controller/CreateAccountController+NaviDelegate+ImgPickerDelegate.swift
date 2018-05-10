//
//  CreatePasswordController+NaviDelegate+ImgPickerDelegate.swift
//  Password
//
//  Created by 辛忠翰 on 08/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension CreateAccountController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //我們可以加入 imgPickerController.allowsEditing = true 來縮放照片，也就是我們的editedImg
        if let editedImg = info[UIImagePickerControllerEditedImage] as? UIImage{
            createAccountView.profileImg = editedImg
        }else if let originalImg = info[UIImagePickerControllerOriginalImage] as? UIImage {
            createAccountView.profileImg = originalImg
        }
        dismiss(animated: true, completion: nil)
    }
}
