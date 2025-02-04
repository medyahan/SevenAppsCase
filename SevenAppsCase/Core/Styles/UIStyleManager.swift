//
//  UIStyleManager.swift
//  SevenAppsCase
//
//  Created by Medya Han on 4.02.2025.
//

import UIKit

// UI Stil Yöneticisi
final class UIStyleManager {
    
    struct Colors {
        static let primary = UIColor.primary
        static let primaryDark = UIColor.primaryDark
        static let primaryDarker = UIColor.primaryDarker
        static let secondary = UIColor.secondary
        static let neutral = UIColor.neutral
        static let neutralLight = UIColor.neutralLight
    }
    
    struct Fonts {
        static let title = UIFont(name: "Poppins-SemiBold", size: 18) ?? UIFont.preferredFont(forTextStyle: .title2)
        static let subtitle = UIFont(name: "Poppins-SemiBold", size: 16) ?? UIFont.preferredFont(forTextStyle: .headline)
        static let description = UIFont(name: "Poppins-Regular", size: 14) ?? UIFont.preferredFont(forTextStyle: .body)
    }
}
