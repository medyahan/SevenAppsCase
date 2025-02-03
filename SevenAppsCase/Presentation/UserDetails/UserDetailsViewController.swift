//
//  UserDetailsViewController.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    var userId: Int?
    private let viewModel = UserDetailsViewModel()
    
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
        if let userId = userId {
            viewModel.fetchUserDetails(userId: userId)
        } else {
            showErrorAlert(message: "Invalid User ID")
        }
    }
    
    // MARK: Bindings
    private func setupBindings() {
        viewModel.onUserUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.configureContent()
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
    
    private func setupUI() {
        view.backgroundColor = .white
        self.navigationItem.title = "User Details"
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }
    
    private func configureContent() {
        guard let user = viewModel.user else { return }
        
        let userInfoCardView = UserInfoCardView()
            userInfoCardView.configure(with: user)
        
        contentStackView.addArrangedSubview(userInfoCardView)
        contentStackView.addArrangedSubview(UserDetailCardView(title: "Address", details: [
            "Street: \(user.address.street)",
            "Suite: \(user.address.suite)",
            "City: \(user.address.city)",
            "Zipcode: \(user.address.zipcode)"
        ], icon: "location"))

        contentStackView.addArrangedSubview(UserDetailCardView(title: "Company", details: [
            "Name: \(user.company.name)",
            "Catchphrase: \(user.company.catchPhrase)",
            "Business: \(user.company.bs)"
        ], icon: "work"))
    }
    
    // MARK: - Error & Empty States
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showEmptyState() {
        let emptyLabel = UILabel()
        emptyLabel.text = "No user data available"
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = .gray
        contentStackView.addArrangedSubview(emptyLabel)
    }
}
