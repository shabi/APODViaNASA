//
//  ApodUrlsTests.swift
//  APODViaNASATests
//
//  Created by Shabi Naqvi on 06/06/22.
//

import XCTest
@testable import APODViaNASA

class ApodUrlsTests: XCTestCase {

    func testApodDateRangeURL()  {
        let startDate = "2022-09-09"
        let endDate = "2022-09-09"
        
        let url = ApiEndpoints(startDate: startDate, endDate: endDate)
        let testUrl = "https://\(Constants.getApodBaseURL())/planetary/apod?api_key=\(Constants.getAPIKey())&start_date=\(startDate)&end_date=\(endDate)"
        XCTAssertEqual(url.apodDateRangeURL, testUrl)
    }
}
