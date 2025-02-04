//
//  UserDetailRepository.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

// Kullanıcı detaylarını çekmek için Repository Pattern uygulayan yapı

protocol UserDetailRepositoryProtocol {
    func getUserDetail(id: Int, completion: @escaping (Result<User, NetworkError>) -> Void)
}

class UserDetailRepository: UserDetailRepositoryProtocol {
    
    private let userService: UserServiceProtocol
    
    // Dependency Injection ile dışarıdan UserServiceProtocol alıyor
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func getUserDetail(id: Int, completion: @escaping (Result<User, NetworkError>) -> Void) {
        userService.fetchUserDetail(id: id, completion: completion)
    }
}
