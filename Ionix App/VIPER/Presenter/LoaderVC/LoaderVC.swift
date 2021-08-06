//
//  LoaderVC.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 05/08/21.
//

import UIKit

class LoaderVC: UIViewController {
    @IBOutlet var mainContent: UIView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var contentMessage: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        modalPresentationStyle = .overCurrentContext
        contentMessage.setViewRoundedCorner()
    }
}
