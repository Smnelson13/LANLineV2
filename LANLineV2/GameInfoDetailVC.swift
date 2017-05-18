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
  var games = [Game]()
  var aGame: Game!
  //let aGame = games[indexPath.row]
  
  @IBOutlet weak var screenshotImage: UIImageView!
 
  @IBAction func doneButton(_ sender: Any)
  {
    self.dismiss(animated: true, completion: nil)
  }

  override func viewDidLoad()
  {
      super.viewDidLoad()
    
    
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
