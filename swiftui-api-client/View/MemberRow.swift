//
//  MemberRow.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/17.
//

import SwiftUI

struct MemberRow: View {
    let member: Member
    var body: some View {
        HStack {
            Image(member.img)
                .resizable()
                .frame(
                    width: 44.0,
                    height: 44.0
                )
            VStack(alignment: .leading) {
                Text(member.kana)
                    .font(.caption)
                Text(member.name)
                    .font(.body)
                    .fontWeight(.semibold)
            }
        }
    }
}
