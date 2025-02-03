//
//  APIService.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

class APIService {
    
    static let shared = APIService() // Singleton
    private init() {} // Dışarıdan örnek oluşturulmasını önler
    
    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                completion(.failure(.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 500)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                print("JSON Decode Error: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
