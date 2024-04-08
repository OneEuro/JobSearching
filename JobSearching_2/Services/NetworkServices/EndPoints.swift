//
//  EndPoints.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 08.04.2024.
//

import Foundation

struct EndPoints {
    var path: String
}

extension EndPoints {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.path = "/" + path
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    static var fileURL: URL {
        guard let fileURL = Bundle.main.url(forResource: "MockAPI", withExtension: "json") else {
            fatalError("Couldn't find data.json in the main bundle")
        }
        return fileURL
    }
}
