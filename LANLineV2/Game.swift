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
  let coverUrl: String
  
  init(id: Int, name: String, coverUrl: String)
  {
    self.id = id
    self.name = name
    self.coverUrl = coverUrl
  }

  init(gameDictionary: [String:Any])
  {
    self.id = gameDictionary["id"] as! Int
    self.name = gameDictionary["name"] as! String
    self.coverUrl = gameDictionary["cover"] as! String
  }
  
  init(dictionary: NSDictionary)
  {
    id = dictionary["id"] as! Int
    name = dictionary["name"] as! String
    coverUrl = dictionary["url"] as! String
  }

  
  static func gamesWithJSON(json results: [Any]) -> [Game]
  {
    var games = [Game]()
    
    if results.count > 0
    {
      for results in results
      {
        if let dictionary = results as? [String: Any]
        {
          if let id = dictionary["id"] as? Int
          {
            if let name = dictionary["name"] as? String
            {
              if let cover = dictionary["cover"] as? [String: Any]
              {
                if let coverUrl = cover["url"] as? String
                {
                  let aGame = Game(id: id, name: name, coverUrl: coverUrl)
                  games.append(aGame)
                }
              }
            }
          }
        }
      }
    }
    return games
  }
}




