//
//  LiveViewModel.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import Combine

class LiveListViewModel: ObservableObject {
    @Published private(set) var liveList: Stateful<LiveList> = .idle

    private var cancellables = Set<AnyCancellable>()

    func onAppear() {
        loadLive()
    }

    func onRetryButtonTapped() {
        loadLive()
    }

    private func loadLive() {
        LiveRepository().fetchLives()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.liveList = .loading
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    self?.liveList = .failed(error)
                case .finished: print("Finished")
                }
            }, receiveValue: { [weak self] liveList in
                self?.liveList = .loaded(liveList)
            }
            ).store(in: &cancellables)
    }
}
