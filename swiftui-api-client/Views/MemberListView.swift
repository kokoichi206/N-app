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
        appearance.backgroundColor = .purple
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        
        
//        NavigationView {
//            Group {
//                switch viewModel.members {
//                case .idle, .loading:
//                    ProgressView("loading...")
//                case .failed:
//                    VStack {
//                        Group {
//                            Image("GitHubMark")
//                            Text("Failed to load members")
//                                .padding(.top, 4)
//                        }
//                        .foregroundColor(.black)
//                        .opacity(0.4)
//                        Button(
//                            action: {
//                                viewModel.onRetryButtonTapped() // リトライボタンをタップしたときに再度リクエストを投げる
//                            },
//                            label: {
//                                Text("Retry")
//                                    .fontWeight(.bold)
//                            }
//                        )
//                            .padding(.top, 8)
//                    }
//                case let .loaded(members):
//                    if members.isEmpty {
//                        Text("No members")
//                            .fontWeight(.bold)
//                    } else {
//                        List(members) { member in
//                            if (member.graduation == "NO" && member.id != "10001") {
//                            NavigationLink(
//                                destination: MemberDetailView(member: member)) {
//                                    MemberRow(member: member)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle("メンバー", displayMode: .inline)
//        }
//        .onAppear {
//            viewModel.onAppear()
//        }
        
        VStack(alignment: .leading, spacing: 8) {
            NavigationView {
                Group {
                    switch viewModel.members {
                    case .idle, .loading:
                        ProgressView("loading...")
                    case let .loaded(members):
                        if members.isEmpty {
                            Text("something wrong about API.")
                        } else {
                            
                            // MARK: Main List about members
                            MainList(members: members)
                        }
                    case let .failed(error):

                        Text(error.localizedDescription)
                    }
                }
                .navigationBarTitle("メンバー", displayMode: .inline)
            }
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
    
    func DoubleDivider(show: Bool = true) -> some View {
        VStack(spacing: 2) {
            Rectangle()
                .padding(0)
                .foregroundColor(Color.purple)
                .opacity((show ? 1 : 0))
                .frame(height: 2)
            Rectangle()
                .padding(0)
                .foregroundColor(Color.purple)
                .opacity((show ? 1 : 0))
                .frame(height: 2)
        }
    }
    
    func MainList(members: [Member]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            let width: CGFloat = 100
            LazyVStack {
                ForEach((0..<GetRowNum(members: members)), id: \.self) { row in
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(0...2, id: \.self) { col in
                            if 3*row+col < members.count {
                                NavigationLink(
                                    destination: MemberDetailView(member: members[3*row+col])) {
                                        OnePerson(member: members[3*row+col], width: width)
                                    }
                            } else {
                                Rectangle()
                                    .frame(width: width)
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 4)
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
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 120)
            .aspectRatio(contentMode: .fill)
            
            // MARK: Name
            Text(member.name)
                .foregroundColor(Color.purple)
                .padding(.vertical, 4)
                
                
        }
        .padding(2)
    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        MemberListView()
    }
}
