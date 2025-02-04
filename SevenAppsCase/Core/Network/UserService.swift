//
//  UserService.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

// Kullanıcı verileri ile ilgili API çağrılarını yöneten servis protokolü
protocol UserServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
    func fetchUserDetail(id: Int, completion: @escaping (Result<User, NetworkError>) -> Void)
}

final class UserService: UserServiceProtocol {
    
    private let apiService: APIServiceProtocol
    
    // API servisini dependency injection ile içeri alıyoruz
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    // API’den kullanıcı listesini çeker
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        apiService.fetchData(from: .users, completion: completion)
    }
    
    // Belirtilen kullanıcıya ait detayları çeker
    func fetchUserDetail(id: Int, completion: @escaping (Result<User, NetworkError>) -> Void) {
        apiService.fetchData(from: .userDetail(id: id), completion: completion)
    }
}
