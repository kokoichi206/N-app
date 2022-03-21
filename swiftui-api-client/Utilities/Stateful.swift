//
//  Stateful.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/21.
//

import Foundation

enum Stateful<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}
