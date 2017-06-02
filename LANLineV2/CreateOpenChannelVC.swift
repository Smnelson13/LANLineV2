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

protocol DidCreateChannelProtocol
{
  func createChannelButtonTapped()
}

class CreateChannelPopoverViewController: UITableViewController
{
  var createdChannelDelegate: DidCreateChannelProtocol?
  @IBOutlet weak var textField: UITextField?
  
  static func instantiateFromStoryboard() -> CreateChannelPopoverViewController
  {
    let createChannelPopoverViewController = UIStoryboard(name: "CreateChannelPopoverViewController", bundle: nil)
    .instantiateInitialViewController() as! CreateChannelPopoverViewController
    
    createChannelPopoverViewController.setupPopoverStuff()
    return createChannelPopoverViewController
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    textField?.delegate = self
  }

  //MARK: - setup popover
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
  
  //MARK: - createa channel button pressesd
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    switch indexPath.row {
    case 1: createChannelButtonWasPressed()
    default: break
    }
  }
  
    //MARK: - Create new opwn Channel
    func createChannelButtonWasPressed()
    {
      if let channelName = self.textField?.text, channelName != ""
      {
        view.endEditing(true)
        SVProgressHUD.show(withStatus: "Creating channel...")
        SBDOpenChannel.createChannel(withName: channelName, coverUrl: nil, data: nil, operatorUserIds: nil, completionHandler: { (channel, error) in
        SVProgressHUD.showSuccess(withStatus: "Successfully created channel \"\(channelName)\"")
        self.createdChannelDelegate?.createChannelButtonTapped()
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
    }
}

//MARK: - extension createa channel popever
extension CreateChannelPopoverViewController: UIPopoverPresentationControllerDelegate
{
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
  {
    return .none
  }
}

//MARK: - extensionn popover textfield delegate
extension CreateChannelPopoverViewController: UITextFieldDelegate
{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    createChannelButtonWasPressed()
    return textField.text != ""
  }
}

