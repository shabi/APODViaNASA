//
//  ConstantsUnitTests.swift
//  APODViaNASATests
//
//  Created by Shabi Naqvi on 06/06/22.
//

import XCTest
@testable import APODViaNASA

class ConstantsUnitTests: XCTestCase {
    
    func testConstantValues() {
        var dateFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           return formatter
       }
        let image = UIImage(named: Constants.NoImage)
        Constants.imageCache.setObject(image!, forKey: "imagePath" as AnyObject)
        
        XCTAssertEqual(Constants.ApodDateFormat, "yyyy-MM-dd")
        XCTAssertEqual(Constants.NoImage, "no-image-icon")
        XCTAssertEqual(Constants.dateFormatter.string(from: Date()), dateFormatter.string(from: Date()))
        XCTAssertEqual(Constants.imageCache.object(forKey: "imagePath" as AnyObject), image)
    }
    
    func testAPIKEY_And_BaseURL() {
          
        let config = Constants.getConfig()
        let apiKey =  config?["APOD_KEY"] as? String ?? ""
        XCTAssertEqual(Constants.getAPIKey(), apiKey)

        //Test Base URL

        let baseURL =  config?["BASE_URL"] as? String ?? ""
        XCTAssertEqual(Constants.getApodBaseURL(), baseURL)
      }
}
