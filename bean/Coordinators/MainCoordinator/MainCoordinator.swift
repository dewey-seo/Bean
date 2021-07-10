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
    
    let tabBarController = RootTabBarViewController(nibName: "RootTabBarViewController", bundle: nil)
    
    init(from: Router?) {
        console("init - MainCoordinator")
        self.router = Router(fromViewController: from?.navigationController.viewControllers.first)
        self.router.navigationController.setNavigationBarHidden(true, animated: false)
        self.router.navigationController.modalPresentationStyle = .fullScreen
        
        let tabbar = UITabBar()
//        object_setClass(tabbar, <#T##cls: AnyClass##AnyClass#>)
    }
    
    deinit {
        console("deinit - MainCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        self.parent = parent
        
        let HomeTabViewController = HomeTabViewController(nibName: "HomeTabViewController", bundle: nil)
        let homeTabNavigationRouter = Router(fromViewController: nil)
        homeTabNavigationRouter.navigationController.viewControllers = [HomeTabViewController]
        
        let homeTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_home"), selectedImage: UIImage(named: "tab_home_selected"))
        let homeTabCoordinator = HomeTabCoordinator(router: homeTabNavigationRouter)
        homeTabNavigationRouter.navigationController.tabBarItem = homeTabBarItem
        
        let myTabViewController = MyTabViewController(nibName: "MyTabViewController", bundle: nil)
        let myTabNavigationRouter = Router(fromViewController: nil)
        myTabNavigationRouter.navigationController.viewControllers = [myTabViewController]
        let myTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_user"), selectedImage: UIImage(named: "tab_user_selected"))
        let myTabCoordinator = MyTabCoordinator(router: myTabNavigationRouter)
        myTabNavigationRouter.navigationController.tabBarItem = myTabBarItem
        
        
        tabBarController.viewControllers = [homeTabNavigationRouter.navigationController, myTabNavigationRouter.navigationController]
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.tabBar.tintColor = .primary6
        
        router.present(tabBarController, animated: animated)
        
        self.presentChild(homeTabCoordinator, animated: false)
        self.presentChild(myTabCoordinator, animated: false)
    }
    
    func findParent<T: Coordinator>(_ type: T.Type) -> T? {
        guard let parent = self.parent else {
            return nil
        }
        if let parent = parent as? T {
            return parent
        } else {
            return parent.findParent(type)
        }
    }
}
