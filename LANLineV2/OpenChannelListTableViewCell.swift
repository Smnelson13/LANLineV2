//
//  OpenChannelListTableViewCell.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/21/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK

class OpenChannelListTableViewCell: UITableViewCell
{
  @IBOutlet weak var channelName: UILabel!
  
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

}
