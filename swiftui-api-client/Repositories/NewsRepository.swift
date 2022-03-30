//
//  NewsRepository.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import Combine

struct NewsRepository {
    func fetchNewss() -> AnyPublisher<NewsList, Error> {
        NewsAPIClient().getNewsList()
    }
}
