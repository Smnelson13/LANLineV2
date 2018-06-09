//
//  GameChatViewController.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/26/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK
import SlackTextViewController

class GameChatViewController: SLKTextViewController, SBDChannelDelegate
{
  var channel: SBDOpenChannel!
  var aGameChannelUrl: String!
  var baseMessages = [SBDBaseMessage]()
  var kUserMessageCellIdentifier = "UserMessageCell"
  var kIncomingMessageCellIdentifier = "IncomingMessageCell"
  private var userMessage = SBDUserMessage()
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    enterChannel(); loadPreviousMessages(); tableViewCellSetup()
    SBDMain.add(self as SBDChannelDelegate, identifier: "GameChatChannel")

    for identifier in [kIncomingMessageCellIdentifier, kUserMessageCellIdentifier]
    {
      let nib = UINib(nibName: identifier, bundle: nil)
      tableView?.register(nib, forCellReuseIdentifier: identifier)
    }

  }
  
  //MARK: - cell setup
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    guard let userMsg = baseMessages[indexPath.row] as? SBDUserMessage else { return UITableViewCell() }
    
    if userMsg.sender?.userId != Session.shared.user?.userId
    {
      let cell = tableView.dequeueReusableCell(withIdentifier: kIncomingMessageCellIdentifier) as! IncomingMessageCell
      cell.transform = tableView.transform
      cell.outputLabel.text = userMsg.message!
      let dateFormatter = DateFormatter()
      dateFormatter.timeStyle = .short
      dateFormatter.dateStyle = .short
      let createdAtSeconds = Double(userMsg.createdAt) / 1000.0
      let messageCreatedDate = Date(timeIntervalSince1970: createdAtSeconds)
      let messageDateString = dateFormatter.string(from: messageCreatedDate)
      cell.dateLabel.text = messageDateString
      cell.userNameLabel.text = userMsg.sender?.userId ?? ""
      return cell
    }
    else
    {
      let cell = tableView.dequeueReusableCell(withIdentifier: kUserMessageCellIdentifier) as! UserMessageCell
      cell.transform = tableView.transform
      cell.outputLabel.text = userMsg.message!
      let dateFormatter = DateFormatter()
      dateFormatter.timeStyle = .short
      dateFormatter.dateStyle = .short
      let createdAtSeconds = Double(userMsg.createdAt) / 1000.0
      let messageCreatedDate = Date(timeIntervalSince1970: createdAtSeconds)
      let messageDateString = dateFormatter.string(from: messageCreatedDate)
      cell.dateLabel.text = messageDateString
      cell.userNameLabel.text = userMsg.sender?.userId ?? ""
      return cell
    }
  }

  //MARK:-= did press right button AKA send.
  override func didPressRightButton(_ sender: Any?)
  {
    if let messageString = textView.text, messageString != ""
    {
      sendMessage(message: messageString)
      textView.text = ""
    }
  }
  
  //MARK: tableview setup
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return baseMessages.count
  }
  
  override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle
  {
    return .plain
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return UITableViewAutomaticDimension
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
  }

  //MARK: - enter open channel
  func enterChannel()
  {
    SBDOpenChannel.getWithUrl(aGameChannelUrl) { (channel, error) in
      if error != nil
      {
        NSLog("Error: %@", error!)
        return
      }
      
      self.channel = channel
      
      channel?.enter(completionHandler: { (error) in
        if error != nil {
          NSLog("Error: %@", error!)
          return
        }
        print("channel entered successfully")
      })
    }
  }

  //MARK: - send message
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
  
  //MARK: - load previous messages
  func loadPreviousMessages()
  {
    let previousMessageQuery = self.channel?.createPreviousMessageListQuery()
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
  
  //MARK: message insert
  func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage)
  {
    baseMessages.insert(message, at: 0)
    self.tableView?.reloadData()
  }
  
  deinit
  {
    SBDMain.removeChannelDelegate(forIdentifier: "GameChatChannel")
  }
  
  func tableViewCellSetup()
  {
    tableView?.separatorStyle = .none
    tableView?.tableFooterView = UIView()
    tableView?.tableHeaderView = UIView()
    tableView?.estimatedRowHeight = 140
  }
  
  
  
}
