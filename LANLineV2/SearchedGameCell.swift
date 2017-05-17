//
//  SearchedGameCell.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/15/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit

class SearchedGameCell: UITableViewCell
{
  @IBOutlet weak var gameTitleLabel: UILabel!
  @IBOutlet weak var gameCoverImage: UIImageView!

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
