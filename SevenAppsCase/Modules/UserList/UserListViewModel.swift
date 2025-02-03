//
//  UserListViewModel.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

// Kullanıcı listesini yöneten ViewModel (MVVM)
final class UserListViewModel {
    
    // MARK: Properties
    private let repository: UserRepositoryProtocol
    private var users: [User] = []
    private var filteredUsers: [User] = []
    
    // MARK: Callbacks (UI Güncellemeleri için)
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var onEmptyState: (() -> Void)?
    
    // MARK: Initialization
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    // MARK: Fetch Users (API'den Kullanıcıları Çek)
    func fetchUsers() {
        repository.getUsers { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                self.users = users
                self.filteredUsers = users
                
                DispatchQueue.main.async {
                    users.isEmpty ? self.onEmptyState?() : self.onDataUpdated?()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.onError?(self.getErrorMessage(error))
                }
            }
        }
    }
    
    // MARK: Filter Users (Arama İşlemi)
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
            self.filteredUsers.isEmpty ? self.onEmptyState?() : self.onDataUpdated?()
        }
    }
    
    // MARK: Data Access
    func numberOfUsers() -> Int {
        return filteredUsers.count
    }
    
    func user(at index: Int) -> User {
        return filteredUsers[index]
    }
    
    // MARK: Private Helper Methods
    // Network hatalarını daha anlaşılır bir mesaj haline getirir
    private func getErrorMessage(_ error: NetworkError) -> String {
        switch error {
        case .invalidURL:
            return "The requested URL is invalid."
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Failed to process server response."
        case .serverError(let statusCode):
            return "Server error: \(statusCode)"
        case .networkError(let message):
            return "Network error: \(message)"
        }
    }
}
