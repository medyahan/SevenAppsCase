//
//  UserDetailRepository.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

// Repository Pattern uygulamak için kullanılan yapı

protocol UserDetailRepositoryProtocol {
    func getUserDetail(id: Int, completion: @escaping (Result<User, NetworkError>) -> Void)
}

class UserDetailRepository: UserDetailRepositoryProtocol {
    
    private let userService: UserService
    
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    func getUserDetail(id: Int, completion: @escaping (Result<User, NetworkError>) -> Void) {
        userService.fetchUserDetail(id: id) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
