//
//  MovieRepository.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import Combine

struct MovieRepository {
    func fetchMovies() -> AnyPublisher<MovieList, Error> {
        MovieAPIClient().getMovies()
    }
}
