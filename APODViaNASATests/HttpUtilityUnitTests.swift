//
//  HttpUtilityUnitTests.swift
//  APODViaNASATests
//
//  Created by Shabi Naqvi on 06/06/22.
//

import XCTest
@testable import APODViaNASA

class HttpUtilityUnitTests: XCTestCase {
    func testExample() {
        //Arrange
        let dafaultDateValue = Constants.dateFormatter.string(from: Date())
        let url = ApiEndpoints(startDate: dafaultDateValue, endDate: dafaultDateValue).apodDateRangeURL
        let httpUtility = HttpUtility()
        let expectation = self.expectation(description: "ValidRequest_Returns_ApodResponse")
        
        //ACT
        if let urlString = url, let apodUrl = URL(string: urlString) {
            httpUtility.getApiData(requestUrl: apodUrl, resultType: [ApodResponse].self) {  result in
                switch result {
                case .success(let data):
                    XCTAssertEqual(Constants.dateFormatter.string(from: Date()), data.first?.date)
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
