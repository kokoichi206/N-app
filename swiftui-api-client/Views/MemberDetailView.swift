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
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                URLImage(url: member.img).frame(width: 300, height: 300, alignment: .center)
                VStack(alignment: .center) {
                    HStack() {
                            Text(member.name)
                                .font(.largeTitle)
                                .foregroundColor(.purple)
                    }
                    
                        HStack {
                        Text(member.kana)
                                .font(.caption)
                                .foregroundColor(.purple)
                                
                        Text(member.englishName)
                            .font(.caption)
                            .foregroundColor(.purple)
                        }
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                

                }
            .padding(8)
        }
        .navigationTitle(member.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(
                    action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                    }
                ).tint(.white)
            }
        }
        
    }
}

struct ContentView: View {
    init() {
        setupNavigationBar()
    }
     
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemPurple
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private let mockMembers: [Member] = [
        .mock1
    ]

    var body: some View {
        VStack {
            NavigationView {
                MemberDetailView(member: .mock1)
            }
        }
    }
}

struct MemberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
