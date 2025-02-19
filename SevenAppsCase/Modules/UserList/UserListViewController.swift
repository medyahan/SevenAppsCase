//
//  UserListViewController.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

class UserListViewController: UIViewController {
    
    // MARK: Constants
    private struct Constants {
        static let resultText = "Results Found"
        static let emptyResultText = "No Results Found"
        static let userCellIdentifier = "UserCell"
        static let userListScreenNib = "UserListScreen"
        static let navigationTitle = "User List"
    }
    
    // MARK: UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var searchBarView: CustomSearchBarView = {
        let searchBar = CustomSearchBarView()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var resultsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIStyleManager.Fonts.description.withSize(12)
        label.textColor = UIStyleManager.Colors.neutral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Properties
    private let viewModel: UserListViewModel
    
    // MARK: Initialization
    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: Constants.userListScreenNib, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings() // ViewModel ile bağlantılar kurulur
        viewModel.fetchUsers() // Kullanıcıları çek
    }
    
    // MARK: Setup UI
    private func setupUI() {
        self.navigationItem.title = Constants.navigationTitle
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBarView)
        view.addSubview(resultsLabel)
        
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            resultsLabel.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 8),
            resultsLabel.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor),
            resultsLabel.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor)
        ])
        
        resultsLabel.text = "0 \(Constants.resultText)"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.userCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.userCellIdentifier)
        tableView.separatorStyle = .none // Satır ayırıcılar kaldırılır
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: resultsLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: ViewModel Bindings
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.hideEmptyState()
                self?.updateResultsLabel()
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: errorMessage)
            }
        }
        
        viewModel.onEmptyState = { [weak self] in
            DispatchQueue.main.async {
                self?.showEmptyState()
            }
        }
    }
    
    // MARK: UI Updates
    private func updateResultsLabel() {
        let rowCount = viewModel.numberOfUsers()
        resultsLabel.text = "\(rowCount) \(Constants.resultText)"
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    private func showEmptyState() {
        resultsLabel.text = Constants.emptyResultText
        tableView.isHidden = true
    }
    
    private func hideEmptyState() {
        tableView.isHidden = false
    }
}

// MARK: UITableView DataSource - Delegate
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userCellIdentifier, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        
        let user = viewModel.user(at: indexPath.row)
        cell.configure(with: user)
        cell.selectionStyle = .none // Seçim stili kaldırılır
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedUser = viewModel.user(at: indexPath.row)
        let userDetailVM = UserDetailsViewModel(userId: selectedUser.id) // Kullanıcı detayları için ViewModel oluşturulur
        let userDetailsVC = UserDetailsViewController(viewModel: userDetailVM)
        
        navigationController?.pushViewController(userDetailsVC, animated: true)
    }
}

// MARK: CustomSearchBarDelegate
extension UserListViewController: CustomSearchBarDelegate {
    func didUpdateSearchText(_ text: String) {
        viewModel.filterUsers(by: text) // Kullanıcı filtreleme işlemi
    }
}
