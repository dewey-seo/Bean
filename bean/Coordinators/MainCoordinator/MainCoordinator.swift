//
//  MainCoordinator.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
    weak var parent: Coordinator?
    
    var children = [Coordinator]()
    var router: Router
    
    let tabBarController = MainTabBarViewController(nibName: "MainTabBarViewController", bundle: nil)
    
    init(router: Router) {
        console("init - MainCoordinator")
        self.router = router
    }
    
    deinit {
        console("deinit - MainCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        self.parent = parent
        
        let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let homeTabNavigationController = UINavigationController(rootViewController: homeViewController)
        let homeTabNavigationRouter = NavigationRouter(navigationController: homeTabNavigationController)
        homeTabNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        let homeTabCoordinator = HomeTabCoordinator(router: homeTabNavigationRouter)
        
        let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let profileTabNavigationController = UINavigationController(rootViewController: profileViewController)
        let profileTabNavigationRouter = NavigationRouter(navigationController: profileTabNavigationController)
        profileTabNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        let profileTabCoordinator = ProfileTabCoordinator(router: profileTabNavigationRouter)
        
        tabBarController.viewControllers = [homeTabNavigationController, profileTabNavigationController]
        tabBarController.modalPresentationStyle = .fullScreen

        router.present(tabBarController, animated: animated)
        
        self.presentChild(homeTabCoordinator, animated: false)
        self.presentChild(profileTabCoordinator, animated: false)
    }
}
