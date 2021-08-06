//
//  ContentEntity.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 04/08/21.
//

import Foundation
import UIKit

struct ContentEntity: Codable{
    var image: UIImage?
    var urlImage: String?
    var title: String?
    var score: Int?
    var num_comments: Int?
    
    init(from decoder: Decoder) throws {
    }
    
    func encode(to encoder: Encoder) throws {
    }
}
