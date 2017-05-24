//
//  OpenChatVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/23/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK
import SlackTextViewController

class OpenChatVC: SLKTextViewController, SBDChannelDelegate
{
  var channel: SBDOpenChannel!
  var messages = [SBDUserMessage]()
  
  var kIncomingMessageCellIdentifier = "IncomingMessageCell"
  var kUserMessageCellIdentifier = "UserMessageCell"

  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    enterChannel(); loadPreviousMessages()
    
    tableView?.separatorStyle = .none
    tableView?.tableFooterView = UIView()
    tableView?.tableHeaderView = UIView()

    for identifier in [kIncomingMessageCellIdentifier, kUserMessageCellIdentifier]
    {
      let nib = UINib(nibName: identifier, bundle: nil)
      tableView?.register(nib, forCellReuseIdentifier: identifier)
    }

    
    
  }
  
  override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle
  {
    return .plain
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return messages.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
   let cell = tableView.dequeueReusableCell(withIdentifier: kUserMessageCellIdentifier) as! UserMessageCell
    cell.transform = tableView.transform
    cell.outputLabel.text = messages[indexPath.row].message
    
    return cell
  
  }


  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  
  
  // MARK: - Enter Chat Channel
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
  
  override func didPressRightButton(_ sender: Any?)
  {
    if let messageString = textView.text, messageString != ""
    {
      sendMessage(message: messageString)
      textView.text = ""
    }
  }
  
  // MARK: - send message
  func sendMessage(message: String)
  {
    channel.sendUserMessage(message, data: nil, completionHandler: { (userMessage, error) in
      if error != nil {
        NSLog("Error: %@", error!)
        return
      }
      if let msg = userMessage
      {
        self.messages.append(msg)
      }
      
      self.tableView?.reloadData()
      
    })
  }
  
  // MARK: - load previous messages
  func loadPreviousMessages()
  {
    let previousMessageQuery = self.channel.createPreviousMessageListQuery()
    previousMessageQuery?.loadPreviousMessages(withLimit: 30, reverse: true, completionHandler: { (messages, error) in
      if error != nil {
        NSLog("Error: %@", error!)
        return
      }
      
      // messages are SBDBaseMessage objects
      if let previousMessages = messages
      {
     //   self.messages = previousMessages
        // chagne the content of the message arra;y 
        //tell the slack vc to update its view w
      }
      
    })
  }
  
}



//
//class OpenChannelChattingViewController: UIViewController, SBDChannelDelegate
//{
//  
//  // ...
// // SBDMain.add(self as SBDChannelDelegate, identifier: self.delegateIdentifier)
//  
//  // ...
//  
//  func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage)
//  {
//    // ...
//  }
//}


// ViewController.swift

class ViewController: UIViewController, SBDConnectionDelegate, SBDChannelDelegate
{
  func initViewController()
  {
    // ...
    SBDMain.add(self as SBDChannelDelegate, identifier: "234")
    // ...
  }
  
  func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage)
  {
    // Received a chat message
  }
  
  func channelDidUpdateReadReceipt(_ sender: SBDGroupChannel)
  {
    // When read receipt has been updated
  }
  
  func channelDidUpdateTypingStatus(_ sender: SBDGroupChannel)
  {
    // When typing status has been updated
  }
  
  func channel(_ sender: SBDGroupChannel, userDidJoin user: SBDUser)
  {
    // When a new member joined the group channel
  }
  
  func channel(_ sender: SBDGroupChannel, userDidLeave user: SBDUser)
  {
    // When a member left the group channel
  }
  
  func channel(_ sender: SBDOpenChannel, userDidEnter user: SBDUser)
  {
    // When a new user entered the open channel
  }
  
  func channel(_ sender: SBDOpenChannel, userDidExit user: SBDUser)
  {
    // When a new user left the open channel
  }
  
  func channel(_ sender: SBDOpenChannel, userWasMuted user: SBDUser)
  {
    // When a user is muted on the open channel
  }
  
  func channel(_ sender: SBDOpenChannel, userWasUnmuted user: SBDUser)
  {
    // When a user is unmuted on the open channel
  }
  
  func channel(_ sender: SBDOpenChannel, userWasBanned user: SBDUser)
  {
    // When a user is banned on the open channel
  }
  
  func channel(_ sender: SBDOpenChannel, userWasUnbanned user: SBDUser)
  {
    // When a user is unbanned on the open channel
  }
  
  func channelWasFrozen(_ sender: SBDOpenChannel)
  {
    // When the open channel is frozen
  }
  
  func channelWasUnfrozen(_ sender: SBDOpenChannel)
  {
    // When the open channel is unfrozen
  }
  
  func channelWasChanged(_ sender: SBDBaseChannel)
  {
    // When a channel property has been changed
  }
  
  func channelWasDeleted(_ channelUrl: String, channelType: SBDChannelType)
  {
    // When a channel has been deleted
  }
  
  func channel(_ sender: SBDBaseChannel, messageWasDeleted messageId: Int64)
  {
    // When a message has been deleted
  }
}



