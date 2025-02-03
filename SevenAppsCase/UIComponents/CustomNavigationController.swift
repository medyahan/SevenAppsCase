//
//  CustomNavigationController.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

class CustomNavigationController: UINavigationController {

    private let headerContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarAppearance()
    }
    
    private func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.secondary
        ]
        if let backImage = UIImage(named: "arrow-left") {
            appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        }
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.tintColor = .secondary // Geri ikonu rengi
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        topViewController?.navigationItem.backButtonTitle = "Geri"
        super.pushViewController(viewController, animated: animated)
    }
}
