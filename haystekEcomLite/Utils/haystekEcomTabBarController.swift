//
//  haystekEcomTabBarController.swift
//  haystekEcomLite
//
//  Created by Sandeep on 23/08/25.
//

import UIKit

class haystekEcomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let catalogVC = UINavigationController(rootViewController: CatalogViewController())
        catalogVC.tabBarItem = UITabBarItem(title: "Catalog", image: UIImage(systemName: "square.grid.2x2"), tag: 1)
        
        let cartVC = UINavigationController(rootViewController: CartViewController())
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 2)
        
        let favoritesVC = UINavigationController(rootViewController: FavouritesViewController())
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 3)
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 4)
        
        self.viewControllers = [homeVC, catalogVC, cartVC, favoritesVC, profileVC]
        self.tabBar.unselectedItemTintColor = UIColor.gray
        self.tabBar.tintColor = .systemGreen
    }
}
