//
//  StepViewCarouselVC.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 04/08/21.
//

import UIKit

class StepViewCarouselVC: UIViewController {
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mainButton: UIButton!
    @IBOutlet var alternativeButton: UIButton!
    
    var permission: PermissionEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public func setPermission(permission: PermissionEntity){
        self.permission = permission
    }
    
    private func initViewController(){
        mainImage.image = UIImage(named: permission?.imageNamePermission ?? "")
        titleLabel.text = permission?.titlePermission ?? ""
        descriptionLabel.text = permission?.descriptionPermission ?? ""
    }
    
    @IBAction func mainButtonAction(_ sender: Any) {
        switch permission!.typePermission {
        case .Camera:
            break
        case .Location:
            break
        case .PushNotifications:
            break
        default:
            break
        }
    }
    @IBAction func alternativeButtonAction(_ sender: Any) {
        
    }
}
