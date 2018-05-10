//
//  CoredataManager.swift
//  Password
//
//  Created by 辛忠翰 on 08/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import CoreData
import UIKit
enum CoreDataManagerConstant: String {
    case container = "PasswordModel"
    case loadSuccessfully = "Successfully load store!!"
    case loadFailed = "Loading of store failure: "
    case accountRequest = "Account"
    case fetchSuccessfully = "Successfully fetch request!!"
    case fetchFailed = "Fetching of accounts failure: "
    case serviceKey = "serviceName"
    case dateKey = "date"
    case passwordKey = "password"
    case serviceImgKey = "serviceImgData"
    case saveSuccessfully = "Successfully save account!!"
    case saveFailed = "Saving account failure: "
    
}

struct CoreDataManager{
    //這樣的寫法可以創造singleTern
    //如此一來CoreDataManager的所有properties便可永遠活在app run time時期
    static let shared = CoreDataManager()
    
    let persistantContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: CoreDataManagerConstant.container.rawValue)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let err = error{
                print("\(CoreDataManagerConstant.loadFailed.rawValue) \(err)")
                return
            }
            print(CoreDataManagerConstant.loadSuccessfully.rawValue)
        })
        return container
    }()
    
    func fetchAccounts(completion:(_ accounts: [Account])->()){
        let context = persistantContainer.viewContext
        //去抓取core data中存的資料
        //這邊xcode會自動幫我們加<NSFetchRequestResult>，但是我們需要自行把它改成我們的entity name(這邊是Account)
        let fetchRequest = NSFetchRequest<Account>(entityName: CoreDataManagerConstant.accountRequest.rawValue)
        //用do-catch來實做context.fetch
        do{
            let accounts = try context.fetch(fetchRequest)
            print(CoreDataManagerConstant.fetchSuccessfully.rawValue)
            completion(accounts)
        }catch let err{
            print("\(CoreDataManagerConstant.fetchFailed.rawValue) \(err.localizedDescription)")
        }
    }
    
    func saveAccountData(values: LocalAccount, completion: (_ account: Account)->()){
        let context = persistantContainer.viewContext
        let account = NSEntityDescription.insertNewObject(forEntityName: CoreDataManagerConstant.accountRequest.rawValue, into: context) as! Account
        
        account.setValue(values.serviceName , forKey: CoreDataManagerConstant.serviceKey.rawValue)
        let date = Date()
        account.setValue(date , forKey: CoreDataManagerConstant.dateKey.rawValue)
        account.setValue(values.password, forKey: CoreDataManagerConstant.passwordKey.rawValue)
        let imgData = UIImageJPEGRepresentation(values.serviceImg, 1.0)
        account.setValue(imgData, forKey: CoreDataManagerConstant.serviceImgKey.rawValue)
        do{
            try context.save()
            print(CoreDataManagerConstant.saveSuccessfully.rawValue)
            completion(account)
        }catch let err{
            print("\(CoreDataManagerConstant.saveFailed.rawValue) \(err.localizedDescription)")
        }
    }
}
