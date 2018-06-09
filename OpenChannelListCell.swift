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
  private var channel: SBDOpenChannel!
  
  @IBOutlet weak var channelNameLabel: UILabel!

  override func awakeFromNib()
  {
      super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool)
  {
      super.setSelected(selected, animated: animated)
  }
  
  func setModel(aChannel: SBDOpenChannel)
  {
    self.channel = aChannel
    self.channelNameLabel.text = self.channel.name
  }


}
