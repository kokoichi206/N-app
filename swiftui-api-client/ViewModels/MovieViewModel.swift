//
//  MovieViewModel.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published private(set) var movieList: Stateful<MovieList> = .idle

    private var cancellables = Set<AnyCancellable>()

    func onAppear() {
        loadMovie()
    }

    func onRetryButtonTapped() {
        loadMovie()
    }

    private func loadMovie() {
        MovieRepository().fetchMovies()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.movieList = .loading
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    self?.movieList = .failed(error)
                case .finished: print("Finished")
                }
            }, receiveValue: { [weak self] movieList in
                self?.movieList = .loaded(movieList)
            }
            ).store(in: &cancellables)
    }
}
