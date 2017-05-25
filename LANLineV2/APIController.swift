//
//  APIController.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/15/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation


protocol APIControllerProtocol
{
  func didReceiveGameInfo(results: [Game])
}

//protocol TappedGameInfoProtocol
//{
//  func didRecieveTappedGameInfo(results: [Game])
//}


class APIController
{
  var games = [Game]()
  let defaultSession = URLSession.shared
  var delegate: APIControllerProtocol?
  
  init(delegate: APIControllerProtocol)
  {
    self.delegate = delegate
  }
  
  
  func getGameInfo(searchTerm: String)
  { // to get more from this call add something after the name separated by a comma/ change release_date.date to popularity or others
    let  gameSearchURL = URL(string: "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=10&offset=0&order=popularity%3Adesc&search=\(searchTerm.replacingOccurrences(of: " ", with: "%20"))")

    // DONT FORGET TO FILTER RELEVANCE. https://igdb.github.io/api/references/filters/
    
    var request = URLRequest(url: gameSearchURL!)
    request.setValue("O00cNpvM31mshvqfuQ9JmsGw9hu0p1pAGLSjsnthxuO2oNLR9o", forHTTPHeaderField: "X-Mashape-Key")
    
    let task = defaultSession.dataTask(with: request) { data, response, error in
      if let error = error {
        print( "DataTask Error: " + error.localizedDescription + "\n")
      } else if let data = data {
        if let httpResponse = response as? HTTPURLResponse
        {
          if httpResponse.statusCode == 200 // Ok
          {
            if let array = self.parseJSON(data)
            {
              var games = [Game]()
              for gameDictionary in array
              {
                let game = Game(gameDictionary: gameDictionary)
                games.append(game)
              }
              
              self.delegate?.didReceiveGameInfo(results: games)
            }
          }
          else if httpResponse.statusCode == 429 // Rate limit reached
          {
            print("Rate Limit Reached")
          }
        }
        
        
      } else {
        
        print("requestError")
      }
    }
    task.resume()
    print(request)
  }
  
  
  
  func getTappedGameInfo(gameId: String)
  { 
    let gameSearchURL = URL(string: "https://igdbcom-internet-game-database-v1.p.mashape.com/games/\(gameId)?fields=*")

    var request = URLRequest(url: gameSearchURL!)
    request.setValue("O00cNpvM31mshvqfuQ9JmsGw9hu0p1pAGLSjsnthxuO2oNLR9o", forHTTPHeaderField: "X-Mashape-Key")
    
    
    
    let task = defaultSession.dataTask(with: request) { data, response, error in
      if let error = error {
        print( "DataTask Error: " + error.localizedDescription + "\n")
      } else if let data = data {
        if let httpResponse = response as? HTTPURLResponse
        {
          if httpResponse.statusCode == 200 // Ok
          {
            if let array = self.parseJSON(data)
            {
              var games = [Game]()
              for gameDictionary in array
              {
                let game = Game(gameDictionary: gameDictionary)
                games.append(game)
              }
              
              self.delegate?.didReceiveGameInfo(results: games)
            }
          }
          else if httpResponse.statusCode == 429 // Rate limit reached
          {
            print("Rate Limit Reached")
          }
        }
        
        
      } else {
        
        print("requestError")
      }
    }
    task.resume()
    print(request)
  }

  
  
  
  
  
  func parseJSON(_ data: Data) -> [[String: Any]]?
  {
    do
    {
      let json = try JSONSerialization.jsonObject(with: data, options: [])
      if let array = json as? [[String: Any]]
      {
        print(array)
        return array
      }
      else
      {
        return nil
      }
    }
    catch
    {
      print(error)
      return nil
    }
  }


  

}

