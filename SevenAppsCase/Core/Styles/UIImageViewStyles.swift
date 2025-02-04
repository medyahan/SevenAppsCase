//
//  UIImageViewStyles.swift
//  SevenAppsCase
//
//  Created by Medya Han on 4.02.2025.
//

import UIKit

extension UIImageView {
    
    // Yuvarlak Avatar Stili Uygular
    func applyAvatarStyle(size: CGFloat = 50) {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.borderColor = UIStyleManager.Colors.neutralLight.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = size / 2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
