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
// write throws after the parentheses for error handleing 

class Game
{
  let id: Int
  let name: String
  var cover: Game.Cover?
  
  init(gameDictionary: [String: Any])
  {
    self.id = gameDictionary["id"] as! Int
    self.name = gameDictionary["name"] as! String
    
    if let coverDictionary = gameDictionary["cover"] as? [String: Any] {
      self.cover = Game.Cover(coverDictionary: coverDictionary)
    }
  }
  
  convenience init(dictionary: NSDictionary)
  {
    let dict = dictionary as! [String: Any]
    self.init(gameDictionary: dict)
  }

  
//  static func gamesWithJSON(json results: [Any]) -> [Game]
//  {
//    var games = [Game]()
//    
//    if results.count > 0
//    {
//      for results in results
//      {
//        if let dictionary = results as? [String: Any]
//        {
//          if let id = dictionary["id"] as? Int
//          {
//            if let name = dictionary["name"] as? String
//            {
//              if let cover = dictionary["cover"] as? [String: Any]
//              {
//                if let coverUrl = cover["url"] as? String
//                {
//                  let aGame = Game(id: id, name: name, coverUrl: coverUrl)
//                  games.append(aGame)
//                }
//              }
//            }
//          }
//        }
//      }
//    }
//    return games
//  }
}

extension Game {
  struct Cover {
    var cloudinary_id: String
    var height: Int
    var width: Int
    var url: String
    
    init(coverDictionary: [String: Any])
    {
      cloudinary_id = coverDictionary["cloudinary_id"] as! String
      height = coverDictionary["height"] as! Int
      width = coverDictionary["width"] as! Int
      url = coverDictionary["url"] as! String
    }
  }
}




