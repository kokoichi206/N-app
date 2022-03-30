//
//  MemberRepository.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/21.
//

import Foundation
import Combine

struct MemberRepository {
    func fetchMembers() -> AnyPublisher<MemberList, Error> {
        MemberAPIClient().getMembers()
    }
}

