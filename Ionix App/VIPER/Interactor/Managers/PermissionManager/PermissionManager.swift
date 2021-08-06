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
    
    public func locationManager(_ manager: CLLocationManager,
                                    didChangeAuthorization status: CLAuthorizationStatus) {
    }
}
