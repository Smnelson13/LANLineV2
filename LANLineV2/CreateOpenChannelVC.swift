//
//  CreateOpenChannelVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK
import SVProgressHUD


class CreateChannelPopoverViewController: UITableViewController
{
  @IBOutlet weak var textField: UITextField?
  
  static func instantiateFromStoryboard() -> CreateChannelPopoverViewController
  {
    let createChannelPopoverViewController = UIStoryboard(name: "CreateChannelPopoverViewController", bundle: nil)
    .instantiateInitialViewController() as! CreateChannelPopoverViewController
    
    createChannelPopoverViewController.setupPopoverStuff()
    return createChannelPopoverViewController
  }

  func setupPopoverStuff()
  {
    preferredContentSize = CGSize(width: 200, height: 88)
    modalPresentationStyle = .popover

    if let controller = popoverPresentationController
    {
      controller.permittedArrowDirections = .any
      controller.delegate = self
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    switch indexPath.row {
    case 1: createChannelButtonWasPressed()
    default: break
    }
  }
  
    //MARK: - Create Channel, this will create a new channel.
    func createChannelButtonWasPressed()
    {
      if let channelName = self.textField?.text, channelName != ""
      {
        view.endEditing(true)
        SVProgressHUD.show(withStatus: "Creating channel...")
        SBDOpenChannel.createChannel(withName: channelName, coverUrl: nil, data: nil, operatorUserIds: nil, completionHandler: { (channel, error) in
        SVProgressHUD.showSuccess(withStatus: "Successfully created channel \"\(channelName)\"")
        SVProgressHUD.dismiss(after: 1, completion: {
        
          self.dismiss(animated: true, completion: nil)
          })
  
          if error != nil
          {
            NSLog("Error: %@", error!)
            return
          }
  
        })
      }
      tableView.reloadData()
    }
}


extension CreateChannelPopoverViewController: UIPopoverPresentationControllerDelegate
{
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
  {
    return .none
  }
}

