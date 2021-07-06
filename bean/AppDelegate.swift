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
    
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start(animated: true, parent: nil)
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        if(GIDSignIn.sharedInstance().handle(url)) {
            return true
        }
        
        return true
    }
}

