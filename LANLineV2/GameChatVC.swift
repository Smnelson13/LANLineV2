//
//  GameChatVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/26/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SlackTextViewController
import SendBirdSDK

class GameChatVC: SLKTextViewController
{
  var aGameChannelUrl: String!
  //var aGame: Game!
  //var games = [Game]()
  var channel: SBDOpenChannel!
  //  var userMessages = [SBDUserMessage]()
  var baseMessages = [SBDBaseMessage]()
  
  var kIncomingMessageCellIdentifier = "IncomingMessageCell"
  var kUserMessageCellIdentifier = "UserMessageCell"
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    SBDMain.add(self as SBDChannelDelegate, identifier: "GameChatChannel")
    
    // enterChannel()
    //loadPreviousMessages()
    
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
    }
    
    return cell
  }
  
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
 
  func enterChannel()
  {
    SBDOpenChannel.getWithUrl(aGameChannelUrl) { (channel, error) in
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
  
  func sendMessage(message: String)
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
    SBDMain.removeChannelDelegate(forIdentifier: "GameChatChannel")
  }
  
}


extension GameChatVC: SBDChannelDelegate
{
  func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage)
  {
    baseMessages.insert(message, at: 0)
    self.tableView?.reloadData()
  }
  
}



