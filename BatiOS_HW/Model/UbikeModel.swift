//
//  UbikeModel.swift
//  BatiOS_HW
//
//  Created by Michael Namara on 2023/6/21.
//

import Foundation

struct UbikeModel: Codable {
    let area: String
    let na: String
    
    enum CodingKeys: String, CodingKey {
        case area = "sarea"
        case na = "sna"
    }
}
