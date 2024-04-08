//
//  Email.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation

struct Email: Codable, Equatable {
    let string: String
    
    init?(_ rawString: String) {
        guard !rawString.isEmpty,
              rawString.contains(where: { $0 == "@" })  else {
            return nil
        }
        string = rawString
    }
}
