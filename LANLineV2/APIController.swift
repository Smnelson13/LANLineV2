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
  func didReceive(results: Any)
}

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
  { // to get more from this call add something after the name separated by a comma 
    let gameSearchURL = URL(string: "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=name,cover&limit=10&offset=0&order=release_dates.date%3Adesc&search=\(searchTerm)")

    var request = URLRequest(url: gameSearchURL!)
    request.setValue("O00cNpvM31mshvqfuQ9JmsGw9hu0p1pAGLSjsnthxuO2oNLR9o", forHTTPHeaderField: "X-Mashape-Key")
    
    let task = defaultSession.dataTask(with: request) { data, response, error in
      if let error = error {
        print( "DataTask Error: " + error.localizedDescription + "\n")
      } else {
        if let array = self.parseJSON(data!)
        {
          for gameDictionary in array
          {
            
          }
        }
        
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

