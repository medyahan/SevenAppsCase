//
//  UserCell.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

final class UserCell: UITableViewCell {
    
    private let avatarSize: CGFloat = 50
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.applyCardStyle()
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.applyAvatarStyle(size: avatarSize)
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.applyTitleStyle()
        return label
    }()
    
    private lazy var mailLabel: UILabel = {
        let label = UILabel()
        label.applyDescriptionStyle()
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow-right")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIStyleManager.Colors.neutral
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: Configuration
    // Kullanıcı bilgilerini hücreye aktarır
    func configure(with user: User) {
        nameLabel.text = user.name
        mailLabel.text = user.email.lowercased()
        avatarImageView.loadImage(from: user.avatarURL)
    }
    
    // MARK: Setup UI
    private func setupUI() {
        selectionStyle = .none // Hücre seçildiğinde seçim stilini engeller
        contentView.backgroundColor = .clear
        
        contentView.addSubview(cardView)
        [avatarImageView, nameLabel, mailLabel, arrowImageView].forEach { cardView.addSubview($0) }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        mailLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            avatarImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarSize),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -8),
            
            mailLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            mailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            mailLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -8),
            mailLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            
            arrowImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            arrowImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 16),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    // MARK: - Selection Style
    // Hücre seçildiğinde veya seçim kaldırıldığında çağrılır
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        updateCardBorder(isSelected: selected)
    }
    
    // Hücreye basılı tutulduğunda çağrılır
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        updateCardBorder(isSelected: highlighted)
    }
    
    // Kartın border'ını günceller
    private func updateCardBorder(isSelected: Bool) {
        cardView.layer.borderColor = isSelected ? UIStyleManager.Colors.primaryDark.cgColor : UIColor.clear.cgColor
        cardView.layer.borderWidth = isSelected ? 2 : 0
    }
}
