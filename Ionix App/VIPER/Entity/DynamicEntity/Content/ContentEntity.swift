//
//  ContentEntity.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 04/08/21.
//

import Foundation
import UIKit

class ContentEntity{
    var urlImage: String?
    var title: String?
    var score: Int?
    var num_comments: Int?
    
    init(data: [String: Any]){
        self.urlImage = data["url"] as? String ?? ""
        self.title = data["title"] as? String ?? ""
        self.score = data["score"] as? Int ?? -1
        self.num_comments = data["num_comments"] as? Int ?? -1
    }
}
