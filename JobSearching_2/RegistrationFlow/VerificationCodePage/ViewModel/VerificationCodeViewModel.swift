//
//  VerificationCodeViewModel.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 07.04.2024.
//

import Foundation
import Combine

class VerificationCodeViewModel: VerificationCodeViewModelProtocol {
    
    var passwordVerification: PasswordVerificationProtocol
    
    var verificationCodeValue = PassthroughSubject<String, Never>()
    var isConfirmButtonEnable = PassthroughSubject<Bool, Never>()
    var emailValue: CurrentValueSubject<String, Never>
    var userData = PassthroughSubject<User, Never>()
    var loginStatusValue = PassthroughSubject<String, Never>()
    var loginStatusLabelHidden = CurrentValueSubject<Bool, Never>(true)
    private var pinCode: String?
        
    private var subscriptions = Set<AnyCancellable>()
    private var credentials: Credentials?
    
    init(passwordVerification: PasswordVerificationProtocol, credentials: Credentials)
    {
        self.passwordVerification = passwordVerification
        self.credentials = credentials
        self.emailValue = CurrentValueSubject(credentials.email.string)
                
        verificationCodeValue.sink { str in
            self.pinCode = str
        }.store(in: &subscriptions)
        
    }
    
    func didConfirmButtonTap() {
        guard let pin = pinCode else {return}
        validateCode(pin)
    }
    
    private func validateCode(_ codeString: String) {
        guard var credentials = credentials,
              !credentials.email.string.isEmpty
        else {
            print("credentials is empty")
            return
        }
        let code = Code.parse(codeString)
        switch code {
        case .success(let code):
            credentials.pinCode = code
            do {
                let user = try passwordVerification.checkVerifyCode(credentials)
                userData.send(user)
            } catch {
                print("unable to create user")
                loginStatusValue.send("Используйте пин 0000")
                loginStatusLabelHidden.send(false)
            }
        case .failure(_):
            print("Incorrect verification code")
        }
    }
    
}
