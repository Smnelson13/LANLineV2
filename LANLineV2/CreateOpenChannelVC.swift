//
//  CreateOpenChannelVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK

class CreateOpenChannelVC: UIViewController
{
  @IBOutlet weak var channelName: UITextField!

@IBAction func doneButtonTapped(_ sender: Any)
{
  self.dismiss(animated: true, completion: nil)
}
  override func viewDidLoad()
  {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  @IBAction func createButtonTapped(_ sender: Any)
  {
    SBDOpenChannel.createChannel(withName: channelName.text, coverUrl: nil, data: nil, operatorUserIds: nil, completionHandler: { (channel, error) in
      if error != nil {
        NSLog("Error: %@", error!)
        return
      }
      
      // ...
    })
  }

}



/*
 SBDOpenChannel.createChannel(withName: self.channelName.text, coverUrl: nil, data: nil, operatorUsers: nil) { (channel, error) in
 if error != nil {
 let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
 let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
 vc.addAction(closeAction)
 DispatchQueue.main.async {
 self.present(vc, animated: true, completion: nil)
 }
 
 return
 }
 
 }
 
 }

 */
