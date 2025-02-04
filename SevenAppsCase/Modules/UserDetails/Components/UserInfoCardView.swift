//
//  UserInfoView.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

class UserInfoCardView: UIView {
    
    private let avatarSize: CGFloat = 80
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.applyAvatarStyle(size: avatarSize)
    
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(avatarSize)),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(avatarSize))
        ])
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.applyTitleStyle()
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.applyDescriptionStyle()
        label.textColor = UIStyleManager.Colors.primaryDarker
        return label
    }()
    
    // Kullanıcı bilgilerini gösterecek satırlar
    private let emailRow: UIStackView = UIStackView()
    private let phoneRow: UIStackView = UIStackView()
    private let websiteRow: UIStackView = UIStackView()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: Initialize
    
    init() {
        super.init(frame: .zero)
        applyCardStyle()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyCardStyle()
        setupUI()
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        let profileStack = UIStackView()
        profileStack.axis = .horizontal
        profileStack.spacing = 16
        profileStack.alignment = .center
        
        let nameUsernameStack = UIStackView()
        nameUsernameStack.axis = .vertical
        nameUsernameStack.spacing = 4
        
        nameUsernameStack.addArrangedSubview(nameLabel)
        nameUsernameStack.addArrangedSubview(usernameLabel)
        
        profileStack.addArrangedSubview(avatarImageView)
        profileStack.addArrangedSubview(nameUsernameStack)
        
        stackView.addArrangedSubview(profileStack)
        stackView.addArrangedSubview(createDivider())
        
        stackView.addArrangedSubview(emailRow)
        stackView.addArrangedSubview(phoneRow)
        stackView.addArrangedSubview(websiteRow)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with user: User) {
        nameLabel.text = user.name
        usernameLabel.text = "@\(user.username)"
        
        avatarImageView.loadImage(from: user.avatarURL)
        
        emailRow.arrangedSubviews.forEach { $0.removeFromSuperview() }
        phoneRow.arrangedSubviews.forEach { $0.removeFromSuperview() }
        websiteRow.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        emailRow.addArrangedSubview(createInfoRow(icon: "mail", text: user.email.lowercased()))
        phoneRow.addArrangedSubview(createInfoRow(icon: "call", text: user.phone))
        websiteRow.addArrangedSubview(createInfoRow(icon: "discover", text: user.website.lowercased()))
    }
    
    private func createDivider() -> UIView {
        let divider = UIView()
        divider.applyDividerStyle()
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
        return divider
    }
    
    // Kullanıcı bilgileri için satır oluşturur
    private func createInfoRow(icon: String, text: String) -> UIStackView {
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.spacing = 8
        rowStack.alignment = .center
        
        let iconImageView = UIImageView(image: UIImage(named: icon)?.withRenderingMode(.alwaysTemplate))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = UIStyleManager.Colors.neutral
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.applyDescriptionStyle()
        
        rowStack.addArrangedSubview(iconImageView)
        rowStack.addArrangedSubview(textLabel)
        
        return rowStack
    }
}
