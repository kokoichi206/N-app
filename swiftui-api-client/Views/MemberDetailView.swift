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
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: member.img)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 250, height: 300)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(5)
                    .shadow(color: .gray.opacity(0.7), radius: 5)
                    VStack(alignment: .center) {
                                Text(member.name)
                                    .font(.largeTitle)
                                    .foregroundColor(Color(red: 0.5, green: 0.1, blue: 0.5, opacity: 0.9))
                            HStack {
                                Text(member.kana)
                                Text(member.englishName)
                            }                              .font(.caption2)
                            .foregroundColor(Color(red: 0.7, green: 0.2, blue: 0.7, opacity: 0.4))
                        VStack {
                            HStack {
                                Text("生年月日")
                                Text(member.birthDay)
                            }
                            HStack {
                                Text("血液型")
                                Text("\(member.blood)型")
                            }
                            HStack {
                                Text("星座")
                                Text(member.constellation)
                            }
                            HStack {
                                Text("身長")
                                    
                                Text("未定")
                            }
                            HStack {
                                Text("SNS")
                                Text(member.img)
                            }
                            HStack {
                                Text("SNS")
                                Text(member.groupcode)
                            }
                        }.foregroundColor(Color(red: 0.5, green: 0.1, blue: 0.5, opacity: 0.9))
                            .font(.system(size: 10, weight: .regular))
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
