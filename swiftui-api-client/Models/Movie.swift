//
//  Movie.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import SwiftUI

struct Movie: Identifiable, Codable {
    var id: String
    var title: String
    var img: String
    var date: String
    var link: String
    var cate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "code"
        case title
        case img
        case date
        case link
        case cate
    }
}

struct MovieList: Codable {
    var count: String
    var data: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case count
        case data
    }
}
