//
//  Kouen.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import SwiftUI

struct Kouen: Codable {
    var date: String
    var youbi: String
    var area: String
    var place: String
    var open_time: String
    var start_time: String
    
    private enum CodingKeys: String, CodingKey {
        case date
        case youbi
        case area
        case place
        case open_time
        case start_time
    }
}
