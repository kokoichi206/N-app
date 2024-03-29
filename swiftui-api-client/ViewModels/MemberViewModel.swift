//
//  MemberViewModel.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/21.
//

import Foundation
import Combine

class MemberListViewModel: ObservableObject {
    @Published private(set) var memberList: Stateful<MemberList> = .idle

    private var cancellables = Set<AnyCancellable>()

    func onAppear() {
        loadMembers()
    }

    func onRetryButtonTapped() {
        loadMembers()
    }

    private func loadMembers() {
        MemberRepository().fetchMembers()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.memberList = .loading
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    self?.memberList = .failed(error)
                case .finished: print("Finished")
                }
            }, receiveValue: { [weak self] members in
                self?.memberList = .loaded(members)
            }
            ).store(in: &cancellables)
    }
}

