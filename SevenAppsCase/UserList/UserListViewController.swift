//
//  UserListViewController.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var searchBarView: CustomSearchBarView = {
        let searchBar = CustomSearchBarView()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    private let viewModel = UserListViewModel()
    
    private lazy var resultsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "Poppins-Regular", size: 8)
        label.textColor = .neutral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "User List"
        setupSearchBar()
        setupTableView()
        setupBindings()
        
        viewModel.fetchUsers() // Kullanıcıları çek
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBarView)
        view.addSubview(resultsLabel)
        
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBarView.heightAnchor.constraint(equalToConstant: 68),
            
            resultsLabel.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 4), // Daha küçük boşluk verdik
            resultsLabel.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor),
            resultsLabel.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor),
            resultsLabel.heightAnchor.constraint(equalToConstant: 20), // Sabit bir yükseklik verdik
            
            tableView.topAnchor.constraint(equalTo: resultsLabel.bottomAnchor, constant: 8)
        ])
        
        resultsLabel.text = "0 Sonuç Görüntülendi" // Boş görünmemesi için başlangıç değeri
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView) // Eğer eklenmediyse güvenceye al
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: resultsLabel.bottomAnchor, constant: 8), // resultsLabel'ın altına konumlandır
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateResultsLabel()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func updateResultsLabel() {
        let rowCount = viewModel.numberOfRows()
        resultsLabel.text = "\(rowCount) Sonuç Görüntülendi"
    }
}

// MARK: - UITableView DataSource & Delegate
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        
        let user = viewModel.user(at: indexPath.row)
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedUser = viewModel.user(at: indexPath.row)
        
        let userDetailsVC = UserDetailsViewController(nibName: "UserDetailsScreen", bundle: nil)
        
        userDetailsVC.user = selectedUser
        userDetailsVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(userDetailsVC, animated: true)
    }
}

// MARK: - CustomSearchBarDelegate
extension UserListViewController: CustomSearchBarDelegate {
    func didUpdateSearchText(_ text: String) {
        viewModel.filterData(by: text)
    }
}
