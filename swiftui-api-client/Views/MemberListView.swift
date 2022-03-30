//
//  ContentView.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/17.
//

import SwiftUI
import Combine
 
struct MemberListView: View {
    @StateObject private var viewModel = MemberListViewModel()
    
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            NavigationView {
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    Group {
                        switch viewModel.memberList {
                        case .idle, .loading:
                            ProgressView("loading...")
                        case let .loaded(members):
                            if members.data.isEmpty {
                                Text("something wrong about API.")
                            } else {
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack {
                                        Text("1期生").foregroundColor(.purple).font(.headline).padding(.top, 10)
                                    // MARK: Main List about members
                                        MainList(members: fileteredMembers(members: members.data, cate: "1期生"))
                                    }
                                    Divider().opacity(0.3)
                                    VStack {
                                        Text("2期生").foregroundColor(.purple).font(.headline).padding(.top, 10)
                                    
                                    MainList(members: fileteredMembers(members: members.data, cate: "2期生"))
                                    }
                                    Divider().opacity(0.3)
                                    VStack {
                                        Text("3期生").foregroundColor(.purple).font(.headline).padding(.top, 10)
                                    MainList(members: fileteredMembers(members: members.data, cate: "3期生"))
                                    }
                                    Divider().opacity(0.3)
                                    VStack {
                                        Text("4期生").foregroundColor(.purple).font(.headline).padding(.top, 10)
                                    MainList(members: fileteredMembers(members: members.data, cate: "4期生"))
                                    }
                                    Divider().opacity(0.3)
                                    VStack {
                                        Text("5期生").foregroundColor(.purple).font(.headline).padding(.top, 10)
                                    MainList(members: fileteredMembers(members: members.data, cate: "5期生"))
                                    }
                                }
                            }
                        case let .failed(error):

                            Text(error.localizedDescription)
                        }
                    }
                    .navigationBarTitle("メンバー", displayMode: .inline)
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
    
    func fileteredMembers(members: [Member], cate: String) -> [Member] {
        let filteredMembers = members.filter {
            $0.cate.hasSuffix(cate)
        }
        return filteredMembers.sorted(by: {$0.kana < $1.kana})
    }
    
    func DoubleDivider(show: Bool = true) -> some View {
        VStack(spacing: 2) {
            Rectangle()
                .foregroundColor(Color.purple)
                .opacity((show ? 1 : 0))
                .frame(height: 2)
            Rectangle()
                .foregroundColor(Color.purple)
                .opacity((show ? 1 : 0))
                .frame(height: 2)
        }
    }
    
    func MainList(members: [Member]) -> some View {
            LazyVStack {
                ForEach((0..<GetRowNum(members: members)), id: \.self) { row in
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(0...2, id: \.self) { col in
                            if 3*row+col < members.count {
                                NavigationLink(
                                    destination: MemberDetailView(member: members[3*row+col])) {
                                        OnePerson(member: members[3*row+col], width: 100)
                                    }
                            } else {
                                Rectangle()
                                    .frame(width: 100)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func GetRowNum(members: [Member]) -> Int {
        let t = members.count / 3
        if members.count % 3 == 0 {
            return t
        } else {
            return t + 1
        }
    }
    
    func OnePerson(member: Member, width: CGFloat) -> some View {
        VStack(alignment: .center) {
            // MARK: Face Image
            AsyncImage(url: URL(string: member.img)) { image in
                image.resizable().scaledToFill().frame(width: 100, height: 120)
            } placeholder: {
                ProgressView().frame(width: 100, height: 120)
            }
            .cornerRadius(5)
            
            // MARK: Name
            Text(member.name)
                .foregroundColor(Color.purple)
                .font(.caption)
            Text(member.kana)
                .foregroundColor(Color(red: 0, green: 0, blue: 1))
                .font(.system(size: 8, weight: .regular))
                .padding(.bottom, 4.0)
                
        }
        .padding(2)
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        MemberListView()
    }
}
