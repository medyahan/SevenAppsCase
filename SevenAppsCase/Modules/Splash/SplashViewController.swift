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
        navigateToUserList()
    }
    
    private func navigateToUserList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showUserListScreen()
        }
    }
    
    private func showUserListScreen() {
        
        let userListVM = UserListViewModel()
        let userListVC = UserListViewController(viewModel: userListVM)
        
        let navigationController = CustomNavigationController(rootViewController: userListVC)

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
