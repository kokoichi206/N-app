//
//  BlogRepository.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/27.
//

import Foundation
import Combine

struct BlogRepository {
    func fetchBlogs() -> AnyPublisher<BlogList, Error> {
        BlogAPIClient().getBlogs()
    }
}

