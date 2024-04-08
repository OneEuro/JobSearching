//
//  JSONDataFetch.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 08.04.2024.
//

import Foundation

enum JSONError: Error {
    case notParseData
    case invalidJSONFormat
}

class JSONDataFetch {
    static let shared = JSONDataFetch()
    
    private init() {}
    
    func fetchJobData(fileURL: URL, responce: @escaping (JobData?, JSONError?) -> Void) {
        do {
            let data = try Data(contentsOf: fileURL)
            
            let json = try? JSONDecoder().decode(JobData.self, from: data)
  
            if let jsonObject = json {
                responce(jsonObject,nil)
            } else {
                responce(nil,JSONError.invalidJSONFormat)
            }
        } catch {
            print("Error reading JSON file: \(error)")
        }
        
    }
    
}

