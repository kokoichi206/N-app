//
//  HandShake.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import SwiftUI

struct HandShake: Identifiable, Codable {
    var id: String
    var cate: String
    var title: String
    var subtitle: String
    var img: String
    var caption: String
    var date: String
    var link: String
    var release_link: String
    var arti_code: String
    var kouen: [Kouen]
    var application_term: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "code"
        case cate
        case title
        case subtitle
        case img
        case caption
        case date
        case link
        case release_link
        case arti_code
        case kouen
        case application_term
    }
}

struct HandShakeList: Codable {
    var count: String
    var data: [HandShake]
    
    private enum CodingKeys: String, CodingKey {
        case count
        case data
    }
}

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
