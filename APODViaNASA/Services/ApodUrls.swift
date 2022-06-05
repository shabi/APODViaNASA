//
//  ApodUrls.swift
//  APODNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import Foundation

struct ApiEndpoints {
    
    let apodURL: String
    var apodDateRangeURL: String? = nil
    
    init(date:String, startDate: String? = nil, endDate: String? = nil) {
        self.apodURL = "https://\(Constants.getApodBaseURL())/planetary/apod?api_key=\(Constants.getAPIKey())&date=\(date)"
        
        if let startDateValue = startDate, let endDateValue = endDate {
            self.apodDateRangeURL = "https://\(Constants.getApodBaseURL())/planetary/apod?api_key=\(Constants.getAPIKey())&start_date=\(startDateValue)&end_date=\(endDateValue)"
        }
    }
    
}
