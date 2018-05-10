//
//  MainController.swift
//  Password
//
//  Created by 辛忠翰 on 07/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import CoreData
import LocalAuthentication
class MainController: UIViewController{
    
    
    var accounts = [Account]()
    
    let tableView: UITableView = {
        let tbv = UITableView()
        return tbv
    }()
    let cellId = "TableViewCellID"
    override func viewDidLoad() {
        
        setupTableView()
        setupNaviStyle()
        setupTableViewStyle()
        registerCell()
        fetchAccountsFromCoreData()
        UINavigationBar.appearance().prefersLargeTitles = true
        
    }
}





extension MainController{
    func setupNaviStyle() {
//        navigationItem.title = "Accounts"
        //因為TableView在滑動的時候，預設的title顏色為black，但我們希望是white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        
        //設定bar的背景顏色
        let lightRed = UIColor.rgb(red: 247, green: 66, blue: 82)
        navigationController?.navigationBar.barTintColor = lightRed
        
        setupRightNavigationItemByImage(img: "plus", selector: #selector(handleAddPassword))
        setupLeftNavigationItemByTitle(title: "Reset", selector: #selector(handleResetItem))
    }
    
    @objc func handleAddPassword(){
        let createPasswordController = CreateAccountController()
        createPasswordController.addAndEditCompanyDelegate = self
        let naviController = CustomNavigationController(rootViewController: createPasswordController)
        present(naviController, animated: true, completion: nil)
    }
    
    @objc func handleResetItem(){
        let context = CoreDataManager.shared.persistantContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Account.fetchRequest())
        do{
            try context.execute(batchDeleteRequest)
            var indexToMovie = [IndexPath]()
            for (index, _) in accounts.enumerated(){
                let indexPath = IndexPath(row: index, section: 0)
                indexToMovie.append(indexPath)
            }
            accounts.removeAll()
            tableView.deleteRows(at: indexToMovie, with: .left)
        }catch let deleteErr{
            print("Failed to batch delete company: ", deleteErr.localizedDescription)
        }
        
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.fullAnchor(superView: view)
    }
    
    internal func setupTableViewStyle(){
        tableView.backgroundColor = UIColor.darkBlueColor
        //        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        //讓沒有row的地方，直接就是底色
        let blankView = UIView(frame: .zero)
        tableView.tableFooterView = blankView
    }
    
    internal func registerCell(){
        tableView.register(PasswordCell.self, forCellReuseIdentifier: cellId)
    }
    
    func fetchAccountsFromCoreData(){
        CoreDataManager.shared.fetchAccounts { (accounts) in
            self.accounts = accounts
            self.tableView.reloadData()
        }
    }
    
  
}




