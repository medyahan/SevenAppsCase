//
//  UIExtensions.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

extension UIView {
    func applyCardStyle() {
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.07 // Gölgenin opaklık oranını azaltarak daha yumuşak görünmesini sağlar
        self.layer.shadowOffset = CGSize(width: 4, height: 4) // Gölgeyi sağa ve aşağıya kaydırır
        self.layer.shadowRadius = 8 // Gölgeyi yayar, keskinliğini azaltır
        self.backgroundColor = .white
        self.clipsToBounds = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyDividerStyle() {
        self.backgroundColor = .neutralLight
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyCircleStyle() {
        self.layer.cornerRadius = 4
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UILabel {
    func applyTitleStyle() {
        self.font = UIFont(name: "Poppins-SemiBold", size: 16)
        self.textColor = .secondary
        self.numberOfLines = 2 // Maksimum iki satır göster
        self.lineBreakMode = .byTruncatingTail // Uzun metinler için ... kullan
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applySubTitleStyle() {
        self.font = UIFont(name: "Poppins-SemiBold", size: 16)
        self.textColor = .secondary
        self.numberOfLines = 1 // Maksimum iki satır göster
        self.lineBreakMode = .byTruncatingTail // Uzun metinler için ... kullan
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyCellDescriptionStyle() {
        self.font = UIFont(name: "Poppins-Regular", size: 14)
        self.textColor = .neutral
        self.numberOfLines = 2
        self.lineBreakMode = .byTruncatingTail
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyDetailsDescriptionStyle() {
        self.font = UIFont(name: "Poppins-Regular", size: 14)
        self.textColor = .neutral
        self.numberOfLines = 0 // Sınırsız satır
        self.lineBreakMode = .byWordWrapping // Kelime bazlı sarma
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyAlertDescriptionStyle() {
        self.font = UIFont(name: "Poppins-Regular", size: 12)
        self.textColor = .neutral
        self.textAlignment = .center
        self.numberOfLines = 0 // Sınırsız satır
        self.lineBreakMode = .byWordWrapping // Kelime bazlı sarma
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyTagStyle() {
        self.font = UIFont(name: "Poppins-Regular", size: 12)
        self.textColor = .secondary
        self.backgroundColor = .primary
        self.textAlignment = .center
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyStatusStyle() {
        self.font = UIFont(name: "Poppins-Medium", size: 12)
        self.textColor = .neutral
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyIconStyle() {
        self.font = UIFont(name: "Poppins-Regular", size: 12)
        self.textColor = .neutral
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyTextFieldHeaderStyle() {
        self.font = UIFont(name: "Poppins-Medium", size: 14)
        self.textColor = .secondary
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIImageView {
    
    func loadImage(from urlString: String, placeholder: UIImage? = UIImage(systemName: "person.crop.circle")) {
        self.image = placeholder
        
        ImageService.shared.loadImage(from: urlString) { image in
            if let image = image {
                self.image = image
            }
        }
    }
    
    func applyProjectStyle() {
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyProfileStyle() {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = 25
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyTeamIconStyle() {
        self.image = UIImage(named: "profile")?.withRenderingMode(.alwaysTemplate)
        self.tintColor = .neutral
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyDurationIconStyle() {
        self.image = UIImage(named: "clock")?.withRenderingMode(.alwaysTemplate)
        self.tintColor = .neutral
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIProgressView {
    func applyStyle() {
        self.progressTintColor = .primary
        self.trackTintColor = .neutral
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIButton {
    func applyMainStyle() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .primary
        self.setTitleColor(.secondary, for: .normal)
        self.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
        self.layer.cornerRadius = 8
    }
    
    func applyDestructiveStyle() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.secondary.cgColor
        self.layer.borderWidth = 1
        self.setTitleColor(.secondary, for: .normal)
        self.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
    }
    
    func applySecondaryStyle() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .secondary
        self.setTitleColor(.primary, for: .normal)
        self.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
        self.layer.cornerRadius = 8
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        return ceil(boundingBox.height)
    }
}

extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
}
