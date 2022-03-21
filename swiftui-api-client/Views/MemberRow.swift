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
            URLImage(url: member.img)
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

struct MemberRow_Previews: PreviewProvider {
    static var previews: some View {
        MemberRow(member: .mock1)
    }
}
