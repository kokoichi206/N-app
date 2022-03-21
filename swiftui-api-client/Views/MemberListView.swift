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
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.members {
                case .idle, .loading:
                    ProgressView("loading...")
                case .failed:
                    VStack {
                        Group {
                            Image("GitHubMark")
                            Text("Failed to load members")
                                .padding(.top, 4)
                        }
                        .foregroundColor(.black)
                        .opacity(0.4)
                        Button(
                            action: {
                                viewModel.onRetryButtonTapped() // リトライボタンをタップしたときに再度リクエストを投げる
                            },
                            label: {
                                Text("Retry")
                                    .fontWeight(.bold)
                            }
                        )
                            .padding(.top, 8)
                    }
                case let .loaded(members):
                    if members.isEmpty {
                        Text("No members")
                            .fontWeight(.bold)
                    } else {
                        List(members) { member in
                            if (member.graduation == "NO" && member.id != "10001") {
                            NavigationLink(
                                destination: MemberDetailView(member: member)) {
                                    MemberRow(member: member)
                                }
                            }
                        }
                        .navigationTitle("メンバー")
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        MemberListView()
    }
}
