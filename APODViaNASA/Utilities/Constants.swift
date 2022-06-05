//
//  Constants.swift
//  APODNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import Foundation
import UIKit

struct Constants {
    
    static let ErrorAlertTitle = "Error"
    static let OkAlertTitle = "Ok"
    static let CancelAlertTitle = "Cancel"
    static let CalenderImage = "calender"
    static let NoImage = "no-image-icon"
    static let ApodDateFormat = "yyyy-MM-dd"
    static let MediaTypeImage = "image"
    static let MediaTypeVideo = "video"
    static let CachedResponseKey = "CachedResponse"
    static let imageCache = NSCache<AnyObject, UIImage>()
    enum MediaType {
        case image
        case video
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
    
    static func setFavourite(for key: String) {
        let favourite = UserDefaults.standard
        favourite.set(true, forKey: key)
        favourite.synchronize()
    }
    
    static func getFavourite(for key: String) -> Bool {
        let favourite = UserDefaults.standard
        return favourite.bool(forKey: key)
    }
    
    static func removeObjectFavourite(for key: String) {
        let favourite = UserDefaults.standard
        favourite.removeObject(forKey:key)
        favourite.synchronize()
    }
}
