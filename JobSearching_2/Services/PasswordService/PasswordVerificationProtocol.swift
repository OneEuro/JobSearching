//
//  PasswordVerificationProtocol.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
protocol PasswordVerificationProtocol {
    
    var users: [User] { get }
    
    func loadUsers()
    func addUser(_ user: User) throws
    func checkCredentials(_ credentials: Credentials) throws -> User
    func checkVerifyCode(_ credentials: Credentials) throws -> User
    
    func dropPasswordToDefault(_ email: Email) throws
}
