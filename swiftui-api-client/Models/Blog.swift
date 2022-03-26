//
//  Blog.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/27.
//

import Foundation
import SwiftUI

struct Blog: Identifiable, Codable {
    var id: String
    var title: String
    var text: String
    var img: String
    var date: String
    var link: String
    var artist_img: String
    var arti_code: String
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "code"
        case title
        case text
        case img
        case date
        case link
        case artist_img
        case arti_code
        case name
    }
}

