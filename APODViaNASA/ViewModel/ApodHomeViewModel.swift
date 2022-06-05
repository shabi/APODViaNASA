//
//  ApodHomeViewModel.swift
//  APODNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import Foundation

class ApodHomeViewModel: ObservableObject {
    @Published var apods: Array<ApodResponse> = Array<ApodResponse>()
    @Published var isLoading: Bool = false
    
    private let resource: ApodResource = ApodResource()
    let cache = NSCache<AnyObject, AnyObject>()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.ApodDateFormat
        return formatter
    }
    
    //APOD API Call for One date
    func callApodApi(queryDate: Date) {
        let apodRequest = ApodRequest(date: dateFormatter.string(from: queryDate))
        //Use ApodResource to call API
        let apodResource = ApodResource()
        self.isLoading = true
        apodResource.getApod(apodRequest: apodRequest) { [weak self] (apodApiResponse,error) in

            
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            //Return the response to view get from apodResource
            if(error == nil && apodApiResponse != nil) {
                DispatchQueue.main.async {
                    self?.apods.append(apodApiResponse!)
                }
                
                //If need to cache all requests
                self?.cache.setObject(apodApiResponse!, forKey: Constants.CachedResponseKey as NSString)
            } else {

                DispatchQueue.main.async {
                    
                    if let cachedResponse = self?.cache.object(forKey: Constants.CachedResponseKey as NSString), let apodResponse = cachedResponse as? ApodResponse {
                        // Return Last API Cached Response
                        self?.apods.removeAll()
                        self?.apods.append(apodResponse)
                    }
                }
            }
        }
    }
    
    
    //APOD API Call for date range
    func callApodApi(startDate: Date?, endDate: Date?) {
        
        guard let startDateValue = startDate, let endDateValue = endDate else {
            return
        }
        
        if startDateValue == endDateValue {
            callApodApi(queryDate: startDateValue)
            return
        }
      

        let apodRequest = ApodRequest(date: dateFormatter.string(from: startDateValue), start_date: dateFormatter.string(from: startDateValue), end_date: dateFormatter.string(from: endDateValue))
        //Use ApodResource to call API
        let apodResource = ApodResource()
        self.isLoading = true
        apodResource.getApodForDateRange(apodRequest: apodRequest) { [weak self] (apodApiResponse, error) in

            DispatchQueue.main.async {
                self?.isLoading = false
            }
            
            //Return the response to view get from apodResource
            if(error == nil && apodApiResponse != nil) {
                DispatchQueue.main.async {
                    self?.apods.removeAll()
                    self?.apods.append(contentsOf: apodApiResponse ?? [])
                }

                //If need to cache all requests
                self?.cache.setObject(apodApiResponse! as NSArray, forKey: Constants.CachedResponseKey as NSString)

            } else {

                DispatchQueue.main.async {
                    if let cachedResponse = self?.cache.object(forKey: Constants.CachedResponseKey as NSString), let apodArray = cachedResponse as? [ApodResponse] {
                        // Return Last API Cached Response
                        self?.apods.removeAll()
                        self?.apods.append(contentsOf: apodArray)
                    }
                }
            }
        }
    }
}
