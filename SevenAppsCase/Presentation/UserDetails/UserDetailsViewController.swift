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
        
        contentStackView.addArrangedSubview(createUserInfoView(user: user))
        contentStackView.addArrangedSubview(createAddressView(address: user.address))
        contentStackView.addArrangedSubview(createCompanyView(company: user.company))
    }
    
    private func createUserInfoView(user: User) -> UIView {
        let container = UIView()
        container.applyCardStyle()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
        
        let profileStackView = UIStackView()
        profileStackView.axis = .horizontal
        profileStackView.spacing = 16
        profileStackView.alignment = .center
        
        let profileImageView = UIImageView()
        profileImageView.applyAvatarStyle()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 40
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // Asenkron Avatar Yükleme
        profileImageView.loadImage(from: user.avatarURL)
        
        let nameUsernameStack = UIStackView()
        nameUsernameStack.axis = .vertical
        nameUsernameStack.spacing = 4
        
        let nameLabel = createLabel(text: user.name, isTitle: true)
        let usernameLabel = createLabel(text: "@\(user.username)")
        
        nameUsernameStack.addArrangedSubview(nameLabel)
        nameUsernameStack.addArrangedSubview(usernameLabel)
        
        profileStackView.addArrangedSubview(profileImageView)
        profileStackView.addArrangedSubview(nameUsernameStack)
        
        stackView.addArrangedSubview(profileStackView)
        stackView.addArrangedSubview(createDivider())
        
        stackView.addArrangedSubview(createIconTextRow(icon: "mail", text: user.email.lowercased()))
        stackView.addArrangedSubview(createIconTextRow(icon: "call", text: user.phone))
        stackView.addArrangedSubview(createIconTextRow(icon: "discover", text: user.website.lowercased()))
        
        return container
    }
    
    private func createAddressView(address: Address) -> UIView {
        let container = UIView()
        container.applyCardStyle()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
        
        let titleStack = UIStackView()
        titleStack.axis = .horizontal
        titleStack.spacing = 8
        titleStack.alignment = .center
        
        let iconImageView = UIImageView(image: UIImage(named: "location")?.withRenderingMode(.alwaysTemplate))
        iconImageView.tintColor = .secondary
        iconImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let titleLabel = createLabel(text: "Address", isSubTitle: true)
        titleStack.addArrangedSubview(iconImageView)
        titleStack.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(titleStack)
        stackView.addArrangedSubview(createDivider())
        
        stackView.addArrangedSubview(createLabel(text: "• Street: \(address.street)"))
        stackView.addArrangedSubview(createLabel(text: "• Suite: \(address.suite)"))
        stackView.addArrangedSubview(createLabel(text: "• City: \(address.city)"))
        stackView.addArrangedSubview(createLabel(text: "• Zipcode: \(address.zipcode)"))
        
        return container
    }
    
    private func createCompanyView(company: Company) -> UIView {
        let container = UIView()
        container.applyCardStyle()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
        
        let titleStack = UIStackView()
        titleStack.axis = .horizontal
        titleStack.spacing = 8
        titleStack.alignment = .center
        
        let iconImageView = UIImageView(image: UIImage(named: "work")?.withRenderingMode(.alwaysTemplate))
        iconImageView.tintColor = .secondary
        iconImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let titleLabel = createLabel(text: "Company", isSubTitle: true)
        titleStack.addArrangedSubview(iconImageView)
        titleStack.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(titleStack)
        stackView.addArrangedSubview(createDivider())
        
        stackView.addArrangedSubview(createLabel(text: "• Name: \(company.name)"))
        stackView.addArrangedSubview(createLabel(text: "• Catchphrase: \(company.catchPhrase)"))
        stackView.addArrangedSubview(createLabel(text: "• Business: \(company.bs)"))
        
        return container
    }
    
    
    private func createDivider() -> UIView {
        let divider = UIView()
        divider.applyDividerStyle()
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
        return divider
    }
    
    private func createIconTextRow(icon: String, text: String) -> UIStackView {
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.spacing = 8
        rowStack.alignment = .center
        
        let iconImageView = UIImageView(image: UIImage(named: icon)?.withRenderingMode(.alwaysTemplate))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .neutral
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let textLabel = createLabel(text: text)
        
        rowStack.addArrangedSubview(iconImageView)
        rowStack.addArrangedSubview(textLabel)
        
        return rowStack
    }
    
    private func createLabel(text: String, isSubTitle: Bool = false, isTitle: Bool = false) -> UILabel {
        let label = UILabel()
        label.text = text
        if isSubTitle {
            label.applySubTitleStyle()
        } else if isTitle {
            label.applyTitleStyle()
        } else {
            label.applyDetailsDescriptionStyle()
        }
        return label
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
