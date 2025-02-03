//
//  UserService.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

class UserService {
    
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        APIService.shared.fetchData(from: .users, completion: completion)
    }
    
    func fetchUserDetail(id: Int, completion: @escaping (Result<User, NetworkError>) -> Void) {
        APIService.shared.fetchData(from: .userDetail(id: id), completion: completion)
    }
}
