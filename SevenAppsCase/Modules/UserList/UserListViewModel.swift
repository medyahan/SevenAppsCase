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
    private let repository: UsersRepositoryProtocol
    private var users: [User] = []
    private var filteredUsers: [User] = []
    
    // MARK: Callbacks (UI Güncellemeleri için)
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var onEmptyState: (() -> Void)?
    
    // MARK: Initialization
    init(repository: UsersRepositoryProtocol = UsersRepository()) {
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
                self.handleUIUpdate(isEmpty: users.isEmpty)
                
            case .failure(let error):
                self.handleError(error)
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
        
        handleUIUpdate(isEmpty: filteredUsers.isEmpty)
    }
    
    // MARK: Data Access
    func numberOfUsers() -> Int {
        return filteredUsers.count
    }
    
    func user(at index: Int) -> User {
        return filteredUsers[index]
    }
    
    // MARK: Helper Methods
    // Kullanıcı listesinin boş olup olmadığını kontrol ederek UI güncellemelerini kontrol eder
    private func handleUIUpdate(isEmpty: Bool) {
        DispatchQueue.main.async {
            isEmpty ? self.onEmptyState?() : self.onDataUpdated?()
        }
    }
    
    // Ağa bağlı hatalarını UI'ya hata mesajı döndürür
    private func handleError(_ error: NetworkError) {
        DispatchQueue.main.async {
            self.onError?(error.localizedDescription)
        }
    }
}
