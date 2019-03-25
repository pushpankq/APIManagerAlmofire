//
//  APIManager.swift
//  APIManager Class
//
//  Created by Pushpank Kumar on 21/01/19.
//  Copyright © 2019 Pushpank Kumar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class APIManager {
    
    //singleton Class instance 
    static let shared = APIManager()
    
    private init() {
        
        // Do nothing here...
    }
    
    // Completion Handler
    typealias webServiceResponse = (JSON?, Error?) -> Void
    
    
    //   Post Service Methods  

    /// getting data from http Method post service
    ///
    /// - Parameters:
    ///   - request: a particular url (API End Point)
    ///   - parameters: send json data to the server
    ///   - completionHandler: callback
    
    func postService(_ request: String, andParameter parameters: [String:Any]?, withCompletion completionHandler: @escaping webServiceResponse) {
        
        let reuestUrl =  request
        
        var encodingFormat: ParameterEncoding = JSONEncoding()
        if request == "" {
            encodingFormat = JSONEncoding()
        }
        
        Alamofire.request(reuestUrl, method: .post, parameters: parameters, encoding: encodingFormat, headers: nil).responseJSON{ (responseData) in
            
            if responseData.result.isSuccess {
                
                if((responseData.result.value) != nil) {
                    
                    let swiftyJsonData = JSON(responseData.result.value!)
                    completionHandler(swiftyJsonData, nil)
                    
                } else {
                    print(responseData.result)
                }
                
            } else {
                
                completionHandler(nil, responseData.error)
            }
        }
    }
    
    //   Get Service Methods  
    
    /// getting data from http Method get service
    ///
    /// - Parameters:
    ///   - request: a particular url (API End Point)
    ///   - completionHandler: callback
    
    func callGetService(urlString:String, withCompletion completionHandler: @escaping webServiceResponse)  {
        
        let url = URL(string: urlString)
        
        Alamofire.request(url!).validate()
            .responseJSON { (responseData) in
                
                if responseData.result.isSuccess {
                    
                    if((responseData.result.value) != nil) {
                        
                        let swiftyJsonData = JSON(responseData.result.value!)
                        completionHandler(swiftyJsonData, nil)
                        
                    } else {
                        print(responseData.result)
                    }
                    
                } else {
                    
                    completionHandler(nil, responseData.error)
                }
        }
    }
    
}


