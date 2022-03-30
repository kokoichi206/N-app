//
//  ScheduleViewModel.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/27.
//

import Foundation
import Combine

class ScheduleListViewModel: ObservableObject {
    @Published private(set) var scheduleList: Stateful<ScheduleList> = .idle

    private var cancellables = Set<AnyCancellable>()

    func onAppear() {
        loadSchedules()
    }

    func onRetryButtonTapped() {
        loadSchedules()
    }

    private func loadSchedules() {
        ScheduleRepository().fetchSchedules()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.scheduleList = .loading
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    self?.scheduleList = .failed(error)
                case .finished: print("Finished")
                }
            }, receiveValue: { [weak self] schedules in
                self?.scheduleList = .loaded(schedules)
            }
            ).store(in: &cancellables)
    }
}

