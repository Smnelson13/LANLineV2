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
//  let category: Int
  let title: String
  var summary = "" 
  let image: String
  let url: String
//  let uid: String
//  let author: String
//  let created_at: Int
//  let updated_at: Int
//  let pulse_source: Int
//  let published_at: Int
//  let tags: [Int]
  
  init(pulseDictionary: [String: Any])
  {
    self.id = pulseDictionary["id"] as! Int
 //   self.category = pulseDictionary["category"] as! Int
    self.title = pulseDictionary["title"] as! String
    self.summary = pulseDictionary["summary"] as! String
    self.image = pulseDictionary["image"] as! String
    self.url = pulseDictionary["url"] as! String
//    self.created_at = pulseDictionary["created_at"] as! Int
//    self.updated_at = pulseDictionary["updated_at"] as! Int
//    self.pulse_source = pulseDictionary["pulse_source"] as! Int
//    self.published_at = pulseDictionary["published_at"] as! Int
//   self.tags = pulseDictionary["tags"] as! [Int]
//    self.author = pulseDictionary["author"] as! String
 //   self.uid = pulseDictionary["uid"] as! String
  }
  
  convenience init(dictionary: NSDictionary)
  {
    let dict = dictionary as! [String: Any]
    self.init(pulseDictionary: dict)
  }
  











}

