//
//  UIViewExtensions.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 05/08/21.
//

import Foundation
import UIKit

extension UIView {
    func setViewRoundedCorner(){
        layer.cornerRadius = 10.0
        layer.borderWidth = 0.0
        layer.masksToBounds = true
    }
}
