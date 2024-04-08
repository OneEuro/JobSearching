//
//  RegistrationFlowCoordinator.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
import UIKit.UINavigationController

class RegistrationFlowCoordinator: RegistrationFlowCoordinatorProtocol {
    
    private let moduleFactory = RegistrationFactory()
    
    var navigationController: UINavigationController
    var completionHandler: ((User) -> ())?
    
    init(navigationController: UINavigationController ) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSignIn()
    }
    
    func showSignIn() {
        let vc = moduleFactory.createSignInModule(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func showVerificationCode(credentials: Credentials) {
        let vc = moduleFactory.createVerificationCodeModule(coordinator: self, credentials: credentials)

        navigationController.pushViewController(vc, animated: true)
    }
    
    func endFlow(user: User) {
        completionHandler?(user)
    }
    
    
}
