//
//  HandShakeRepository.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import Combine

struct HandShakeRepository {
    func fetchHandShakes() -> AnyPublisher<HandShakeList, Error> {
        HandShakeAPIClient().getHandShakes()
    }
}
