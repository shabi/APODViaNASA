//
//  Constants.swift
//  APODNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import Foundation
import UIKit

struct Constants {
    
    static let NoImage = "no-image-icon"
    static let ApodDateFormat = "yyyy-MM-dd"
    static let imageCache = NSCache<AnyObject, UIImage>()
    static let cache = NSCache<AnyObject, AnyObject>()
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.ApodDateFormat
        return formatter
    }
    
    static func getAPIKey() -> String {
        
        let config = getConfig()
        return config?["APOD_KEY"] as? String ?? ""
    }
    
    static func getApodBaseURL() -> String {
        
        let config = getConfig()
        return config?["BASE_URL"] as? String ?? ""
    }
    
    static func getConfig() -> [String: Any]? {
        
        var config: [String: Any]?
        
        if let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                    config = dict
                }
            } catch {
                print(error)
            }
        }
        return config
    }
}
