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
    
    
    //APOD API Call for date range
    func callApodApi(startDate: Date?, endDate: Date?) {
        
        guard let startDateValue = startDate, let endDateValue = endDate else {
            return
        }
        
        let dateRangeKeyPath = Constants.dateFormatter.string(from: startDateValue) + Constants.dateFormatter.string(from: endDateValue)
        
        //Data Caching for offline support
        if let cachedApods = Constants.cache.object(forKey: dateRangeKeyPath as AnyObject), let cachedApodArray = cachedApods as? [ApodResponse] {
            debugPrint("Pods fetched from Cached")
                self.apods.removeAll()
            for apod in cachedApodArray {
                self.apods.append(apod)
            }
            return
        }
        

        let apodRequest = ApodRequest(start_date: Constants.dateFormatter.string(from: startDateValue), end_date: Constants.dateFormatter.string(from: endDateValue))
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
                Constants.cache.setObject(apodApiResponse! as NSArray, forKey: dateRangeKeyPath as NSString)

            } else {

                DispatchQueue.main.async {
                    if let cachedResponse = Constants.cache.object(forKey: dateRangeKeyPath as NSString), let apodArray = cachedResponse as? [ApodResponse] {
                        // Return Last API Cached Response
                        self?.apods.removeAll()
                        self?.apods.append(contentsOf: apodArray)
                    }
                }
            }
        }
    }
}
