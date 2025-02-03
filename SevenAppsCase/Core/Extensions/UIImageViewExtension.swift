//
//  UIImageViewExtension.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

extension UIImageView {
    
    // Uzaktan görsel yükleme işlemi gerçekleştirir ve önbelleği kullanır.
    func loadImage(
        from urlString: String,
        placeholder: UIImage? = UIImage(systemName: "person.crop.circle"),
        errorImage: UIImage? = UIImage(systemName: "exclamationmark.triangle")
    ) {
        self.image = placeholder // Başlangıçta placeholder görseli göster
        self.alpha = 0.5 // Geçiş efekti için opaklığı düşür

        ImageService.shared.loadImage(from: urlString) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let image):
                    self.image = image
                    UIView.animate(withDuration: 0.3) { self.alpha = 1.0 } // Yumuşak geçiş efekti
                    
                case .failure:
                    self.image = errorImage // Hata oluşursa hata görselini göster
                }
            }
        }
    }
}
