//
//  UIButtonExtensions.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 05/08/21.
//

import Foundation
import UIKit

extension UIButton {
    func setMainButton(text: String){
        backgroundColor = UIColor(named: "mainColor")
        setTitleColor(UIColor.white, for: .normal)
        setTitle(text, for: .normal)
        layer.cornerRadius = 15
        layer.borderWidth = 0
    }
    
    func setSecundaryButton(text: String){
        setTitleColor(UIColor.gray, for: .normal)
        setTitle(text, for: .normal)        
    }
    
    func setAlternativeButton(text: String){
        backgroundColor = UIColor.white
        setTitleColor(UIColor(named: "mainColor"), for: .normal)
        setTitle(text, for: .normal)
        
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "mainColor")!.cgColor
    }
}
