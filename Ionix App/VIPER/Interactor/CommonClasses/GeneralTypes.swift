//
//  GeneralTypes.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 04/08/21.
//

import Foundation

enum TypePermission{
    case Camera, PushNotifications, Location, Other, None
    
    func getStringValue()->String{
        switch self {
        case .Camera:
            return "Camera"
        case .PushNotifications:
            return "PushNotifications"
        case .Location:
            return "Location"
        case .Other:
            return "Other"
        case .None:
            return "None"
        }
    }
}

enum TypeRequest {
    case GET, POST, PUT
    
    func description()->String {
        switch self {
        case .GET: return "GET"
        case .POST: return "POST"
        case .PUT: return "PUT"
        }
    }
}
