//
//  ApodRequest.swift
//  APODNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import Foundation

struct ApodRequest : Encodable {
    var start_date: String?
    var end_date: String?
}
