//
//  ServicesManager.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 05/08/21.
//

import Foundation

class ServicesManager {
    private var connection : ConnectionManager?
    private var path : String?
    
    static var shared: ServicesManager = {
        let instance = ServicesManager()
        instance.connection = ConnectionManager()
        instance.path = ""
        return instance
    }()
    
    func getListMemes (limit: Int, whenFinish: @escaping (Bool, [Any]?, Error?) -> Void){
        path = "/r/chile/new.json?limit=\(limit)"
        
        ConnectionManager.shared.APIRequest(to: path!, of: .GET, whenFinish: { (status, data, error) -> Void in
            
            if data != nil {
                if let json : [String: Any] = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    let arrayContent = self.decodeResponse(json: json)
                    whenFinish(true, arrayContent, nil)
                }else{
                    whenFinish(false, nil, error)
                }
            }else{
                whenFinish(false, nil, error)
            }
        })
    }
    
    
    private func decodeResponse(json: [String: Any]) -> [Any]{
        var arrayContent = [Any]()
        do {
            if let children = json["children"] as? [[String: Any]] {
                let objectData = try JSONSerialization.data(withJSONObject: children, options: [])
                let decoder = JSONDecoder()
                let object = try decoder.decode(ContentEntity.self, from: objectData)
                arrayContent.append(object)
            }
            
        }catch let errorDecoder {
            print(errorDecoder)
        }
        
        return arrayContent
    }
    
}
