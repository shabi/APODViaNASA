//
//  HttpUtility.swift
//  APODNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import Foundation

struct HttpUtility
{
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T?, _ error:String?)-> Void)
    {
        debugPrint(requestUrl)
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                do {
                    debugPrint("API Success")
                    let result = try JSONDecoder().decode(T.self, from: responseData!)
                    _=completionHandler(result,nil)
                }
                catch let error {
                    debugPrint("API error occured while decoding = \(error.localizedDescription)")
                    _=completionHandler(nil,error.localizedDescription)
                }
            }else {
                debugPrint("API Failed")
                _=completionHandler(nil,error?.localizedDescription)
            }
            
        }.resume()
    }
    
    func getApiData<T: Decodable>(requestUrl: URL, resultType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                do {
                    debugPrint("API Success")
                    let jsonDecoded = try JSONDecoder().decode(T.self, from: responseData!)
                    completion(.success(jsonDecoded))
                } catch (let error) {
                    debugPrint("API error occured while decoding = \(error.localizedDescription)")
                    completion(.failure(error as? APIError ?? APIError(code: 400, msg: "API error occured while decoding", service_version: "")))
                }
                
            }else {
                debugPrint("API Failed")
                completion(.failure(error as? APIError ?? APIError(code: 400, msg: "API error occured while decoding", service_version: "")))
            }
            
        }.resume()
    }
}

