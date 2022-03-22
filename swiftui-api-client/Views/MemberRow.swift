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
        VStack {
            URLImage(url: member.img)
            VStack(alignment: .center) {
                Text(member.name)
                    .font(.body)
                    .fontWeight(.semibold)
                Text(member.kana)
                    .font(.body)
                    
            }
        }
    }
}

struct MemberRow_Previews: PreviewProvider {
    static var previews: some View {
        MemberRow(member: .mock1)
    }
}
