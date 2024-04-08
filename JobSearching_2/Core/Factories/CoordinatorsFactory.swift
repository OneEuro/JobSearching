//
//  CoordinatorsFactory.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
import UIKit.UINavigationController
import UIKit.UITabBarController

class CoordinatorsFactory {
    
    func createRegistrationFlowCoordinator(navigationController: UINavigationController) -> RegistrationFlowCoordinator {
        RegistrationFlowCoordinator(navigationController: navigationController)
    }
    
    func createAppFlowCoordinator(tabBarController: UITabBarController) -> AppFlowCoordinator {
        AppFlowCoordinator(tabBarController: tabBarController)
    }
    
    
}
