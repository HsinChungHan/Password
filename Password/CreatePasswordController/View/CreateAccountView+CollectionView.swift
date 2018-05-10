//
//  CreateAccountView+CollectionView.swift
//  Password
//
//  Created by 辛忠翰 on 09/05/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension CreateAccountView: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ServiceIconCell
        cell.serviceImageView.image = UIImage(named: services[indexPath.item]) 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        serviceImageView.image = UIImage(named: services[indexPath.item])
        serviceTextField.text = services[indexPath.item]
    }
}


extension CreateAccountView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 50
        let height = 50
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
