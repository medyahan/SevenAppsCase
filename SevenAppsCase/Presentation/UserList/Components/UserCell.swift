//
//  UserCell.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

class UserCell: UITableViewCell {
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.applyCardStyle()
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.applyProfileStyle()
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.applySubTitleStyle()
        return label
    }()
    
    private lazy var mailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = .neutral
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow-right")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .neutral
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        changeContainerViewBorder(selected: selected)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        changeContainerViewBorder(selected: highlighted)
    }
    
    private func changeContainerViewBorder(selected: Bool) {
        if selected {
            cardView.layer.borderColor = UIColor.primaryDark.cgColor
            cardView.layer.borderWidth = 2
        } else {
            cardView.layer.borderColor = UIColor.clear.cgColor
            cardView.layer.borderWidth = 0
        }
    }
    
    private func setupViews() {
        contentView.backgroundColor = .clear
        contentView.addSubview(cardView)
        cardView.addSubview(profileImageView)
        cardView.addSubview(nameLabel)
        cardView.addSubview(mailLabel)
        cardView.addSubview(arrowImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Card View
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            // Profile Image
            profileImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            // Name Label
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -8),
            
            // Title and Skills Label
            mailLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            mailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            mailLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -8),
            mailLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            
            // Arrow Image
            arrowImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            arrowImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            arrowImageView.widthAnchor.constraint(equalToConstant: 16),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func configure(with user: User) {
        nameLabel.text = user.name
        mailLabel.text = user.email.lowercased()
        
        profileImageView.loadImage(from: user.avatarURL)
        profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
    }
    
}

