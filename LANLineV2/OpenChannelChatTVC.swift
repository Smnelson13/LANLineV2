//
//  OpenChannelTVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/23/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK

class OpenChannelChatTVC: UITableViewController
{
  var channel: SBDOpenChannel!
  //var channelUrl = self.channel._channelUrl
  
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

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int
  {
      // #warning Incomplete implementation, return the number of sections
      return 0
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
      // #warning Incomplete implementation, return the number of rows
      return 0
  }

  // MARK: - enterChannel
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
