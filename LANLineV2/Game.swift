//
//  Game.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/15/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation

enum SerializationError: Error
{
  case missing(String)
}

class Game
{
  let release_date: Int
  let id: Int
  let name: String
  var coverUrl: String = ""
  var screenshotUrls = [String]()
  var summary = ""
 
  init(gameDictionary: [String: Any])
  {
    if let release = gameDictionary["first_release_date"] as? Int
    {
      self.release_date = release
    }
    else
    {
      self.release_date = 0
    }
//    self.release_date = (gameDictionary["first_release_date"] as? Int)!
    self.id = gameDictionary["id"] as! Int
    self.name = gameDictionary["name"] as! String
    if let summary = gameDictionary["summary"] as? String
    {
      self.summary =  summary
    }
    
    if let coverDictionary = gameDictionary["cover"] as? [String: Any]
    {
      if let url = coverDictionary["url"] as? String
      {
        coverUrl = "https:" + url
        coverUrl = coverUrl.replacingOccurrences(of: "thumb", with: "cover_small_2x")
      }
    }
    
    if let screenShotArray = gameDictionary["screenshots"] as? [[String: Any]]
    {
      for urlDictionary in screenShotArray
      {
        if let theUrl = urlDictionary["url"] as? String
        {
          var aScreenShotUrl = "https:" + theUrl
          aScreenShotUrl = aScreenShotUrl.replacingOccurrences(of: "thumb", with: "screenshot_med")
          screenshotUrls.append(aScreenShotUrl)
        }
      }
    }
  }
  
  convenience init(dictionary: NSDictionary)
  {
    let dict = dictionary as! [String: Any]
    self.init(gameDictionary: dict)
  }

}

