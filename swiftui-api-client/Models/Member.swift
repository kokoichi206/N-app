//
//  Member.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/17.
//

import Foundation
import SwiftUI

struct Member: Identifiable, Codable {
    var id: String
    var birthDay: String
    var blood: String
    var cate: String
    var constellation: String
    var englishName: String
    var god: String
    var graduation: String
    var groupcode: String
    var img: String
    var kana: String
    var link: String
    var name: String
    var pick: String?
    var under: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "code"
        case birthDay = "birthday"
        case blood
        case cate
        case constellation
        case englishName = "english_name"
        case god
        case graduation
        case groupcode
        case img
        case kana
        case link
        case name
        case pick
        case under
    }
}

struct MemberList: Codable {
    var count: String
    var data: [Member]
    
    private enum CodingKeys: String, CodingKey {
        case count
        case data
    }
}
