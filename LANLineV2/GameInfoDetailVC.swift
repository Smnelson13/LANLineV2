//
//  GameInfoDetailVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/17/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit

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
 
  @IBAction func doneButton(_ sender: Any)
  {
    self.dismiss(animated: true, completion: nil)
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

    if let screenshotIMG = imageCache[aGame.screenshotUrls[0]]
    {
      screenshotImage.image = screenshotIMG
    }
    else
    {
      if let url = URL(string: aGame.screenshotUrls[0])
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

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
     
  }
  
  

}

//
//extension GameInfoDetailVC: TappedGameInfoProtocol
//{
//  func didRecieveTappedGameInfo(results: [Game])
//    {
//      
//    }
//}
