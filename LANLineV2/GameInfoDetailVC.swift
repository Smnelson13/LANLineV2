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
    
    //screenshotImage.image = aGame.screenshotUrls
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */

}
