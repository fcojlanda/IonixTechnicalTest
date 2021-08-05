//
//  UICollectionViewCellExtensions.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 04/08/21.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func setRoundedCorner(){
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 0.0
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
