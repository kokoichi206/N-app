//
//  NewsViewModel.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import Combine

class NewsListViewModel: ObservableObject {
    @Published private(set) var newsList: Stateful<NewsList> = .idle

    private var cancellables = Set<AnyCancellable>()

    func onAppear() {
        loadNews()
    }

    func onRetryButtonTapped() {
        loadNews()
    }

    private func loadNews() {
        NewsRepository().fetchNewss()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.newsList = .loading
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    self?.newsList = .failed(error)
                case .finished: print("Finished")
                }
            }, receiveValue: { [weak self] newsList in
                self?.newsList = .loaded(newsList)
            }
            ).store(in: &cancellables)
    }
}
