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
  let blurRadius: CGFloat = 4
  var imageCache = [String: UIImage]()
  var games = [Game]()
  var aGame: Game!

  @IBOutlet weak var releaseDate: UILabel!
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
  
  override func viewDidLoad()
  { super.viewDidLoad()
    
    gameTitle.text = aGame.name
    gameSummary.text = aGame.summary
    coverImage.image = #imageLiteral(resourceName: "blank-66")
    screenshotImage.image = #imageLiteral(resourceName: "Blank_Screenshot")
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    let createdAtSeconds = Double(aGame.release_date) / 1000.0
    let messageCreatedDate = Date(timeIntervalSince1970: createdAtSeconds)
    let messageDateString = dateFormatter.string(from: messageCreatedDate)
    releaseDate.text = messageDateString
 
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
                let blurredImage = image?.applyBlur(withRadius: self.blurRadius, tintColor: UIColor(white: 0.5, alpha: 0.2), saturationDeltaFactor: 1.8, maskImage: nil)
                self.screenshotImage.image = blurredImage
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
          self.create(completion: { success in
            if success
            {
              print("SUCCESS--------------------")
              self.joinOrCreateChannel()
            } else {
              SVProgressHUD.showError(withStatus: "Could not create channel")
            }
          })
          
        case 1, 2, 3, 4:
          break
          // other errors
        default:
          break
        }
        return
      } else if let channel = openChannel {
        self.joinChannel(channel: channel)
      } else {
        fatalError("channel couldn't be created and doesn't exist")
      }
      
    }
  }

  func create(completion:@escaping (_ success: Bool) -> Void)
  {
    let createChannelUrl = "https://api.sendbird.com/v3/open_channels"
    var request = URLRequest(url: URL(string: createChannelUrl)!)
    request.httpMethod = "POST"
    let requestJson = "{\"channel_url\": \"\(aGame.id)\", \"name\": \"\(aGame.name)\"}"
    request.httpBody = requestJson.data(using: .utf8)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("b0208a8138659ed9a752fa268ab5fdf025d3614a", forHTTPHeaderField: "Api-Token")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      completion(error == nil)
    }.resume()
  }
  
  func joinChannel(channel: SBDOpenChannel) {
    channel.enter(completionHandler: { (error) in
      if error != nil
      {
        NSLog("Error: %@", error!)
        return
      }
      
      self.performSegue(withIdentifier: "ShowGameChatVC", sender: channel)
    })
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "ShowGameChatVC",
      let gameChatVC = segue.destination as? GameChatViewController,
      let channel = sender as? SBDOpenChannel
    {
      let channelId = "\(aGame.id)"
      gameChatVC.aGameChannelUrl = channelId
      gameChatVC.channel = channel
    }
    else
    {
    
    }
  }

}










