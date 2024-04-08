//
//  RegistrationFactory.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
class RegistrationFactory {
    
    let servicesFactory = ServicesFactory()

    func createSignInModule(coordinator: RegistrationFlowCoordinatorProtocol) -> SignInViewController {
        let vc = SignInViewController(
            viewModel: SignInViewModel(
                passwordVerification: servicesFactory.createPasswordVerification()),
            coordinator: coordinator)

        return vc
    }
    
    func createVerificationCodeModule(coordinator: RegistrationFlowCoordinatorProtocol, credentials: Credentials) -> VerificationCodeViewController {
        let vc = VerificationCodeViewController(
            viewModel: VerificationCodeViewModel(
                passwordVerification: servicesFactory.createPasswordVerification(),credentials: credentials),
            coordinator: coordinator)

        return vc
    }

    
    
}
