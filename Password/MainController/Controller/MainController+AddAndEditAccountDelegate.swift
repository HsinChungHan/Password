//
//  CreateAccountController+AddAndEditAccountDelegate.swift
//  Password
//
//  Created by 辛忠翰 on 08/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension MainController: AddAndEditCompanyDelegate{
    func didEditAccount(account: Account) {
        guard let row = accounts.index(of: account) else {
            return
        }
        let indexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
    func didAddAccount(account: Account) {
        accounts.append(account)
        let newIndexpath = IndexPath(row: accounts.count-1, section: 0)
        tableView.insertRows(at: [newIndexpath], with: .bottom)
    }
    
}
