//
//  Schedule.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/27.
//

import Foundation
import SwiftUI

struct Schedule: Identifiable, Codable {
    var id: String
    var title: String
    var text: String
    var date: String
    var start_time: String
    var end_time: String
    var cate: String
    var link: String
    var arti_code: [[String]]
    
    private enum CodingKeys: String, CodingKey {
        case id = "code"
        case title
        case text
        case date
        case start_time
        case end_time
        case cate
        case link
        case arti_code
    }
}
