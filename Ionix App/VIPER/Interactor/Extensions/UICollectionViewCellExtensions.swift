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
        self.contentView.layer.cornerRadius = 6.0
        self.contentView.layer.borderWidth = 0.0
        self.contentView.layer.masksToBounds = true
    }
}
