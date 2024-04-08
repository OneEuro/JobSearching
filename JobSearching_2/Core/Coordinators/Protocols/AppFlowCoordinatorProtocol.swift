//
//  AppFlowCoordinatorProtocol.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
import UIKit.UITabBarController

protocol AppFlowCoordinatorProtocol: AnyObject {
    
    var tabBarController: UITabBarController { get }
    
    func start()
    func showSearchPage(user: User)
    func logout()
    
}
