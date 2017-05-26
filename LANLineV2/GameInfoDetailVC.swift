//
//  GameInfoDetailVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/17/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK
import SVProgressHUD

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
    joinOrCreateChannel()
  }
  
  @IBAction func doneButton(_ sender: Any)
  {
    self.navigationController?.popViewController(animated: true)
  }

//  override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//    
//    let blurView = UIView(frame: screenshotImage.frame)
//    blurView.alpha = 0
//    blurView.backgroundColor = .black
//    view.addSubview(blurView)
//    
//    UIView.animate(withDuration: 0.1)
//    {
//      blurView.alpha = 0.6
//    }
//  }

  
  override func viewDidLoad()
  { super.viewDidLoad()
    
    gameTitle.text = aGame.name
    gameSummary.text = aGame.summary
    coverImage.image = #imageLiteral(resourceName: "blank-66")
    screenshotImage.image = #imageLiteral(resourceName: "Blank_Screenshot")
    
//    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.init(rawValue: Int(2.5))!)
//    let blurView = UIVisualEffectView(effect: blurEffect)
//    blurView.frame = screenshotImage.bounds
//    screenshotImage.addSubview(blurView)
    
    if let img  = imageCache[aGame.coverUrl] // use alamofire image cache to store then clean up old images.
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
    let value: Int = aGame.id
    let channelId = String(describing: value)
    
    SBDOpenChannel.getWithUrl(channelId) { (openChannel, error) in
      if let error = error as NSError?
      {
        switch error.code
        {
        case 400201:
          self.create(completion: self.joinChannel)
        case 1, 2, 3, 4:
          break
          // other errors
        default:
          self.joinChannel()
        }
        return
      }
      
      // Successfully fetched the channel.
      // Do something with openChannel.
    }
  }

  func create(completion:@escaping () -> Void)
  {
    let createChannelUrl = "https://api.sendbird.com/v3/open_channels"
    
    var request = URLRequest(url: URL(string: createChannelUrl)!)
    request.httpMethod = "POST"
    let requestJson = "{\"channel_url\": \"\(aGame.id)\", \"name\": \"\(aGame.name)\"}"
    request.httpBody = requestJson.data(using: .utf8)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("b0208a8138659ed9a752fa268ab5fdf025d3614a", forHTTPHeaderField: "Api-Token")
    // create data task to create game
//    completion()
  }
  
  func joinChannel()
  {
    let value: Int = aGame.id
    let channelId = String(describing: value)
    SBDOpenChannel.getWithUrl(channelId) { (channel, error) in
      if error != nil
      {
        NSLog("Error: %@", error!)
        return
      }
      
      channel?.enter(completionHandler: { (error) in
        if error != nil
        {
          NSLog("Error: %@", error!)
          return
        }
        
       
      })
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "ShowGameChatVC"
    {
    let gameChatVC: GameChatViewController = segue.destination as! GameChatViewController
    let channelId = "\(aGame.id)"
    gameChatVC.aGameChannelUrl = channelId
    
    }
  }

}










