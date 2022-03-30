//
//  LiveRepository.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import Combine

struct LiveRepository {
    func fetchLives() -> AnyPublisher<LiveList, Error> {
        LiveAPIClient().getLives()
    }
}
