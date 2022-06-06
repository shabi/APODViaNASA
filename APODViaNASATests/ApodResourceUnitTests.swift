//
//  ApodResourceUnitTests.swift
//  APODViaNASATests
//
//  Created by Shabi Naqvi on 06/06/22.
//

import XCTest
@testable import APODViaNASA

class ApodResourceUnitTests: XCTestCase {

    func test_ApodAPIResource_With_ValidRequest_Returns_ArrAyOfApodResponse() {
        //Arrange
        let apodRequest = ApodRequest(start_date: Constants.dateFormatter.string(from: Date()), end_date: Constants.dateFormatter.string(from: Date()))
        let apodResource = ApodResource()
        let expectation = self.expectation(description: "ValidRequest_Returns_ApodResponse")
        
        //ACT
        apodResource.getApodForDateRange(apodRequest: apodRequest) { (apodApiResponse, error) in
            //ASSERT
            XCTAssertNotNil(apodApiResponse)
            XCTAssertNil(error)
            XCTAssertEqual(Constants.dateFormatter.string(from: Date()), apodApiResponse?.first?.date)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

}
