//
//  CustomNavigationController.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarAppearance()
    }
    
    // Navigasyon barın görünümünü yapılandırır
    private func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground() // Arka planı opak hale getirir
        appearance.backgroundColor = .white // Arka plan rengini değiştirir
        
        // Başlık yazısı stilini ayarlar
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIStyleManager.Fonts.title,
            NSAttributedString.Key.foregroundColor: UIStyleManager.Colors.primaryDarker
        ]
        
        // Özel geri butonu görüntüsünü ayarlar
        if let backImage = UIImage(named: "arrow-left") {
            appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        }
        
        // Tüm görünüm stillerine bu ayarları uygular
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.tintColor = UIStyleManager.Colors.primaryDarker // Geri butonu ve diğer ikonların rengini belirler
    }
    
    // Yeni bir ViewController push edildiğinde 'Geri' butonunu yazısını günceller
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        topViewController?.navigationItem.backButtonTitle = "Geri"
        super.pushViewController(viewController, animated: animated)
    }
}
