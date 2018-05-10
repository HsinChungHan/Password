//
//  CreatePasswordController.swift
//  Password
//
//  Created by 辛忠翰 on 07/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import CoreData

struct LocalAccount {
    let serviceName: String
    let password: String
    let serviceImg: UIImage
}

protocol AddAndEditCompanyDelegate {
    func didAddAccount(account: Account)
    func didEditAccount(account: Account)
}


class CreateAccountController: UIViewController {
    var addAndEditCompanyDelegate: AddAndEditCompanyDelegate?
    
    let createAccountView = CreateAccountView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBlueColor
        setupCreateCompanyNaviBar()
        setupViews()
    }

}

extension CreateAccountController{
    internal func setupCreateCompanyNaviBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveItem))
    }
    
    @objc func handleCancelItem(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSaveItem(){
        let account = createAccountView.account
        if account == nil{
            createNewAccountIntoCoreData()
        }else {
            editAccountIntoCoreData()
        }
    }
    
    fileprivate func createNewAccountIntoCoreData(){
        let values = createAccountView.fetchAllValues()
        let accountValues = LocalAccount.init(serviceName: values.serviceName, password: values.password, serviceImg: values.serviceImage)
        CoreDataManager.shared.saveAccountData(values: accountValues) { (account) in
            dismiss(animated: true, completion: {[weak self] in
            self?.addAndEditCompanyDelegate?.didAddAccount(account: account)
            })
        }
    }
    
    fileprivate func editAccountIntoCoreData(){
        let context = CoreDataManager.shared.persistantContainer.viewContext
        let values = createAccountView.fetchAllValues()
        let accountValues = LocalAccount.init(serviceName: values.serviceName, password: values.password, serviceImg: values.serviceImage)
        guard let account = createAccountView.account else {return}
        account.serviceName = accountValues.serviceName
        account.password = accountValues.password
        let imgData = UIImageJPEGRepresentation(accountValues.serviceImg, 1.0)
        account.serviceImgData = imgData
        do{
            try context.save()
            dismiss(animated: true) {
                self.addAndEditCompanyDelegate?.didEditAccount(account: account)
            }
        }catch let saveErr{
            print("Failed to edit: ", saveErr)
        }
        
        
    }
    
    func setupViews(){
        view.addSubview(createAccountView)
        createAccountView.serviceImgViewDelegate = self
        createAccountView.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: view.frame.height*1/3 + 70)
    }
}
