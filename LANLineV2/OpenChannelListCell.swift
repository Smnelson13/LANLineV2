//
//  OpenChannelListCell.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//
import SendBirdSDK
import UIKit

class OpenChannelListCell: UITableViewCell
{
  @IBOutlet weak var channelNameLabel: UILabel!

  override func awakeFromNib()
  {
      super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool)
  {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }
  
//  let query = SBDOpenChannel.createOpenChannelListQuery()!
//  query.loadNextPage(completionHandler: { (channels, error) in
//  if error != nil {
//  NSLog("Error: %@", error!)
//  return
//  }
//  
//  
//  
//  })
//
}
