//
//  ContentView.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/17.
//

import SwiftUI
import Combine

class MembersLoader: ObservableObject {
    @Published private(set) var members = [Member]()
    
    private var cancellables = Set<AnyCancellable>()
    
    func call() {
        let url = URL(string: "https://www.nogizaka46.com/s/n46/api/list/member")!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3864.0 Safari/537.36"
        ]

        let membersPublisher = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return Data(String(decoding: element.data, as: UTF8.self).dropFirst(25).dropLast(3).utf8)
            }
            .decode(type: [Member].self, decoder: JSONDecoder())
        membersPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print("Finished: \(completion)")
            }, receiveValue: { [weak self] members in
                self?.members = members
            }
            ).store(in: &cancellables)
    }
}

struct MemberListView: View {
    @StateObject private var membersLoader = MembersLoader()
    
    var body: some View {
        NavigationView {
            if membersLoader.members.isEmpty {
               ProgressView("loading...")
            } else {
                List(membersLoader.members) { member in
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
        .onAppear {
            membersLoader.call()
        }
    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        MemberListView()
    }
}

 
