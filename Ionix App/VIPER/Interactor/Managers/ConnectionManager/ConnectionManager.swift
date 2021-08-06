//
//  ConnectionManager.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 05/08/21.
//

import Foundation
import SystemConfiguration

class ConnectionManager {
    private var baseURL: String?
    private var tokenApi: String?
    
    static var shared: ConnectionManager = {
        let instance = ConnectionManager()
        instance.baseURL = "https://www.reddit.com"
        return instance
    }()
    
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret
    }
    
    func APIRequest (to url: String, of type: TypeRequest, headers: [String: String]? = nil, whenFinish: @escaping (Bool, Data?, Error?) -> Void){
        if isConnectedToNetwork() {
            let session: URLSession = URLSession(configuration: .default)
            
            var request = URLRequest(url: URL(string: baseURL! + url)!)
            request.httpMethod = type.description()
        
            if headers != nil {
                for header in headers! {
                    request.setValue(header.value, forHTTPHeaderField: header.key)
                }
            }
            
            session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    whenFinish(false, nil, error)
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    let error = NSError(domain: url, code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "No se pudo obtener la respuesta correctamente"])
                    if 200 ... 299 ~= response.statusCode {
                        if data != nil {
                            whenFinish(true, data!, nil)
                        }else{
                            whenFinish(false, nil, error)
                        }
                    }else{
                        whenFinish(false, nil, error)
                    }
                }else{
                    whenFinish(false, nil, error)
                }
            }).resume()
        }else{
            let error = NSError(domain: url, code: -1, userInfo: [NSLocalizedDescriptionKey: "No se encontró conexión a Internet"])
            whenFinish(false, nil, error)
        }
        
    }
    
}
