//
//  NetworkError.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknown(Error)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Geçersiz URL."
        case .noData:
            return "Sunucudan veri alınamadı."
        case .decodingError:
            return "Veri işlenirken hata oluştu."
        case .serverError(let statusCode):
            return "Sunucu hatası: \(statusCode)"
        case .unknown(let error):
            return "Bilinmeyen hata: \(error.localizedDescription)"
        }
    }
}
