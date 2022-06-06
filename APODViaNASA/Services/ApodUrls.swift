//
//  ApodUrls.swift
//  APODNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import Foundation

struct ApiEndpoints {
    
    var apodDateRangeURL: String? = nil
    
    init(startDate: String, endDate: String) {
        self.apodDateRangeURL = "https://\(Constants.getApodBaseURL())/planetary/apod?api_key=\(Constants.getAPIKey())&start_date=\(startDate)&end_date=\(endDate)"
    }
    
}
