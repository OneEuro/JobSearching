//
//  SignInViewModel.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
import Combine

class SignInViewModel: SignInViewModelProtocol {
    
    var passwordVerification: PasswordVerificationProtocol
    
    var emailTextFieldValue = PassthroughSubject<String, Never>()
    var signInButtonEnable = CurrentValueSubject<Bool, Never>(false)
    var loginStatusValue = PassthroughSubject<String, Never>()
    var loginStatusLabelHidden = CurrentValueSubject<Bool, Never>(true)
    var credentialsData =  PassthroughSubject<Credentials, Never>()
    
    private var email: Email?

    private var subscriptions = Set<AnyCancellable>()
    
    init(passwordVerification: PasswordVerificationProtocol)
    {
        self.passwordVerification = passwordVerification

            emailTextFieldValue
                .receive(on: DispatchQueue.global())
                .sink { emailString in
                    self.validateEmail(emailString)
                }
                .store(in: &subscriptions)
    }
    
    private func validateEmail(_ emailString: String) {
        
        guard let email = Email(emailString)
        else {
            loginStatusValue.send("Вы ввели неверный e-mail")
            loginStatusLabelHidden.send(false)
            return
        }
        self.email = email
        let credentials = Credentials(email: email, password: nil)
        loginStatusLabelHidden.send(true)
        signInButtonEnable.send(true)
        credentialsData.send(credentials)
    }

}
