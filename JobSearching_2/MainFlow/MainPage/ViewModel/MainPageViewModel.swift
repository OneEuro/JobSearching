//
//  MainPageViewModel.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
import Combine

class MainPageViewModel: MainPageViewModelProtocol {
    func getJobData() {
        JSONDataFetch.shared.fetchJobData(fileURL: EndPoints.fileURL) { jobData, error in
            if error != nil {
                print(error)
            } else if let job = jobData {
                print(job)
            }
        }
    }
}
