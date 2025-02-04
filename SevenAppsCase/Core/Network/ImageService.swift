//
//  ImageService.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

// Resim yükleme ve önbellekleme işlemleri için servis protokolü
protocol ImageServiceProtocol {
    func loadImage(from urlString: String, completion: @escaping (Result<UIImage, ImageError>) -> Void)
}

// Ağ üzerinden resim yükleme ve önbellekleme servisi
final class ImageService: ImageServiceProtocol {
    
    static let shared = ImageService() // Singleton olarak kullanılıyor
    private let cache = NSCache<NSString, UIImage>() // Bellek önbelleği
    
    private init() {}
    
    // URL'den resmi yükler ve önbelleğe alır
    func loadImage(from urlString: String, completion: @escaping (Result<UIImage, ImageError>) -> Void) {
        // Önbellekte varsa doğrudan döndür
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(.success(cachedImage))
            return
        }
        
        // Geçersiz URL kontrolü
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Aynı URL için tekrar tekrar yükleme yapmayı engeller
        if let _ = cache.object(forKey: "\(urlString)-loading" as NSString) {
            return
        }
        cache.setObject(UIImage(), forKey: "\(urlString)-loading" as NSString)
        
        // URL'den resmi yükleme işlemi
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            // Ağ hatası kontrolü
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            // Geçersiz veri kontrolü
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(.invalidData))
                return
            }
            
            // Resmi önbelleğe kaydetme işlemi
            self.cache.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }.resume()
    }
}

// Resim yükleme hataları yönetilir
enum ImageError: Error {
    case invalidURL
    case networkError(String)
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The image URL is invalid."
        case .networkError(let message):
            return "Network error: \(message)"
        case .invalidData:
            return "Failed to load image data."
        }
    }
}
