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
                if granted {
                    
                } else {

                }
            }
            break
        case .Location:
            break
        case .PushNotifications:
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert,.badge]) { (granted, error) in
                if granted {
                    
                }else{
                    
                }
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
