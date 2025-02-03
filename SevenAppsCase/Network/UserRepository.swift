//
//  UserRepository.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

protocol UserRepositoryProtocol {
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
    func getUserDetail(id: Int, completion: @escaping (Result<User, NetworkError>) -> Void)
}

class UserRepository: UserRepositoryProtocol {
    
    private let userService: UserService
    
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        userService.fetchUsers { result in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
