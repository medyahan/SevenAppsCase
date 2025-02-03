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
        self.layer.shadowOpacity = 0.07
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 8
        self.backgroundColor = .white
        self.clipsToBounds = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyDividerStyle() {
        self.backgroundColor = .neutralLight
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UILabel {
    func applyTitleStyle() {
        self.font = UIFont(name: "Poppins-SemiBold", size: 18)
        self.textColor = .secondary
        self.numberOfLines = 2
        self.lineBreakMode = .byTruncatingTail
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applySubTitleStyle() {
        self.font = UIFont(name: "Poppins-SemiBold", size: 16)
        self.textColor = .secondary
        self.numberOfLines = 1
        self.lineBreakMode = .byTruncatingTail
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyDescriptionStyle() {
        self.font = UIFont(name: "Poppins-Regular", size: 14)
        self.textColor = .neutral
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyAlertDescriptionStyle() {
        self.font = UIFont(name: "Poppins-Regular", size: 12)
        self.textColor = .neutral
        self.textAlignment = .center
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping 
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
    
    func applyAvatarStyle(size: CGFloat) {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = size / 2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
