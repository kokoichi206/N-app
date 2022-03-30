//
//  MovieAPIClient.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/30.
//

import Foundation
import Combine

struct MovieAPIClient {
    func getMovies() -> AnyPublisher<MovieList, Error> {
        let url = URL(string: "https://www.nogizaka46.com/s/n46/api/list/movie")!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/vnd.github.v3+json"
        ]

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return Data(String(decoding: element.data, as: UTF8.self).dropFirst(4).dropLast(2).utf8)
            }
            .decode(type: MovieList.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

