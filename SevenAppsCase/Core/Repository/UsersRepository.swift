//
//  UserRepository.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

// Repository Pattern uygulamak için kullanıcıları çekmek için kullanılan ara katman

protocol UsersRepositoryProtocol {
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

final class UsersRepository: UsersRepositoryProtocol {
    
    private let userService: UserServiceProtocol
    
    // UserServiceProtocol kullanarak Dependency Inversion yapıyoruz
    init(userService: UserServiceProtocol = UserService()) { 
        self.userService = userService
    }
    
    // API’den kullanıcıları çeker
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        userService.fetchUsers(completion: completion)
    }
}
