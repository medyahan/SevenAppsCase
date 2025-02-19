//
//  UserDetailsViewModel.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

class UserDetailsViewModel {
    
    // MARK: Properties
    private let repository: UserDetailRepositoryProtocol
    private let userId: Int
    
    var user: User?
    
    // MARK: Callbacks
    var onUserUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var onEmptyState: (() -> Void)?

    // MARK: Initialization
    init(repository: UserDetailRepositoryProtocol = UserDetailRepository(), userId: Int) {
        self.repository = repository
        self.userId = userId
    }
    
    // MARK: Fetch User Details
    func fetchUserDetails() {
        repository.getUserDetail(id: userId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.user = user
                DispatchQueue.main.async {
                    self.onUserUpdated?()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }
}

