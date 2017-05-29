//
//  GameNewsCell.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/27/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit

class GameNewsCell: UITableViewCell
{
  @IBOutlet weak var backGroundImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!

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
