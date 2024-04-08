//
//  Credentials.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation

struct Credentials: Codable, Equatable {
    let email: Email
    let password: Password?
    var pinCode: Code?
    
}
