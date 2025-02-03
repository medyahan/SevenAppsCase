//
//  SplashViewController.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showUserListScreen()
        }
    }

    func showUserListScreen() {
        // UserListScreen.xib dosyasını yükle
        let userListViewController = UserListViewController(nibName: "UserListScreen", bundle: nil)
        let navigationController = CustomNavigationController(rootViewController: userListViewController)
        
        // Yeni ViewController'ı ana window'a geçirilir
        if let window = self.view.window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
