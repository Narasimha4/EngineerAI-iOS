//
//  APIHelper.swift
//  EngineerAI-iOS
//
//  Created by Narasimha on 12/06/19.
//  Copyright © 2019 fissionlabs. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

typealias ServiceResponse = (NSDictionary?, NSError?) -> Void
typealias serviceResponse = (Data?, NSDictionary?, NSError?) -> Void
typealias FailureReason = (NSError?)-> Void


class APIHelper: NSObject {
    
    // Get Customer Details
    func getTotalPosts(page: Int, onCompletion: @escaping serviceResponse, onFailure: @escaping FailureReason) {
        
        guard ReachabilityManager.shared.isConnectedToNetwork() else {
            Alert().alertMsg(message: "An internet connection is required.\n Please try again after a connection is \n established.", actionButtonTitle: "OK", title: "EngineerAI")
            onCompletion(nil, nil, nil)
            return
        }
        
        let url = "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=\(page)"

        
        Alamofire.request(url, method:.get, parameters:nil, encoding:JSONEncoding.default)
            .validate(statusCode: 200..<400)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                     onCompletion(response.data, response.result.value as? NSDictionary, nil)
                case .failure(let error):
                    onFailure(error as NSError)
                }
        }
    }
    
}
