//
//  ApodResource.swift
//  APODNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import Foundation

struct ApodResource
{
    func getApodForDateRange(apodRequest: ApodRequest, completion : @escaping (_ result: [ApodResponse]?,_ error:String?) -> Void)
    {
        let dafaultDateValue = Constants.dateFormatter.string(from: Date())
        let startDate = apodRequest.start_date ?? dafaultDateValue
        let endDate = apodRequest.end_date ?? dafaultDateValue

        let url = ApiEndpoints(startDate: startDate, endDate: endDate).apodDateRangeURL
        
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

