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
            VStack(alignment: .center) {
                URLImage(url: member.img).frame(width: 250, height: 250, alignment: .center)
                VStack(alignment: .center, spacing: 0.0) {
                        HStack {
                            Text(member.name)
                                .font(.largeTitle)
                            Spacer()
                        }
                    
                        HStack {
                        Text(member.kana)
                                .font(.caption)
                                
                        Text(member.englishName)
                            .font(.caption)
                        }
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                

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
