//
//  Platform.swift
//  
//
//  Created by Shane Nelson on 6/1/17.
//
//

import Foundation

class Platform
{
  let id: Int
  let name: String
  
  init(platformDictionary: [String: Any])
  {
    self.id = platformDictionary["id"] as! Int
    self.name = platformDictionary["name"] as! String
  }
}
