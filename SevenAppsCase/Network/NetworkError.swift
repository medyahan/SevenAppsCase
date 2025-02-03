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
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Geçersiz URL"
        case .noData:
            return "Veri bulunamadı"
        case .decodingError:
            return "Veri işlenirken hata oluştu"
        case .serverError(let statusCode):
            return "Sunucu hatası: \(statusCode)"
        }
    }
}
