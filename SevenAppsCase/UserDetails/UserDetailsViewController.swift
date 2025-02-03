//
//  UserDetailsViewController.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    var user: User?
    
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard user != nil else {
            print("Hata: Kullanıcı verisi bulunamadı!")
            return
        }
        
        self.navigationItem.title = "User Details"
        setupUI()
        configureContent()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
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
        guard let user = user else { return }
        
        // **Profil Resmi ve Kullanıcı Bilgileri**
        let userInfoView = createUserInfoView(user: user)
        contentStackView.addArrangedSubview(userInfoView)
        
        // **Adres Bilgisi Bölümü**
        let addressView = createAddressView(address: user.address)
        contentStackView.addArrangedSubview(addressView)
        
        // **Şirket Bilgisi Bölümü**
        let companyView = createCompanyView(company: user.company)
        contentStackView.addArrangedSubview(companyView)
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
        
        // **Profil Resmi ve Kullanıcı Bilgileri (Yan Yana)**
        let profileStackView = UIStackView()
        profileStackView.axis = .horizontal
        profileStackView.spacing = 16
        profileStackView.alignment = .center
        
        let profileImageView = UIImageView()
        profileImageView.applyProfileStyle()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 40 // Yuvarlak yap
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // **Avatar Yükleme (Asenkron)**
        if let url = URL(string: user.avatarURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        profileImageView.image = image
                    }
                }
            }
        } else {
            profileImageView.image = UIImage(systemName: "person.crop.circle.fill") // Varsayılan ikon
        }
        
        let nameUsernameStack = UIStackView()
        nameUsernameStack.axis = .vertical
        nameUsernameStack.spacing = 4
        
        let nameLabel = createLabel(text: user.name, isTitle: true)
        let usernameLabel = createLabel(text: "@\(user.username)")
        
        nameUsernameStack.addArrangedSubview(nameLabel)
        nameUsernameStack.addArrangedSubview(usernameLabel)
        
        profileStackView.addArrangedSubview(profileImageView) // Profil Resmi Sola
        profileStackView.addArrangedSubview(nameUsernameStack) // Ad ve Username Sağa
        
        stackView.addArrangedSubview(profileStackView)
        
        // **Divider Ekleyelim**
        stackView.addArrangedSubview(createDivider())
        
        // **İletişim Bilgileri (Alt Alta)**
        let emailRow = createIconTextRow(icon: "mail", text: user.email)
        let phoneRow = createIconTextRow(icon: "call", text: user.phone)
        let websiteRow = createIconTextRow(icon: "discover", text: user.website)
        
        stackView.addArrangedSubview(emailRow)
        stackView.addArrangedSubview(phoneRow)
        stackView.addArrangedSubview(websiteRow)
        
        return container
    }
    
    // **📌 Adres Bilgileri Bölümü (Başlıkta İkon ve Noktalı Liste)**
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
        
        // **Başlık + İkon**
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
        
        // **Adres Bilgileri**
        stackView.addArrangedSubview(createLabel(text: "• Street: \(address.street)"))
        stackView.addArrangedSubview(createLabel(text: "• Suite: \(address.suite)"))
        stackView.addArrangedSubview(createLabel(text: "• City: \(address.city)"))
        stackView.addArrangedSubview(createLabel(text: "• Zipcode: \(address.zipcode)"))
        
        return container
    }
    
    // **📌 Şirket Bilgileri Bölümü (Başlıkta İkon ve Noktalı Liste)**
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
        
        // **Başlık + İkon**
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
        
        // **Şirket Bilgileri**
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
}
