//
//  Password.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation

struct Password: Codable, Equatable {
    let string: String
    
    private init(string: String) {
        self.string = string
    }
    
    enum ValidationError: Error {
        case tooShort
    }
    
    static func parse(_ rawString: String) -> Result<Password, ValidationError> {
        guard rawString.count > 3 else {
            return .failure(.tooShort)
        }
        return .success(Password(string: rawString))
    }
    
}
