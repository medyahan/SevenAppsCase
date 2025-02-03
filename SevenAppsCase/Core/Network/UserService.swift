//
//  UserService.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

// Kullanıcı verileri ile ilgili API çağrılarını yöneten servis.
final class UserService {
    
    private let apiService: APIServiceProtocol
    
    // UserService sınıfını belirli bir APIService ile başlatır.
    // apiService: Kullanılacak API servisi (varsayılan: APIService.shared).
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    // API’den kullanıcı listesini çeker.
    // completion: API çağrısının sonucunu döndürür ([User] veya NetworkError).
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        apiService.fetchData(from: .users, completion: completion)
    }
    
    // Belirtilen kullanıcıya ait detayları çeker.
    // completion: API çağrısının sonucunu döndürür (User veya NetworkError).
    func fetchUserDetail(id: Int, completion: @escaping (Result<User, NetworkError>) -> Void) {
        apiService.fetchData(from: .userDetail(id: id), completion: completion)
    }
}
