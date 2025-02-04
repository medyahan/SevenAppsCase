//
//  UserDetailsViewController.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

final class UserDetailsViewController: UIViewController {
    
    // MARK: Constants
    
    struct Constants {
        static let addressTitle = "Address"
        static let streetText = "Street:"
        static let suiteText = "Suite:"
        static let cityText = "City:"
        static let zipCodeText = "Zipcode:"
        static let locationIcon = "location"
        
        static let companyTitle = "Company"
        static let companyNameText = "Name:"
        static let catchphraseText = "Catchphrase:"
        static let businessText = "Business:"
        static let workIcon = "work"
        
        static let errorTitle = "Error"
        static let okText = "OK"
        static let noUserDataText = "No user data available"
    }
    
    // MARK: Properties
    
    private let viewModel: UserDetailsViewModel
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    
    // MARK: Initializa
    
    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "UserDetailsScreen", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        viewModel.fetchUserDetails() // Kullanıcı detaylarını getir
    }
    
    // MARK: Bindings
    
    // ViewModel ile UI arasındaki bağlantıları kurar
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
    
    // MARK: UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "User Details"
        
        setupScrollView()
        setupContentStackView()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupContentStackView() {
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
    
    // MARK: Configuration
    
    // Kullanıcı detaylarını gösterir
    private func configureContent() {
        guard let user = viewModel.user else { return }
        
        // Kullanıcı Bilgileri Kartı
        let userInfoCardView = UserInfoCardView()
        userInfoCardView.configure(with: user)
        contentStackView.addArrangedSubview(userInfoCardView)
        
        // Adres Bilgileri Kartı
        contentStackView.addArrangedSubview(UserDetailCardView(title: Constants.addressTitle, details: [
            "\(Constants.streetText) \(user.address.street)",
            "\(Constants.suiteText) \(user.address.suite)",
            "\(Constants.cityText) \(user.address.city)",
            "\(Constants.zipCodeText) \(user.address.zipCode)"
        ], icon: Constants.locationIcon))
        
        // Şirket Bilgileri Kartı
        contentStackView.addArrangedSubview(UserDetailCardView(title: Constants.companyTitle, details: [
            "\(Constants.companyNameText) \(user.company.name)",
            "\(Constants.catchphraseText) \(user.company.catchPhrase)",
            "\(Constants.businessText) \(user.company.businessType)"
        ], icon: Constants.workIcon))
    }
    
    // MARK: Error - Empty States
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: Constants.errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.okText, style: .default))
        present(alert, animated: true)
    }
    
    // Kullanıcı bilgisi bulunamazsa boş ekran mesajı gösterir
    private func showEmptyState() {
        let emptyLabel = UILabel()
        emptyLabel.text = Constants.noUserDataText
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = UIStyleManager.Colors.neutral
        contentStackView.addArrangedSubview(emptyLabel)
    }
}
