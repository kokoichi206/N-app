//
//  Live.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import SwiftUI

struct Live: Identifiable, Codable {
    var id: String
    var cate: String
    var title: String
    var img: String
    var caption: String
    var date: String
    var link: String
    var kouen: [LiveKouen]
    
    private enum CodingKeys: String, CodingKey {
        case id = "code"
        case cate
        case title
        case img
        case caption
        case date
        case link
        case kouen
    }
}

struct LiveList: Codable {
    var count: String
    var data: [Live]
    
    private enum CodingKeys: String, CodingKey {
        case count
        case data
    }
}

struct LiveKouen: Codable {
    var date: String
    var youbi: String
    var area: String
    var place: String
    var open_time: String
    var start_time: String
    var cate: String
    
    private enum CodingKeys: String, CodingKey {
        case date
        case youbi
        case area
        case place
        case open_time
        case start_time
        case cate
    }
}
