//
//  BlogViewModel.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/27.
//

import Foundation
import Combine

class BlogListViewModel: ObservableObject {
    @Published private(set) var blogs: Stateful<[Blog]> = .idle

    private var cancellables = Set<AnyCancellable>()

    func onAppear() {
        loadBlogs()
    }

    func onRetryButtonTapped() {
        loadBlogs()
    }

    private func loadBlogs() {
        BlogRepository().fetchBlogs()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.blogs = .loading
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    self?.blogs = .failed(error)
                case .finished: print("Finished")
                }
            }, receiveValue: { [weak self] blogs in
                self?.blogs = .loaded(blogs)
            }
            ).store(in: &cancellables)
    }
}

