//
//  ScheduleViewModel.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/27.
//

import Foundation
import Combine

struct ScheduleRepository {
    func fetchSchedules() -> AnyPublisher<ScheduleList, Error> {
        ScheduleAPIClient().getSchedules()
    }
}

