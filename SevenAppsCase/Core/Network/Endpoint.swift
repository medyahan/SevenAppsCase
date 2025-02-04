//
//  Endpoint.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

// API adreslerini içeren yapı

enum Endpoint {
    case users
    case userDetail(id: Int)
    
    // API’nin base URL adresi
    private var baseURL: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    // Her case için belirlenen API path
    private var path: String {
        switch self {
        case .users:
            return "/users"
        case .userDetail(let id):
            return "/users/\(id)"
        }
    }
    
    // Tam URL adresini oluşturur
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    // Sorgu parametreleri ekleyerek URL oluşturan metod
    func url(with parameters: [String: String]) -> URL? {
        guard var components = URLComponents(string: baseURL + path) else { return nil }
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components.url
    }
}
