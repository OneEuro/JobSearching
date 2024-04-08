//
//  VerificationCodeViewModelProtocol.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 07.04.2024.
//

import Foundation
import Combine

protocol VerificationCodeViewModelProtocol {
    var passwordVerification: PasswordVerificationProtocol { get }
    
    var verificationCodeValue: PassthroughSubject<String, Never> { get }
    var emailValue: CurrentValueSubject<String, Never> { get }
    var isConfirmButtonEnable: PassthroughSubject<Bool, Never> { get }
    var userData: PassthroughSubject<User, Never> { get }
    var loginStatusValue: PassthroughSubject<String, Never> { get }
    var loginStatusLabelHidden: CurrentValueSubject<Bool, Never> { get }
    
    func didConfirmButtonTap()
}
