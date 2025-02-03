//
//  APIService.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

// Ağ isteklerini yöneten ana servis
protocol APIServiceProtocol {
    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class APIService: APIServiceProtocol {
    
    static let shared = APIService() // Singleton olarak kullanılıyor
    private let urlSession: URLSession // Test edilebilirlik için
    
    private init(session: URLSession = .shared) {
        self.urlSession = session
    }
    
    // Api'den veri çeker
    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = urlSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                completion(.failure(.networkError(message: error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.serverError(statusCode: 500)))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try self.decodeJSON(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(.decodingError(error.localizedDescription as! Error)))
            }
        }
        
        task.resume()
    }
    
    // JSON verisini decode eden fonksiyon
    private func decodeJSON<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase // API'den gelen snake case isimlendirmelerini camelCase'e çevirir
        return try decoder.decode(T.self, from: data)
    }
}
