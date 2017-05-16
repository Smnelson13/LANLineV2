//
//  APIController.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/15/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation


class APIController
{
  @nonobjc static var shared = APIController()
  var baseURL = "https://igdbcom-internet-game-database-v1.p.mashape.com/"
  var headers: [String: String] = [
    "X-Mashape-Key": "O00cNpvM31mshvqfuQ9JmsGw9hu0p1pAGLSjsnthxuO2oNLR9o"
  ]

 
  
  
  
  
  
}


//
//func request(_ method: HTTPMethod, route: String, parameters: [String: Any] = [:], completion:@escaping (_ result: JSON?, _ error: JSON?) -> Void) -> Alamofire.Request
//{
//  let request = Alamofire.request(
//    baseURL + route,
//    method: method,
//    parameters: parameters,
//    encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
//    headers: self.headers
//    //parameters: [String: Any]
//  )
//  print(request)
//  
//  request.responseJSON { response in
//    debugPrint(response)
//    if let value = response.value
//    {
//      completion(JSON(value), nil)
//    } else if let error = response.error
//    {
//      completion(nil, JSON(error))
//    } else {
//      completion(nil, nil)
//    }
//  }
//  
//  
//  return request


