//
//  MainFlowFactory.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
import UIKit

class MainFlowFactory {
        
    func createMainPageModule(coordinator: AppFlowCoordinatorProtocol) -> MainPageViewController {
        let viewModel = MainPageViewModel()
        
        let vc = MainPageViewController(
            coordinator: coordinator,
            viewModel: viewModel)
        vc.tabBarItem = UITabBarItem(
            title: "Поиск",
            image: UIImage(named: "searchIcon"),
            tag: 0)
        return vc
    }
    
    func createFavoritesPageModule(coordinator: AppFlowCoordinatorProtocol) -> FavoritesPageViewController {
        let viewModel = FavoritesPageViewModel()
         
        let vc = FavoritesPageViewController(
            coordinator: coordinator,
            viewModel: viewModel)
        vc.tabBarItem = UITabBarItem(
            title: "Избранное",
            image: UIImage(named: "likeIcon"),
            tag: 1)
        return vc
    }
    
    func createFeedbackModule() -> FeedbackPageViewController {
        let vc = FeedbackPageViewController()
        vc.tabBarItem = UITabBarItem(
            title: "Отклики",
            image: UIImage(named: "feedbackIcon"),
            tag: 2)
        return vc
    }
    func createMessagesModule() -> MessagesPageViewController {
        let vc = MessagesPageViewController()
        vc.tabBarItem = UITabBarItem(
            title: "Сообщения",
            image: UIImage(named: "messageIcon"),
            tag: 3)
        return vc
    }
    func createProfileModule() -> ProfilePageViewController {
        let vc = ProfilePageViewController()
        vc.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(named: "profileIcon"),
            tag: 4)
        return vc
    }

}
