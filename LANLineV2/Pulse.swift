//
//  Pulse.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/27/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation


class Pulse
{
  let id: Int
  let title: String
  var summary = "" 
  let image: String
  let url: String
  let author: String
  
  init(pulseDictionary: [String: Any])
  {
    self.id = pulseDictionary["id"] as! Int
    self.title = pulseDictionary["title"] as! String
    self.summary = pulseDictionary["summary"] as! String
    self.image = pulseDictionary["image"] as! String
    self.url = pulseDictionary["url"] as! String
    self.author = pulseDictionary["author"] as! String
  }
  
  convenience init(dictionary: NSDictionary)
  {
    let dict = dictionary as! [String: Any]
    self.init(pulseDictionary: dict)
  }


}

