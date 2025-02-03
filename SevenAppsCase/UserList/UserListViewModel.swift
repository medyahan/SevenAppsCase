//
//  UserListViewModel.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

class UserListViewModel {
    private var data: [User] = [] // API'den gelen tüm kullanıcılar
    private var filteredData: [User] = [] // Filtrelenmiş liste
    private var currentSearchText: String = ""
    
    var onDataUpdated: (() -> Void)? // UI'yi güncellemek için closure
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                var users = try JSONDecoder().decode([User].self, from: data)
                
                self.data = users
                self.filteredData = users // İlk başta tüm kullanıcıları göster
                
                DispatchQueue.main.async {
                    self.onDataUpdated?() // UI'yi güncellemek için callback tetikle
                }
            } catch {
                print("JSON Parsing Error: \(error)")
            }
        }.resume()
    }
    
    func filterData(by searchText: String) {
        currentSearchText = searchText.lowercased()
        
        guard !currentSearchText.isEmpty else {
            filteredData = data // Arama boşsa tüm kullanıcıları göster
            DispatchQueue.main.async { self.onDataUpdated?() }
            return
        }
        
        filteredData = data.filter { user in
            user.name.lowercased().contains(currentSearchText)
        }
        
        DispatchQueue.main.async {
            self.onDataUpdated?()
        }
    }
    
    func numberOfRows() -> Int {
        return filteredData.count
    }
    
    func user(at index: Int) -> User {
        return filteredData[index]
    }
}
