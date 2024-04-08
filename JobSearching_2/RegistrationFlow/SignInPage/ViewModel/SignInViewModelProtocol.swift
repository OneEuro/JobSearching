//
//  SignInViewModelProtocol.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Combine

protocol SignInViewModelProtocol: AnyObject {
    
    var passwordVerification: PasswordVerificationProtocol { get }
    
    var emailTextFieldValue: PassthroughSubject<String, Never> { get }
    var signInButtonEnable: CurrentValueSubject<Bool, Never> { get }
    var loginStatusValue: PassthroughSubject<String, Never> { get }
    var loginStatusLabelHidden: CurrentValueSubject<Bool, Never> { get }

    var credentialsData: PassthroughSubject<Credentials, Never>{ get }
    
}
