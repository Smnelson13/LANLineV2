//
//  BrainTestViewController.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/23/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK
import Foundation



func creatChannel()
{
  let channelCreateUrl = "https://api.sendbird.com/v3/open_channels"

  
  var request = URLRequest(url: URL(string: "https://api.sendbird.com/v3/open_channels")!)
  request.httpMethod = "POST"
  let postString = "id=13&name=Jack"
  request.httpBody = postString.data(using: .utf8)
  let task = URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data, error == nil else {                                                 // check for fundamental networking error
      print("error=\(String(describing: error))")
      return
    }
    
    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
      print("statusCode should be 200, but is \(httpStatus.statusCode)")
      print("response = \(String(describing: response))")
    }
    
    let responseString = String(data: data, encoding: .utf8)
    print("responseString = \(String(describing: responseString))")
  }
  task.resume()
}
