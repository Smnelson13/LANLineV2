//
//  APIController.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/15/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation

var platforms = [Int: String]()

protocol APIControllerProtocol
{
  func didReceiveGameInfo(results: [Game])
}

protocol APIPulseControllerProtocol
{
  func didRecievePulseInfo(results: [Pulse])
}

class APIController
{
  var pulse = [Pulse]()
  var games = [Game]()
  let defaultSession = URLSession.shared
  var delegate: APIControllerProtocol?
  var pulseDelegate: APIPulseControllerProtocol?
  
  init(delegate: APIControllerProtocol)
  {
    self.delegate = delegate
  }
  
  init(pulseDelegate: APIPulseControllerProtocol)
  {
    self.pulseDelegate = pulseDelegate
  }
  
  //MARK: get searched gamed info.
  func getGameInfo(searchTerm: String)
  {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
//    "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=20&offset=0&order=popularity%3Adesc&search=\(searchTerm.replacingOccurrences(of: " ", with: "%20"))")
    
//    "https://api-2445582011268.apicast.io/games/?search=\(searchTerm.replacingOccurrences(of: " ", with: "%20)&fields=name,publishers"
    
    let  gameSearchURL = URL(string: "https://api-2445582011268.apicast.io/games/?fields=*&limit=20&offset=0&order=popularity%3Adesc&search=\(searchTerm.replacingOccurrences(of: " ", with: "%20"))")
    // DONT FORGET TO FILTER RELEVANCE. https://igdb.github.io/api/references/filters/
    var request = URLRequest(url: gameSearchURL!)
    request.setValue("4774f5e64252a0b18f62a488293ab738", forHTTPHeaderField: "user-key")
    
    let task = defaultSession.dataTask(with: request) { data, response, error in
      defer {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
      }
      
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

  //MARK: - get tapped game info.  /games/1942?fields=*
  //https://igdbcom-internet-game-database-v1.p.mashape.com/games/\(gameId)?fields=*")
  func getTappedGameInfo(gameId: String)
  {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    let gameSearchURL = URL(string: "https://api-2445582011268.apicast.io/games\(gameId)/?fields=*")
    var request = URLRequest(url: gameSearchURL!)
    request.setValue("4774f5e64252a0b18f62a488293ab738", forHTTPHeaderField: "user-key")
    let task = defaultSession.dataTask(with: request) { data, response, error in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      if let error = error
      {
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
  
  //MARK:- get pulse
  func getPulse()
  {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    //https://api-2445582011268.apicast.io/games/?fields=*&order=published_at:desc&limit=20
    
    let pulseSearchURL = URL(string: "https://api-2445582011268.apicast.io/pulses/?fields=*&order=published_at:desc&limit=20")
    var request = URLRequest(url: pulseSearchURL!)
    request.setValue("4774f5e64252a0b18f62a488293ab738", forHTTPHeaderField: "user-key")
    
    let task = defaultSession.dataTask(with: request) { data, response, error in
       UIApplication.shared.isNetworkActivityIndicatorVisible = false
      if let error = error {
        print( "DataTask Error: " + error.localizedDescription + "\n")
      } else if let data = data {
        if let httpResponse = response as? HTTPURLResponse
        {
          if httpResponse.statusCode == 200 // Ok
          {
            if let array = self.parseJSON(data)
            {
              var pulse = [Pulse]()
              for pulseDictionary in array
              {
                let aPulse = Pulse(pulseDictionary: pulseDictionary)
                pulse.append(aPulse)
              }
              
              self.pulseDelegate?.didRecievePulseInfo(results: pulse)
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
  
  //MARK: - ParseJSON
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
