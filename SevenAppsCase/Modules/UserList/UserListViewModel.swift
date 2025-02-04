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
    
    // MARK: Filter Users (Sadece isme göre arama)
    func filterUsers(by searchText: String) {
        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines) // Boşlukları temizle

        guard !trimmedText.isEmpty else {
            filteredUsers = users // Arama boşsa tüm kullanıcıları göster
            handleUIUpdate(isEmpty: filteredUsers.isEmpty) // UI güncellemesi
            return
        }

        // Sadece isim bazlı filtreleme yap
        filteredUsers = users.filter { user in
            user.name.localizedCaseInsensitiveContains(trimmedText) // Büyük/küçük harf duyarsız arama
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
