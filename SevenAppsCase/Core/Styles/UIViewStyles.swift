//
//  UIViewStyles.swift
//  SevenAppsCase
//
//  Created by Medya Han on 4.02.2025.
//

import UIKit

extension UIView {
    
    // Kart görünümü uygular
    func applyCardStyle(cornerRadius: CGFloat = 8, shadowOpacity: Float = 0.07, shadowRadius: CGFloat = 8, borderColor: UIColor? = nil, borderWidth: CGFloat = 0) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = shadowRadius
        self.backgroundColor = .white
        self.clipsToBounds = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
        }
    }
    
    // Divider çizgisi stilini uygular
    func applyDividerStyle() {
        self.backgroundColor = UIStyleManager.Colors.neutralLight
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
