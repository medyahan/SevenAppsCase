//
//  NetworkError.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

// Ağ hatalarını yönetmek için kullanılan yapı
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case serverError(statusCode: Int)
    case networkError(message: String)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The requested URL is invalid."
        case .noData:
            return "No data received from the server."
        case .decodingError(let error):
            return "Data processing error: \(error.localizedDescription)"
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
        case .networkError(let message):
            return "Network error: \(message)"
        }
    }
}
