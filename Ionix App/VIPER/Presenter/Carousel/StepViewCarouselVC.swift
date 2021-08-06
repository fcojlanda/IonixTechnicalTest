//
//  StepViewCarouselVC.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 04/08/21.
//

import UIKit
import AVFoundation
import CoreLocation
import UserNotifications

protocol StepViewCarouselProtocol{
    func nextView(finishCarousel: Bool)
}

class StepViewCarouselVC: UIViewController, CLLocationManagerDelegate {
    var delegate: StepViewCarouselProtocol?
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mainButton: UIButton!
    @IBOutlet var alternativeButton: UIButton!
    @IBOutlet var lastButton: UIButton!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var buttonsView: UIView!
    @IBOutlet var statusView: UIView!
    private var statusPermission: Bool? = false
    private var locationManager: CLLocationManager?
    
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
        
        if permission!.typePermission == .Location {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }
        
        if askedUsedForPermission(permission!.typePermission!) == true {
            viewForAskUserForPermission(show: false)
            getStatusPermission(permission!.typePermission!)
            if statusPermission! {
                statusLabel.text = "Granted"
                statusLabel.textColor = UIColor(named: "grantedColor")
            }else{
                statusLabel.text = "Rejected"
                statusLabel.textColor = UIColor(named: "rejectedColor")
            }
        }else{
            viewForAskUserForPermission(show: true)
            mainButton.setMainButton(text: "Allow")
            alternativeButton.setSecundaryButton(text: "Cancel")
        }
        
        if isLastPermission {
            lastButton.setAlternativeButton(text: "Finish")
            lastButton.isHidden = false
        }else{
            lastButton.isHidden = true
        }
    }
    
    private func viewForAskUserForPermission(show: Bool){
        buttonsView.isHidden = !show
        statusView.isHidden = show
    }
    
    @IBAction func mainButtonAction(_ sender: Any) {
        requestUserForPermission()
    }
    @IBAction func alternativeButtonAction(_ sender: Any) {
        delegate?.nextView(finishCarousel: false)
    }
    
    @IBAction func lastButtonAction(_ sender: Any) {
        delegate?.nextView(finishCarousel: true)
    }
    
    private func requestUserForPermission(){
        switch permission!.typePermission! {
        case .Camera:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                UserDefaults.standard.setValue(granted, forKey: self.permission!.typePermission!.getStringValue())
            }
            break
        case .Location:
            locationManager?.requestWhenInUseAuthorization()
            break
        case .PushNotifications:
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert,.badge]) { (granted, error) in
                UserDefaults.standard.setValue(granted, forKey: self.permission!.typePermission!.getStringValue())
            }
            break
        default:
            break
        }
    }
    
    private func getStatusPermission(_ permission: TypePermission){
        switch permission {
        case .Camera:
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized{
                statusPermission = true
            } else{
                statusPermission = false
            }
        case .PushNotifications:
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                switch settings.authorizationStatus {
                case .authorized:
                    self.statusPermission = true
                    break
                default:
                    self.statusPermission = false
                    break
                    
                }
            }
        case .Location:
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                    case .authorizedAlways, .authorizedWhenInUse:
                        self.statusPermission = true
                        break
                    default:
                        self.statusPermission = false
                        break
                }
            } else {
                self.statusPermission = false
            }
        default:
            self.statusPermission = false
            break
        }
    }
    
    func askedUsedForPermission(_ permission: TypePermission)->Bool{
        return (UserDefaults.standard.value(forKey: permission.getStringValue()) == nil) ? false : true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            UserDefaults.standard.setValue(true, forKey: permission!.typePermission!.getStringValue())
        }else{
            UserDefaults.standard.setValue(false, forKey: permission!.typePermission!.getStringValue())
        }
        viewForAskUserForPermission(show: false)
    }
}
