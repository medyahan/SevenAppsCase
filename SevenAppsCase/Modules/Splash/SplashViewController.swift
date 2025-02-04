//
//  SplashViewController.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var logoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoLabel.font = UIStyleManager.Fonts.title.withSize(28)
        navigateToUserList()
    }
    
    private func navigateToUserList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showUserListScreen()
        }
    }
    
    private func showUserListScreen() {
        
        let userListVM = UserListViewModel() // UserListViewController için View Model oluşturulur
        let userListVC = UserListViewController(viewModel: userListVM) // UserListViewController, View Model ile initialize edilir
        
        // CustomNavigationController oluşturulur ve root'a UserListViewController kaydedilir
        let navigationController = CustomNavigationController(rootViewController: userListVC)

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
