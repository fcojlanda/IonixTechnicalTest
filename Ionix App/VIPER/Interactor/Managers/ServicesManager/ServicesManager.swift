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
    
    func getListMemes (limit: Int, whenFinish: @escaping (Bool, [Any]?, TypeServiceError?) -> Void){
        path = "/r/chile/new.json?limit=\(limit)"
        
        ConnectionManager.shared.APIRequest(to: path!, of: .GET, whenFinish: { (status, data, error) -> Void in
            if data != nil {
                if let json : [String: Any] = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    let arrayContent = self.decodeResponse(object: json)
                    whenFinish(true, arrayContent, nil)
                }else{
                    whenFinish(false, nil, error)
                }
            }else{
                whenFinish(false, nil, error)
            }
        })
    }
    
    
    private func decodeResponse(object: [String: Any]) -> [Any]{
        var arrayContent = [ContentEntity]()
        if let rootData = object["data"] as? [String: Any] {
            if let children = rootData["children"] as? [[String: Any]] {
                let shitpostingFilter = children.filter({
                    ($0["data"] as? [String: Any])!["link_flair_text"] as? String == "Shitposting"
                })
                if shitpostingFilter.count > 0 {
                    let postWithImage = shitpostingFilter.filter({
                        ($0["data"] as? [String: Any])!["post_hint"] as? String == "image"
                    })
                    
                    if postWithImage.count > 0 {
                        for post in postWithImage {
                            arrayContent.append(ContentEntity(data: post["data"] as? [String: Any] ?? [:]))
                        }
                    }
                }
                    
            }
        }
        return arrayContent
    }
    
}
