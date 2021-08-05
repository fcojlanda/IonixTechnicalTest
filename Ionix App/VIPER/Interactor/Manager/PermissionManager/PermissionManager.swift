//
//  PermissionManager.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 05/08/21.
//

import Foundation
import AVFoundation
import CoreLocation
import UserNotifications

class PermissionManager: NSObject, CLLocationManagerDelegate {
    private var manager : PermissionManager?
    private var locationManager: CLLocationManager?
    
    static var shared: PermissionManager = {
        let instance = PermissionManager()
        instance.locationManager = CLLocationManager()
        instance.locationManager!.delegate = instance
        return instance
    }()
    
    static func requestUserForPermission(_ permission: TypePermission){
        switch permission {
        case .Camera:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                UserDefaults.standard.setValue(granted, forKey: permission.getStringValue())
            }
            break
        case .Location:
            UserDefaults.standard.setValue(false, forKey: permission.getStringValue())
            break
        case .PushNotifications:
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert,.badge]) { (granted, error) in
                UserDefaults.standard.setValue(granted, forKey: permission.getStringValue())
            }
            break
        default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager,
                                    didChangeAuthorization status: CLAuthorizationStatus) {
    }
}
