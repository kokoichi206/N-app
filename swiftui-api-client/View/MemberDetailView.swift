//
//  MemberDetailView.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/17.
//

import SwiftUI

struct MemberDetailView: View {
    let member: Member
    
    private let mockMembers: [Member] = [
        .mock1
    ]
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(member.img)
                            .resizable()
                            .frame(
                                width: 16.0,
                                height: 16.0
                            )
                        Text(member.name)
                            .font(.caption)
                    }
                    
                    Text(member.name)
                        .font(.body)
                        .fontWeight(.semibold)

                }
                Spacer()
            }
            .padding(8)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MemberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MemberDetailView(member: .mock1)
    }
}
