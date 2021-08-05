//
//  StepViewCarouselVC.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 04/08/21.
//

import UIKit

protocol StepViewCarouselProtocol{
    func nextView()
}

class StepViewCarouselVC: UIViewController {
    var delegate: StepViewCarouselProtocol?
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mainButton: UIButton!
    @IBOutlet var alternativeButton: UIButton!
    @IBOutlet var lastButton: UIButton!
    
    var permission: PermissionEntity?
    var isLastPermission = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    static public func setPermission(permission: PermissionEntity, isLastPermission: Bool = false)->StepViewCarouselVC{
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "stepViewCarouselVC") as? StepViewCarouselVC
        vc!.permission = permission
        vc!.isLastPermission = isLastPermission
        return vc!
    }
    
    private func initViewController(){
        mainImage.image = UIImage(named: permission?.imageNamePermission ?? "")
        titleLabel.text = permission?.titlePermission ?? ""
        descriptionLabel.text = permission?.descriptionPermission ?? ""
        
        mainButton.setTitle("Enable", for: .normal)
        mainButton.tintColor = UIColor.gray
        
        alternativeButton.setTitle("Cancel", for: .normal)
        
        if isLastPermission {
            lastButton.setTitle("Finish", for: .normal)
            lastButton.isHidden = false
        }else{
            lastButton.isHidden = true
        }

    }
    
    @IBAction func mainButtonAction(_ sender: Any) {
        PermissionManager.requestUserForPermission(permission!.typePermission!)
    }
    @IBAction func alternativeButtonAction(_ sender: Any) {
        delegate?.nextView()
    }
    
    @IBAction func lastButtonAction(_ sender: Any) {
    }
    
}
