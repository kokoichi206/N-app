//
//  BlogViewModel.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/27.
//

import Foundation
import Combine

class BlogListViewModel: ObservableObject {
    @Published private(set) var blogList: Stateful<BlogList> = .idle

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
                self?.blogList = .loading
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    self?.blogList = .failed(error)
                case .finished: print("Finished")
                }
            }, receiveValue: { [weak self] blogs in
                self?.blogList = .loaded(blogs)
            }
            ).store(in: &cancellables)
    }
}

