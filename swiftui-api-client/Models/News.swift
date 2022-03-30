//
//  News.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import SwiftUI

struct News: Identifiable, Codable {
    var id: String
    var title: String
    var text: String
    var date: String
    var cate: String
    var link_url: String
    var arti_code: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "code"
        case title
        case text
        case date
        case cate
        case link_url
        case arti_code
    }
}

struct NewsList: Codable {
    var count: String
    var data: [News]
    
    private enum CodingKeys: String, CodingKey {
        case count
        case data
    }
}
