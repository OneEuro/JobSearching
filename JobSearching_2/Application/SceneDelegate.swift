//
//  SceneDelegate.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator =  CoordinatorsFactory().createAppFlowCoordinator(tabBarController: UITabBarController())
 
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = appCoordinator.tabBarController
        
        appCoordinator.start()
        
        window?.makeKeyAndVisible()
        
        // active light statusBar style for all application
        window?.overrideUserInterfaceStyle = .dark
    }


}
