//
//  TabBarProvider.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

class TabBarProvider: UITabBarController {
    // MARK: LifeCycle
    
    convenience init(viewIndex: Int) {
        self.init()
        
        /// Build each tab of App
        let marvelListView = MarvelListBuilder.build()
        let registerView = RegisterBuilder.build()
        let permissionsView = PermissionsBuilder.build()
        
        marvelListView.tabBarItem = UITabBarItem.init(title: "Marvel", image: UIImage.init(systemName: "list.dash"), tag: 0)
        registerView.tabBarItem = UITabBarItem.init(title: "Register", image: UIImage.init(systemName: "lock.fill"), tag: 1)
        permissionsView.tabBarItem = UITabBarItem.init(title: "Permissions", image: UIImage.init(systemName: "rosette"), tag: 2)
        
        let marvelListViewNavigationController = UINavigationController.init(rootViewController: marvelListView)
        let registerViewNavigationController = UINavigationController.init(rootViewController: registerView)
        let permissionsViewNavigationController = UINavigationController.init(rootViewController: permissionsView)

        self.viewControllers = [marvelListViewNavigationController, registerViewNavigationController, permissionsViewNavigationController]
        self.tabBar.barStyle = .default
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor.black
        self.selectedIndex = viewIndex
    }
    
    
    // MARK: Public Functions
    
    func activeTabBar() -> UITabBarController {
        return self
    }
}
