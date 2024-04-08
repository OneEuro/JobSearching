//
//  JobData.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation

struct JobData: Codable {
    let offers: [Offer]
    let vacancies: [Vacancy]
}
