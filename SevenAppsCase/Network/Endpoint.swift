//
//  Endpoint.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

enum Endpoint {
    case users
    case userDetail(id: Int)
    
    var url: URL? {
        switch self {
        case .users:
            return URL(string: "https://jsonplaceholder.typicode.com/users")
        case .userDetail(let id):
            return URL(string: "https://jsonplaceholder.typicode.com/users/\(id)")
        }
    }
}
