//
//  Members.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/19.
//

import Foundation

struct Members: Codable {
    var data: [Member]
    var count: String
    
    private enum CodingKeys: String, CodingKey {
        case data
        case count
    }
}
