//
//  Offer.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation

struct Offer: Codable {
    let id: String?
    let title: String
    let link: String
    let button: Button?
}

struct Button: Codable {
    let text: String
}
