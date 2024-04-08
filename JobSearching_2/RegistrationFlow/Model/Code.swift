//
//  Code.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 07.04.2024.
//

import Foundation

struct Code: Codable, Equatable {
    let string: String
    
    enum ValidationError: Error {
        case tooShort
    }
    
    private init(string: String) {
        self.string = string
    }
    
    static func parse(_ rawString: String) -> Result<Code, ValidationError> {
        guard rawString.count == 4 else {
            return .failure(.tooShort)
        }
        return .success(Code(string: rawString))
    }
}
