//
//  NetworkingService.swift
//  assessment-ios
//
//  Created by Vignesh on 22/01/21.
//  Copyright © 2021 Vignesh. All rights reserved.
//

import Foundation
import Alamofire
typealias JSON = [String:Any]
class NetworkingService{
    static let shared = NetworkingService()
    private init() {}
    
    func fetchWeatherList(completion: @escaping (_ responseObject: WeatherResponse?,
                                                 _ error: AFError?) -> ()) {
        let url = String(format: "%@%@", AppConstants.weatherURL, AppConstants.weatherAPIKey)
        AF.request(url, parameters: nil)
            .validate()
            .responseDecodable(of: WeatherResponse.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}
