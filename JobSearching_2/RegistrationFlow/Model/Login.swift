//
//  Login.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation

struct Login: Codable {
    let string: String
    
    init?(_ rawString: String) {
        guard !rawString.isEmpty else { return nil }
        string = rawString
    }
}
