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
  var messages = [SBDBaseMessage]()
  
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
  
//  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//  {
//  //  return messages.count
//  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  override func didPressRightButton(_ sender: Any?)
  {
    if let messageString = textView.text, messageString != ""
    {
      send(message: messageString)
      textView.text = ""
    }
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
  
  // MARK: - send message
  func send(message: String)
  {
    channel.sendUserMessage(message, data: nil, completionHandler: { (userMessage, error) in
      if error != nil {
        NSLog("Error: %@", error!)
        return
      }
      
      // ...
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
        self.messages = previousMessages
        // chagne the content of the message arra;y 
        //tell the slack vc to update its view w
      }
      
    })
  }
  
  
  
}
