//
//  PasswordVerification.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
class PasswordVerification: PasswordVerificationProtocol {
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    var users: [User] {
        didSet {
            saveUsers()
        }
    }
    
    enum UserVerificationError: Error {
        case alreadyRegistered
        case userIsNotExist
        case accountForThisEmailDoesNotExist
        case failedToRecreateUser
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.users) {
            do {
                self.users = try decoder.decode([User].self, from: data)
            } catch {
                print("Decode error:", " coudn't decode extracted users. \n\(error)")
                self.users = []
            }
        } else {
            self.users = []
        }
        
    }
    
    func loadUsers() {
        if let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.users) {
            do {
                self.users = try decoder.decode([User].self, from: data)
            } catch {
                print("Decode error:", " coudn't decode extracted users. \n\(error)")
            }
        }
    }
    
    private func saveUsers() {
        do {
            let data = try encoder.encode(users)
            UserDefaults.standard.set(data, forKey: UserDefaultsKeys.users)
        } catch {
            print("Encode error:", " unable to encode [User]. \n\(error)")
        }
    }
    
    func addUser(_ user: User) throws {
        if users.contains(where: { $0.credentials == user.credentials }) {
            throw UserVerificationError.alreadyRegistered
        } else {
            users.append(user)
        }
    }
    
    func checkCredentials(_ credentials: Credentials) throws -> User {
        let user = users.first(where: {$0.credentials == credentials})
        if user == nil {
            throw UserVerificationError.userIsNotExist
        } else {
            return user!
        }
    }
    
    func checkVerifyCode(_ credentials: Credentials) throws -> User {
        if credentials.pinCode?.string == "0000", let login = Login("Test") {
            return User(login: login, credentials: credentials)
        } else {
            throw UserVerificationError.failedToRecreateUser
        }
    }
    
    func dropPasswordToDefault(_ email: Email) throws {
        let index = users.firstIndex { $0.credentials.email == email }
        if index != nil {
            let user = users.remove(at: index!)
            
            let password = Password.parse("12345")
            switch password {
            case .success(let password):
                let credentials = Credentials(email: email, password: password)
                let newUser = User(login: user.login, credentials: credentials)
                do {
                    try addUser(user)
                } catch {
                    users.append(user)
                    throw UserVerificationError.failedToRecreateUser
                }
            case .failure(_):
                assert(true, "Wrong drop-default password")
            }
        } else {
            throw UserVerificationError.accountForThisEmailDoesNotExist
        }
    }
    
    
}
