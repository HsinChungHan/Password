//
//  MainController+TableViewDelegate.swift
//  Password
//
//  Created by 辛忠翰 on 07/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension MainController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PasswordCell
        cell.setupViews()
        cell.account = accounts[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    headerView.backgroundColor = UIColor.lightBlue
    let textLabel = UILabel()
    textLabel.text = "Account List"
    textLabel.textColor = UIColor.darkBlueColor
    textLabel.font = UIFont.boldSystemFont(ofSize: 16)
    headerView.addSubview(textLabel)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    textLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
    textLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
    return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerLabel = UILabel()
        footerLabel.text = "No avaliable accounts..."
        footerLabel.textColor = UIColor.white
        footerLabel.textAlignment = .center
        footerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        return footerLabel
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return accounts.count == 0 ? 150 : 0
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteHandler)
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandler)
        deleteAction.backgroundColor = UIColor.lightRed
        editAction.backgroundColor = UIColor.darkBlueColor
        return [deleteAction, editAction]
    }
    
    func deleteHandler(action: UITableViewRowAction, indexPath: IndexPath) {
        let context = CoreDataManager.shared.persistantContainer.viewContext
        let account = accounts[indexPath.item]
        context.delete(account)
        do{
            try context.save()
        }catch let deleteErr{
            print("Failed to delete account from CoreData: \(deleteErr.localizedDescription)")
        }
        self.accounts.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func editHandler(action: UITableViewRowAction, indexPath: IndexPath) {
        let createAccountController = CreateAccountController()
        createAccountController.createAccountView.account = accounts[indexPath.row]
        createAccountController.addAndEditCompanyDelegate = self
        let naviController = UINavigationController(rootViewController: createAccountController)
        present(naviController, animated: true, completion: nil)
    }
    
    fileprivate func presentCopyLabel() {
        let copyLabel = UILabel()
        copyLabel.text = "Copy Successfully"
        copyLabel.textColor = UIColor.white
        copyLabel.font = UIFont.boldSystemFont(ofSize: 18)
        copyLabel.textAlignment = .center
        copyLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
//        copyLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 80)
        copyLabel.numberOfLines = 0
        copyLabel.layer.cornerRadius = 10.0
        copyLabel.clipsToBounds = true
        self.view.addSubview(copyLabel)
        copyLabel.centerAnchor(superView: view, width: 150, height: 80)
        copyLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            copyLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }, completion: { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                copyLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                copyLabel.alpha = 0
            }, completion: { (_) in
                copyLabel.removeFromSuperview()
            })
        })
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let copyAction = UIContextualAction(style: .normal, title: "Copy") {[weak self] (_, _, completion) in
            let account = self?.accounts[indexPath.item]
            let password = account?.password
            UIPasteboard.general.string = password
            self?.presentCopyLabel()
            completion(true)
        }
        copyAction.backgroundColor = UIColor.black
        return UISwipeActionsConfiguration(actions: [copyAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


