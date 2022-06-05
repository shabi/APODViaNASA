//
//  ApodResource.swift
//  APODNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import Foundation

struct ApodResource
{
    func getApod(apodRequest: ApodRequest, completion : @escaping (_ result: ApodResponse?,_ error:String?) -> Void)
    {
        let url = ApiEndpoints(date: apodRequest.date).apodURL
        
        if let apodUrl = URL(string: url) {
            
            let httpUtility = HttpUtility()
            httpUtility.getApiData(requestUrl: apodUrl, resultType: ApodResponse.self) {  result in
                switch result {
                case .success(let data):
                    _ = completion(data, nil)
                case .failure(let error):
                    _ = completion(nil, error.msg)
                }
            }
        }
    }
    
    func getApodForDateRange(apodRequest: ApodRequest, completion : @escaping (_ result: [ApodResponse]?,_ error:String?) -> Void)
    {
        let url = ApiEndpoints(date: "", startDate: apodRequest.start_date, endDate: apodRequest.end_date).apodDateRangeURL
        
        if let urlString = url, let apodUrl = URL(string: urlString) {
            
            let httpUtility = HttpUtility()
            
            httpUtility.getApiData(requestUrl: apodUrl, resultType: [ApodResponse].self) {  result in
                switch result {
                case .success(let data):
                    _ = completion(data, nil)
                case .failure(let error):
                    _ = completion(nil, error.msg)
                }
            }
        }
    }
    
}

