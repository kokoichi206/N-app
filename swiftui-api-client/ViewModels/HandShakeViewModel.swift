//
//  HandShakeViewModel.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import Combine

class HandShakeListViewModel: ObservableObject {
    @Published private(set) var handShakeList: Stateful<HandShakeList> = .idle

    private var cancellables = Set<AnyCancellable>()

    func onAppear() {
        loadHandShake()
    }

    func onRetryButtonTapped() {
        loadHandShake()
    }

    private func loadHandShake() {
        HandShakeRepository().fetchHandShakes()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.handShakeList = .loading
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    self?.handShakeList = .failed(error)
                case .finished: print("Finished")
                }
            }, receiveValue: { [weak self] handShakeList in
                self?.handShakeList = .loaded(handShakeList)
            }
            ).store(in: &cancellables)
    }
}
