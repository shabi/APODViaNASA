//
//  BundleDecoder.swift
//  APODViaNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import Foundation
struct BundleDecoder {
    static func decodeApodjson()->[ApodResponse] {
        let apodJson = Bundle.main.path(forResource: "APOD", ofType: "json")
        let apod = try! Data(contentsOf: URL(fileURLWithPath: apodJson!), options: .alwaysMapped)
        return try! JSONDecoder().decode([ApodResponse].self, from: apod)
    }
}
