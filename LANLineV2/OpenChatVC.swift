//
//  OpenChatVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/23/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK
import SlackTextViewController

class OpenChatVC: SLKTextViewController
{
  var channel: SBDOpenChannel!

  override func viewDidLoad()
  {
    super.viewDidLoad()

    enterChannel()
    
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: - Enter Chat Channel
  func enterChannel()
  {
    SBDOpenChannel.getWithUrl(channel.channelUrl) { (channel, error) in
      if error != nil {
        NSLog("Error: %@", error!)
        return
      }
      
      channel?.enter(completionHandler: { (error) in
        if error != nil {
          NSLog("Error: %@", error!)
          return
        }
        
        // ...
        print("Successfully entered channel.")
      })
    }
    
  }


}
