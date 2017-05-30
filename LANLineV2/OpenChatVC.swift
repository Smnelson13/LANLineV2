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

class OpenChatVC: SLKTextViewController
{
  var channel: SBDOpenChannel!
//  var userMessages = [SBDUserMessage]()
  var baseMessages = [SBDBaseMessage]()
  
  var kIncomingMessageCellIdentifier = "IncomingMessageCell"
  var kUserMessageCellIdentifier = "UserMessageCell"

  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    SBDMain.add(self as SBDChannelDelegate, identifier: "OpenChannel")
    
    enterChannel(); loadPreviousMessages()
    
    tableView?.separatorStyle = .none
    tableView?.tableFooterView = UIView()
    tableView?.tableHeaderView = UIView()
    tableView?.estimatedRowHeight = 60

    for identifier in [kIncomingMessageCellIdentifier, kUserMessageCellIdentifier]
    {
      let nib = UINib(nibName: identifier, bundle: nil)
      tableView?.register(nib, forCellReuseIdentifier: identifier)
    }
    //self.navigationItem
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return UITableViewAutomaticDimension
  }
  
  override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle
  {
    return .plain
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return baseMessages.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: kUserMessageCellIdentifier) as! UserMessageCell
    cell.transform = tableView.transform
    if let userMsg = baseMessages[indexPath.row] as? SBDUserMessage
    {
      cell.outputLabel.text = userMsg.message!
      let dateFormatter = DateFormatter()
      dateFormatter.timeStyle = .short
      dateFormatter.dateStyle = .short
      let createdAtSeconds = Double(userMsg.createdAt) / 1000.0
      //print("\(createdAtSeconds)--------------")
      let messageCreatedDate = Date(timeIntervalSince1970: createdAtSeconds)
      //print("\(messageCreatedDate)--------------")
      let messageDateString = dateFormatter.string(from: messageCreatedDate)
      //print(messageDateString+"--------------")
      cell.dateLabel.text = messageDateString

    }
    
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
        self.baseMessages.insert(msg, at: 0)
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
      if let imsgs = messages
      {
        self.baseMessages.append(contentsOf: imsgs)
        DispatchQueue.main.async {
          self.tableView?.reloadData()
        }
      }
      
    })
  }
  
  deinit
  {
    SBDMain.removeChannelDelegate(forIdentifier: "OpenChannel")
  }
  
}


extension OpenChatVC: SBDChannelDelegate
{
  func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage)
  {
    baseMessages.insert(message, at: 0)
    self.tableView?.reloadData()
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



