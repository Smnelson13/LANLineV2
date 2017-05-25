//
//  ChannelBrain.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/23/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation
import SendBirdSDK

class ChannelBrain
{
  func getChannelWithUrl()
  {
    SBDOpenChannel.getWithUrl("123456") { (channel, error) in
      if error != nil
      {
        NSLog("Error: %@", error!)
        
        print("channel exists")
        
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
