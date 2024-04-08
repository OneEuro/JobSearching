//
//  RegistrationFlowCoordinatorProtocol.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
import UIKit.UINavigationController

protocol RegistrationFlowCoordinatorProtocol: Coordinator {
    
    var navigationController: UINavigationController { get set }
    var completionHandler: ((User) -> ())? { get set }
    
    
    func start()
    
    func showSignIn()
    func showVerificationCode(credentials: Credentials)
    
    func endFlow(user: User)
    
}
