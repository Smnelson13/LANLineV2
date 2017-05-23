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


/*
class CreateOpenChannelVC: UIViewController
{
  @IBOutlet weak var channelNameTextField: UITextField! // JUST IMAGINE THIS SAYS CHANNELNAMETEXTFIELD.... CARRY ON.

  @IBAction func doneButtonTapped(_ sender: Any)
  {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad()
  {
      super.viewDidLoad()
  }
  
  @IBAction func createButtonTapped(_ sender: Any)
  {
    if let text = channelNameTextField.text
    {
      SVProgressHUD.show(withStatus: "Creating channel...")
      SBDOpenChannel.createChannel(withName: text, coverUrl: nil, data: nil, operatorUserIds: nil, completionHandler: { (channel, error) in
        SVProgressHUD.showSuccess(withStatus: "Successfully created channel \"\(text)\"")
        
        SVProgressHUD.dismiss(after: 1, completion: {
          self.dismiss(animated: true, completion: nil)
        })
        
        if error != nil {
          NSLog("Error: %@", error!)
          return
        }
        
        // ...
      })
    }
  }

}
*/

class CreateChannelPopoverViewController: UITableViewController
{
  @IBOutlet weak var textField: UITextField?
  
  static func instantiateFromStoryboard() -> CreateChannelPopoverViewController {
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
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
  
          // ...
        })
      }
    }
}


//
//class CreateChannelPopoverViewController: FormViewController
//{
//  
//  var channelName: String = ""
//  
//  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
//  {
//    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    sharedInit()
//  }
//  
//  override init(style: UITableViewStyle)
//  {
//    super.init(style: style)
//    sharedInit()
//  }
//  
//  required init?(coder aDecoder: NSCoder)
//  {
//    super.init(coder: aDecoder)
//    sharedInit()
//  }
//  
//  func sharedInit()
//  {
//    preferredContentSize = CGSize(width: 200, height: 150)
//    modalPresentationStyle = .popover
//    
//    if let controller = popoverPresentationController
//    {
//      controller.permittedArrowDirections = .any
//      controller.delegate = self
//    }
//  }
//  
//  override func viewDidLoad()
//  {
//    super.viewDidLoad()
//    
//    view.tintColor = .primaryPurple
//
//    form +++ Section()
//    
//    <<< TextRow { row in
//      row.tag = "textField"
//    }.cellSetup { cell, row in
//      cell.textField.becomeFirstResponder()
//    }.onChange { row in
//      self.channelName = row.value ?? ""
//    }
//      
//    <<< ButtonRow { row in
//      row.title = "Create Channel"
//    }.cellUpdate { cell, row in
//      cell.textLabel?.textColor = .primaryPurple
//    }.onCellSelection { cell, row in
//      self.createChannelButtonWasPressed()
//    }
//    
//    
//  }
//  
//  //MARK: - Create Channel, this will create a new channel. 
//  func createChannelButtonWasPressed()
//  {
//    if channelName != ""
//    {
//      view.endEditing(true)
//      
//      SVProgressHUD.show(withStatus: "Creating channel...")
//      SBDOpenChannel.createChannel(withName: channelName, coverUrl: nil, data: nil, operatorUserIds: nil, completionHandler: { (channel, error) in
//        SVProgressHUD.showSuccess(withStatus: "Successfully created channel \"\(self.channelName)\"")
//        
//        SVProgressHUD.dismiss(after: 1, completion: {
//          self.dismiss(animated: true, completion: nil)
//        })
//        
//        if error != nil
//        {
//          NSLog("Error: %@", error!)
//          return
//        }
//        
//        // ...
//      })
//    }
//  }
//
//}


extension CreateChannelPopoverViewController: UIPopoverPresentationControllerDelegate
{
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
  {
    return .none
  }
}

