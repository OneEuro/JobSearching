//
//  Vacancy.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
// MARK: - Vacancy
struct Vacancy: Codable {
    let id: String
    let lookingNumber: Int?
    let title: String
    let address: Address
    let company: String
    let experience: Experience
    let publishedDate: String
    let isFavorite: Bool
    let salary: Salary
    let schedules: [String]
    let appliedNumber: Int?
    let description: String?
    let responsibilities: String
    let questions: [String]
}

// MARK: - Address
struct Address: Codable {
    let town, street, house: String
}

// MARK: - Experience
struct Experience: Codable {
    let previewText, text: String
}

// MARK: - Salary
struct Salary: Codable {
    let full: String
    let short: String?
}
