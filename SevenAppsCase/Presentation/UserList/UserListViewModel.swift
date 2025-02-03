//
//  UserListViewModel.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

class UserListViewModel {
    
    // MARK: - Properties
    private let repository: UserRepositoryProtocol
    private var users: [User] = []
    private var filteredUsers: [User] = []
    
    // MARK: - Callbacks
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var onEmptyState: (() -> Void)?
    
    // MARK: - Initialization
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    // MARK: - Fetch Users
    func fetchUsers() {
        repository.getUsers { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                self.users = users
                self.filteredUsers = users
                
                DispatchQueue.main.async {
                    if users.isEmpty {
                        self.onEmptyState?() // Boş liste durumu
                    } else {
                        self.onDataUpdated?()
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.onError?(error.localizedDescription) // Hata mesajını UI’ye ilet
                }
            }
        }
    }
    
    // MARK: - Filter Users
    func filterUsers(by searchText: String) {
        guard !searchText.isEmpty else {
            filteredUsers = users
            onDataUpdated?()
            return
        }
        
        filteredUsers = users.filter { user in
            user.name.lowercased().contains(searchText.lowercased()) ||
            user.username.lowercased().contains(searchText.lowercased())
        }
        
        DispatchQueue.main.async {
            if self.filteredUsers.isEmpty {
                self.onEmptyState?()
            } else {
                self.onDataUpdated?()
            }
        }
    }
    
    // MARK: - Data Access
    func numberOfUsers() -> Int {
        return filteredUsers.count
    }
    
    func user(at index: Int) -> User {
        return filteredUsers[index]
    }
}
