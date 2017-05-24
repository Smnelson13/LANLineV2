//
//  GameInfoDetailVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/17/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK

class GameInfoDetailVC: UIViewController
{
  var imageCache = [String: UIImage]()
  var games = [Game]()
  var aGame: Game!
  //let aGame = games[indexPath.row]
  
  @IBOutlet weak var screenshotImage: UIImageView!
  @IBOutlet weak var coverImage: UIImageView!
  @IBOutlet weak var gameTitle: UILabel!
  @IBOutlet weak var gameSummary: UITextView!
  
  @IBAction func joinChatButton(_ sender: Any)
  {
    
  }
  
  @IBAction func doneButton(_ sender: Any)
  {
    self.navigationController?.popViewController(animated: true)
  }

  override func viewDidLoad()
  { super.viewDidLoad()
    
    gameTitle.text = aGame.name
    gameSummary.text = aGame.summary
    coverImage.image = #imageLiteral(resourceName: "blank-66")
    screenshotImage.image = #imageLiteral(resourceName: "Blank_Screenshot")
    
    if let img  = imageCache[aGame.coverUrl]
    {
      coverImage.image = img
    }
    else
    {
      if let url = URL(string: aGame.coverUrl)
      {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {
          data, response,error in
          if error == nil
          {
            let image = UIImage(data: data!)
            self.imageCache[(self.aGame.coverUrl)] = image
            DispatchQueue.main.async {
              self.coverImage.image = image
            }
          }
          }.resume()
      }
    }

    if aGame.screenshotUrls.count > 0
    {
      if let screenshotIMG = imageCache[aGame.screenshotUrls[Int(arc4random_uniform(UInt32(aGame.screenshotUrls.count)))]]
      {
        screenshotImage.image = screenshotIMG
      }
      else
      {
        if let url = URL(string: aGame.screenshotUrls[Int(arc4random_uniform(UInt32(aGame.screenshotUrls.count)))])
        {
          let request = URLRequest(url: url)
          URLSession.shared.dataTask(with: request) {
            data, response,error in
            if error == nil
            {
              let image = UIImage(data: data!)
              self.imageCache[(self.aGame.coverUrl)] = image
              DispatchQueue.main.async {
                self.screenshotImage.image = image
              }
            }
            }.resume()
        }
      }
      
    }
    
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
     
  }
  
  func joinOrCreateChannel()
  {
    func test()
    {
      let value: Int = aGame.id
      let channelUrl = String(describing: value)
      SBDOpenChannel.getWithUrl(channelUrl) { (channel, error) in
        if let error = error as NSError?
        {
          if error.code == 400201
          {
            SBDOpenChannel.createChannel(withName: self.aGame.name, coverUrl: channelUrl, data: nil, operatorUserIds: nil, completionHandler: { (channel, error) in
              if error != nil {
                NSLog("Error: %@", error!)
                return
              }
              
              // ...
            })
          }
          NSLog("Error: %@", error)
          return
        }
        
        
        
        
        
        channel?.enter(completionHandler: { (error) in
          if error != nil {
            NSLog("Error: %@", error!)
            return
          }
          
          // ...
        })
      }
      
    }

  }
  
  
}

extension GameInfoDetailVC
{
  
  
  
  
  func channelAutoCreate()
  {
    
  }
}

