//
//  LiveListView.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/31.
//

import SwiftUI
import Combine
 
struct LiveListView: View {
    @StateObject private var viewModel = LiveListViewModel()
    
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
                        switch viewModel.liveList {
                        case .idle, .loading:
                            ProgressView("loading...")
                        case let .loaded(lives):
                            if lives.data.isEmpty {
                                Text("something wrong about API.")
                            } else {
                                
                                // MARK: Main List about lives
                                MainList(lives: lives.data)

                            }
                        case let .failed(error):

                            Text(error.localizedDescription)
                        }
                    }
                    .navigationBarTitle("ライブ", displayMode: .inline)
                }
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
    
    func MainList(lives: [Live]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            let width: CGFloat = 100
            LazyVStack {
                ForEach((0..<GetRowNum(lives: lives)), id: \.self) { row in
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(0...2, id: \.self) { col in
                            if 3*row+col < lives.count {
//                                NavigationLink(
//                                    destination: LiveDetailView(live: lives[3*row+col])) {
                                        OnePerson(live: lives[3*row+col], width: width)
//                                    }
                            } else {
                                Rectangle()
                                    .frame(width: width)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }
    
    func GetRowNum(lives: [Live]) -> Int {
        let t = lives.count / 3
        if lives.count % 3 == 0 {
            return t
        } else {
            return t + 1
        }
    }
    
    func OnePerson(live: Live, width: CGFloat) -> some View {
        VStack(alignment: .center) {
            // MARK: Face Image
            AsyncImage(url: URL(string: live.img)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Image("n46").resizable().scaledToFill()
            }
            .frame(width: 100, height: 100)
            .cornerRadius(3)

            
            // MARK: Name
            Text(live.title)
                .foregroundColor(Color(red: 0.5, green: 0.1, blue: 0.5, opacity: 0.9))
                .font(.system(size: 10, weight: .regular))
                .padding(.bottom, 00.5)
            Text(live.date.dropLast(3))
                .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.5))
                .font(.system(size: 11, weight: .regular))
                .padding(.bottom, 5.0)
                
        }
        .padding(2)
    }
}

struct LiveListView_Previews: PreviewProvider {
    static var previews: some View {
        LiveListView()
    }
}
