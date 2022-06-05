//
//  ApodResponse.swift
//  APODNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import Foundation

class ApodResponse : Decodable, ObservableObject {
//    var id: Int
    @Published var isFavourite: Bool = false
    var date: String
    var title: String
    var explanation: String
    var url: String
    var media_type: String
    
    var errorCode: Int?
    var msg: String?
    
    
    
    enum CodingKeys: String, CodingKey {

        //case copyright = "copyright"
        case date = "date"
        case explanation = "explanation"
        case media_type = "media_type"
        //case service_version = "service_version"
        case title = "title"
        case url = "url"
        case errorCode = "code"
        case msg = "msg"
//        case id = "id"
    }
    
    init(date:String,title: String,explanation: String,url: String, media_type: String) {
        
        self.date = date
        self.title = title
        self.explanation = explanation
        self.url = url
        self.media_type = media_type
    }
}

struct APIError : Error, Decodable {
    var code: Int
    var msg: String
    var service_version: String
    
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case service_version = "service_version"
    }
}
