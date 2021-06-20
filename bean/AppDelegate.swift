//
//  AppDelegate.swift
//  bean
//
//  Created by dewey seo on 16/06/2021.
//M

import UIKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let window: UIWindow = UIWindow()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = SignInManager.shared
        
        let rootVC = RootViewController(nibName: "RootViewController", bundle: nil)
        let navC = UINavigationController.init(rootViewController: rootVC)
        navC.setNavigationBarHidden(true, animated: false)
        
        window.bounds = UIScreen.main.bounds
        window.rootViewController = navC
        window.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        if(GIDSignIn.sharedInstance().handle(url)) {
            return true
        }
        
        return true
    }
}

