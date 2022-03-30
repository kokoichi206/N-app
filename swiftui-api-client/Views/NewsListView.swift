//
//  NewsListView.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = NewsListViewModel()
    
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
                        switch viewModel.newsList {
                        case .idle, .loading:
                            ProgressView("loading...")
                        case let .loaded(newsList):
                            if newsList.data.isEmpty {
                                Text("something wrong about API.")
                            } else {
                                
                                // MARK: Main List about newsList
                                MainList(newsList: SortedNewsList(newsList: newsList.data))

                            }
                        case let .failed(error):

                            Text(error.localizedDescription)
                        }
                    }
                    .navigationBarTitle("ニュース", displayMode: .inline)
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
    
    func MainList(newsList: [News]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach((0..<newsList.count), id: \.self) { index in
                    OnePerson(news: newsList[index])
                }
            }
            .padding(.top, 8)
        }
    }
    
    func SortedNewsList(newsList: [News]) -> [News] {
        newsList.sorted(by: { $0.date < $1.date})
    }

    func OnePerson(news: News) -> some View {
        ZStack {
            Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.1).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                    HStack {
                        Text(news.cate)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 10)
                            .foregroundColor(.white)
                            .font(.system(size: 10, weight: .bold))
                            .background(.orange)
                        Spacer()
                        Text(news.date)
                            .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.1))
                            .font(.system(size: 8, weight: .regular))
                    }
                    .padding(.all, 6)
                HStack {
                    Text(news.title)
                        .font(.caption)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.bottom, 8)
            }
            .padding(2)
        }
        .cornerRadius(4)
        .padding(.horizontal, 5)
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}
