//
//  AppFlowCoordinator.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
import UIKit

class AppFlowCoordinator:NSObject, AppFlowCoordinatorProtocol {
    
    var tabBarController: UITabBarController
    var navigationController: UINavigationController!
    
    var isAuth: Bool = false
    
    var childCoordinators = [Coordinator]()
    
    let factory = MainFlowFactory()
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarItemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 10)]
        tabBarItemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
            .font: UIFont.systemFont(ofSize: 10)]

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

        tabBarController.tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        
        tabBarController.tabBar.isHidden = false
        setupNavBar()
        tabBarController.delegate = self

        
        if isAuth {
            
        } else {
            showRegistration()
//            guard let login = Login("test"), let email = Email("example@gmail.com"), let password = try? Password.parse("0000").get() else {return }
//            showSearchPage(user: User(login: login, credentials: Credentials(email: email, password: password)))
        }
    }
    
    private func setupNavBar() {
        let searchBarItem = UITabBarItem(title: "Поиск", image: UIImage(named: "searchIcon"), tag: 0)
        navigationController.tabBarItem = searchBarItem
        tabBarController.setViewControllers([navigationController, factory.createFavoritesPageModule(coordinator: self),factory.createFeedbackModule(),factory.createMessagesModule(),factory.createProfileModule()], animated: false)
    }
    
    private func showRegistration() {
        let registrationFlowCoordinator =    CoordinatorsFactory().createRegistrationFlowCoordinator(navigationController: navigationController)
        registrationFlowCoordinator.start()
        childCoordinators.append(registrationFlowCoordinator)
        registrationFlowCoordinator.completionHandler = {[weak self] user in
            self?.navigationController = nil
            self?.showSearchPage(user: user)
        }
    }
    
    func showSearchPage(user: User) {
        isAuth = true
        tabBarController.setViewControllers([factory.createMainPageModule(coordinator: self), factory.createFavoritesPageModule(coordinator: self),factory.createFeedbackModule(),factory.createMessagesModule(),factory.createProfileModule()], animated: false)
        tabBarController.selectedIndex = 0
    }
    
    func logout() {
        tabBarController.tabBar.isHidden = true
        
        navigationController = UINavigationController()
        tabBarController.viewControllers?.removeAll()
        tabBarController.addChild(navigationController)
        tabBarController.selectedIndex = 0
        
        showRegistration()
    }
    
    
}

extension AppFlowCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        isAuth ? true : false
    }
}
