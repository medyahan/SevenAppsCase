//
//  UILabelStyles.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

extension UILabel {
    
    // Başlık stili uygular
    func applyTitleStyle(fontSize: CGFloat = 18) {
        self.font = UIStyleManager.Fonts.title.withSize(fontSize)
        self.textColor = UIStyleManager.Colors.secondary
        self.numberOfLines = 2
        self.lineBreakMode = .byTruncatingTail
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Alt Başlık Stili
    func applySubTitleStyle(fontSize: CGFloat = 16) {
        self.font = UIStyleManager.Fonts.subtitle.withSize(fontSize)
        self.textColor = UIStyleManager.Colors.secondary
        self.numberOfLines = 1
        self.lineBreakMode = .byTruncatingTail
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Açıklama Stili
    func applyDescriptionStyle(fontSize: CGFloat = 14) {
        self.font = UIStyleManager.Fonts.description.withSize(fontSize)
        self.textColor = UIStyleManager.Colors.neutral
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
